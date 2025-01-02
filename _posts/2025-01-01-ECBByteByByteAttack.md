---
title: ECB Byte-by-byte attack 
categories: [Science]
---

Assume we have access to an encryption scheme which, given an input $\beta$,
encrypts $\alpha \beta \gamma$, where $\alpha, \gamma$ are unknown. Our task
is to decrypt the content of $\gamma$. Assume that we know that the length of
$\alpha$ is of at most 16-bytes.

If we knew the exact length $\ell$ of $\alpha$, then producing an input of length 
$31 - \ell$ would make the scheme encrypt 


$$
\alpha_1 \ldots \alpha_{\ell} \beta_1 \ldots \beta_{31 - \ell} \gamma_1 \gamma_2 \ldots
$$

where the second 16-byte block has as final byte $\gamma_1$. This would allow us to easily 
decrypt $\gamma_1$, with in turn would allow us to decrypt $\gamma_2$, and so on. So the 
question becomes how can we determine the length of $\alpha$.

Fortunately for us, this is quite simple. Simply let $\beta$ be an arbitrary
string of 16-bytes. If the length of $\alpha$ is zero, then the encryption
scheme would encrypt $\beta_1 \ldots \beta_{16} \gamma_1 \ldots \gamma_{16}
\gamma_{17} \ldots$. This means for any pair of 16-byte strings $\beta_1,
\beta_2$, the encryption of the first block would differ, but that of the
second block would remain the same.

If the length of $\alpha$ is 1, then choosing two 15-byte strings $\beta_1, \beta_2$ would 
again ensure that the encryption of the first block differs, but that of the second block remains the same.
This generalizes: if $|\alpha| = k$, then for any pair $\beta_1, \beta_2$ of length $16 - k$, we have:

- The encryption with input $\beta_1, \beta_2$ produces the same second block but different first blocks.
- The encryption with input $\beta_1', \beta_2'$ strings of length superior to $16 - k$ produces different 
first blocks and different second blocks.

Thus, it is quite easy to deduce $|alpha|$ with a for loop, given in pseudo-code below.

``` go
sizeOfAlpha(){
    for i := 16; i >= 0; i-- {
        aWord, bWord := repeat("A", 16 - i), repeat("B", 16 - i)
        aEncryption, bEncryption = encryption(aWord), encryption(bWord)
        if firstBlock(aEncryption) != firstBlock(bEncryption) && secBlock(aEncryption) == secBlock(bEncryption){
            return 16 - i
        }
    }
}
```

Having deduced the size of $\alpha$, we proceed with a byte-to-byte attack to
decrypt $\gamma$. The attack is simple: first, produce an input which ensures
that the last byte of the second block is the first (unknown) byte of $\gamma$.
This is easy to do knowing the length of $\alpha$. Thus, the second block is the 
encryption $\beta'\gamma_1$ where $\beta'$ is of length 15-bytes and is a tail of 
$\beta$. Then, encrypt with input $\beta'x$ iterating $x$ over all possible bytes,
until a byte matches the previous encryption. Such byte is $\gamma_1$.

The process is repeated: give an input $\beta'$ of length $15-bytes$, ensure the last
two encrypted bytes are $\gamma_1 \gamma_2$. Since $\gamma_1$ is known, encrypt 
with $\alpha'\gamma_1 x$, looping $x$ across all possible bytes until a match is found.
This repeats until the first block of $\gamma$ is known.

Importantly, when we compare the encryptions with input $\beta'$ and $\beta'
x$ (with $x$ a variable), we do not compare the whole encryption but only the
block upon which we are working. Since the first block of the encryption corresponds 
to $\alpha$ (plus the head of $\beta$), it is the second block of the
encryption the one that corresponds to the first block of $\gamma$.
Inductively, it is the $k+1$th block of the encryption the one that corresponds
to the $k$th block of $\gamma$.

With some simple omissions, this is some code in Golang which makes the decryption effective.


```go

func 𝒪(plaintext []byte) ([]byte, error){
    b64string := readFile("appendingString.txt")
    α, e := base64.StdEncoding.DecodeString(b64string)

    if e != nil{
        return nil, fmt.Errorf("Error decoding the appending string.")
    }
    m := append(plaintext, α...)
    m = append(RAN_PRE, m...)
    encryption, e := encryptAES128ECB(m, KEY)
    if e != nil{
        return nil, fmt.Errorf("Error encrypting plaintext || appending string")
    }
    return encryption, nil
}

func inferPreppendSize() (int, error){

   
    for k := 16; k >= 0; k--{
        α := []byte( strings.Repeat("A", k) )
        β := []byte( strings.Repeat("X", k) )
        αEncryption, αe := 𝒪(α)
        βEncryption, βe := 𝒪(β)
        if αe != nil || βe != nil {break}

        differentFirstBlocks := !testSliceEq( getBlock(αEncryption, 0), getBlock(βEncryption, 1) )
        equalSecondBlocks := testSliceEq( getBlock(αEncryption, 1), getBlock(βEncryption, 1) )

        if differentFirstBlocks && equalSecondBlocks{
            return 16 - k, nil
        }

    }

    return -1, fmt.Errorf("Failed to infer preppended byte stream size.")
    
}

func inferAppendSize() (int, error){
    E, e1 := 𝒪([]byte(""))
    k, e2 := inferPreppendSize()
    if e1 != nil || e2 != nil {return -1, fmt.Errorf("Error inferring append size")}
    return len(E) - k, nil
}

func decrypt() ([]byte, error){

    var decryption []byte 
    preppendSize, e1:= inferPreppendSize() // α is the preppend string
    appendSize, e2 := inferAppendSize() // β is the appended string
    if e1 != nil || e2 != nil {return nil, fmt.Errorf("Error finding preppendSize")}

    for i := 0; i < appendSize; i++ {
        inputLength := 31 -  preppendSize - i%16
        α := []byte( strings.Repeat("A", inputLength) )
        encryption, err := 𝒪(α) // 𝒪 is the encryption scheme.

        if err != nil{
            return nil, fmt.Errorf("Error in 𝒪-encryption.")
        }

        // Get the block which contains the γ-byte we are decrypting.
        // Second block for i in [0, 15], third block for i in [16, 31], etc. (Recall: first block will have α and some β)
        blockIndex := i / 16 + 1 
		block  := getBlock(encryption, blockIndex)
        hexEncryption := hex.EncodeToString(block)

        // Append to the input string the bytes of γ we have already decyphered.
        head := append(α, decryption...)
        // Find the byte which, appended to `head`, gives an `_encryption` matching `encryption`.
        for b := 0; b < 256; b++ {
            b := byte(b)
            _encryption , err := 𝒪(append(head, b))
            if err != nil{
                return nil, fmt.Errorf("Error in 𝒪-encryption.")
            }
            _block := getBlock(_encryption, blockIndex)
            _hexEncryption := hex.EncodeToString(_block)
            if hexEncryption == _hexEncryption { 
                decryption = append(decryption, b)
                break
            }
        }
    }
    return decryption, nil
}
```

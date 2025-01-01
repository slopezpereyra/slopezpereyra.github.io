---
title: ECB Byte-by-byte attack 
categories: [Science]
---

Let $\beta$ be a fixed but unknown word, and let $\vec{\beta}$ denote the byte
stream $\beta_0\ldots \beta_k$ of which $\beta$ is the string representation.
Assume we have input control of a system $S$ which, given a word $\alpha$,
encrypts $\alpha \beta$ with AES ECB 128 and returns the encryption
$\mathcal{E}(\alpha\beta)$. The question is: can we break the encryption to
infer $\beta$?

This scenario is a paradigmatic example of the weaknesses of ECB mode. Decrypting
$\alpha\beta$ (and hence $\beta$) happens to be quite simple. 

Take $\vec{ \alpha } := \alpha_0 \ldots \alpha_{15}$ be an arbitrary $16$-byte stream and feed it to the system. Then the first block of the encryption $\mathcal{E}(\alpha\beta)$ is 

$$
C_0 := \mathcal{E}(\alpha_0 \ldots \alpha_{15}\beta_0)
$$

Now one may simply input into the system $\alpha_0\ldots \alpha_{15}x$ with $x$
all possible bytes, until some $x_0$ produces $C_0$. This entails $x_0 =
\beta_0$ and thus we have decrypted the first byte of $\beta$. It is 
straightforward to generalize this method by letting 

$$
C_i := \mathcal{E}(\alpha_0\ldots \alpha_{15-i}\beta_0 \ldots \beta_i)
$$

and solving it by inputting into the system $\alpha_0\ldots \alpha_{15 - i} \beta_0 \ldots \beta_{i-1}x$ with $x$ all possible bytes, until some $x_0$ produces $C_i$. (Of course, $i = 0 \ldots ( |\beta|-1 )$ and we assume $\gamma_{i-1} = \varepsilon$ if $i = 0$).

We can simulate this system by storing an unknown, base64-encoded string `β` in
a file `appendingString.txt`, and producing the encryptions of an arbitrary
input to which this string is appended. In a real scenario, the length of `β`
will be unknown, but the loop could be stopped with a condition check.
We assume in the code below that `𝒪` is a function which encrypts an input
byte-stream *after* appending to it the unknown string `β`.

```go
func decrypt() ([]byte, error){
    // We read β only to iterate bound the for loop with its length;
    // otherwise we presume β is utterly unknown to us.
    b64string := readFile("appendingString.txt")
    β, _ := base64.StdEncoding.DecodeString(b64string)
    
    // decryption will hold the inferred bytes of β
    var decryption []byte 
    for i := 0; i < len(β); i++ {
        inputLength := 15 - i%16
        α := []byte( strings.Repeat("A", inputLength) )
        encryption, err := 𝒪(α)

        if err != nil{
            return nil, fmt.Errorf("Error in 𝒪-encryption.")
        }

        // Hex-encode the first block for i ∈ [0, 15], the second block 
        // for i ∈ [16, 31], etc.
        hexEncryption := hex.EncodeToString(encryption[:16*(i/16 + 1)])

        // Append to α the already inferred bytes.
        head := append(α, decryption...)
        // Loop through all possible bytes
        for b := 0; b < 256; b++ {
            b := byte(b)
            // Encrypt with varying last byte until a match is found.
            _encryption , err := 𝒪(append(head, b))
            if err != nil{
                return nil, fmt.Errorf("Error in 𝒪-encryption.")
            }
            _hexEncryption := hex.EncodeToString(_encryption[:16*(i/16 + 1)])
            // If setting the last byte to `b` mathces the encryption, then 
            // the byte being inferred is `b`.
            if hexEncryption == _hexEncryption { 
                decryption = append(decryption, b)
                break
            }
        }
    }
    return decryption, nil
}
```
























---
title: AES - CBC Mode Encryption in Go
categories: [Science]
---

Electronic Code Book (ECB) encryption consists of applying a block cipher
independently and directly to the underlying byte blocks in a message. Take,
for instance, the AES algorithm, which is a block cipher, and let $128$ be
the number of bits in each of the underlying blocks of a message. Then ECB encryption 
is achieved rather simply:

```go 
func encryptAES128ECB(message []byte, key []byte) ([]byte, error){
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}

	if len(message)%aes.BlockSize != 0 {
		return nil, fmt.Errorf("message is not a multiple of the block size")
	}

	encryption := make([]byte, len(message))

	for i := 0; i < len(message); i += aes.BlockSize {
        block.Encrypt(encryption[i:i+aes.BlockSize], message[i:i+aes.BlockSize])
	}

	return encryption, nil
}
```

An obvious problem of ECB encryption is that, given a fixed key $k_0$, to any
word $w$ of 128 bits corresponds a unique encryption $\mathcal{E}(w)$. For
instance, `"santiago lopez p my secret name santiago lopez p"`
contains three segments of 16 bytes (128 bits), with the
first and third segments being equal. Its encryption with the algorithm above
and the key `YELLOW SUBMARINE` gives `�?p{=�@Sk��1y�e?p{=�@S`, where we
clearly see a repetition of `�?p{=�@S`. 

Cipher Block Chaining (CBC) encryption solves this issue. It consists of
applying the block cipher not to each $16$-byte block independently, but to
the sum (modulo 2) of said block and the encryption of its predecessor. Since 
the first block has no predecessor, this block is xored with a (usually random)
initialization vector.

More formally, if $(\mathcal{G}, \mathcal{E}, \mathcal{D})$ is a (cipher block)
encryption scheme, $\vec{b_0}, \ldots, \vec{b_k}$ are the 16-byte vectors, and
$\vec{v}$ is the input vector, the algorithm computes, for $1 \leq i \leq k$,
the following recursion:

$$
\overrightarrow{c_i} := \begin{cases} \mathcal{E} \left( \overrightarrow{b}_0 + \overrightarrow{v}\right) & i = 0 \\ \mathcal{E} \left(\overrightarrow{b_i} + \overrightarrow{c_{i-1}}\right) & i > 0  \end{cases}
$$

It is of course trivial to decrypt $\overrightarrow{c_i}$ using $\mathcal{E}$,
since from the definition above follows that $\mathcal{b_i} =
\mathcal{D}(\overrightarrow{c_i}) + \overrightarrow{c_{i-1}}$ fir $i > 0$, and 
$b_0 := \mathcal{D}(\overrightarrow{c_0}) + \overrightarrow{v}$.

A simple implementation of AES encryption/decryption with CBC could go as follows:

```go 
package main

import (
	"crypto/aes"
	"fmt"
)

func encryptAES128ECB(message []byte, key []byte) ([]byte, error){
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}

	// Cipher text size safety check.
	if len(message)%aes.BlockSize != 0 {
		return nil, fmt.Errorf("message is not a multiple of the block size")
	}

	encryption := make([]byte, len(message))

	for i := 0; i < len(message); i += aes.BlockSize {
        block.Encrypt(encryption[i:i+aes.BlockSize], message[i:i+aes.BlockSize])
	}

	return encryption, nil
}

func encryptAES128CBC(message []byte, key []byte, iv []byte ) ([]byte, error){
	
    cipherblock, err := aes.NewCipher(key)

    if err != nil {
        return nil, err
    }

    message_blocks := splitIntoSymmetricBlocks(message, 16)
	encryption := make([]byte, len(message_blocks)*16)

    previous_cyphertext := iv
    for i, m := range(message_blocks) { 
        xored := xor(previous_cyphertext, m)
        s := i*aes.BlockSize
        e := s + aes.BlockSize 
        cipherblock.Encrypt(encryption[s:e], xored)
        previous_cyphertext = encryption[s:e]
    }

    return encryption, nil

}

func decryptAES128CBC(ciphertext []byte, key []byte, iv []byte) ([]byte, error){

	if len(ciphertext)%aes.BlockSize != 0 {
		return nil, fmt.Errorf("ciphertext is not a multiple of the block size")
	}

    cipherblocks := splitIntoBlocks(ciphertext, 16)
	plaintext := make([]byte, len( ciphertext ))
    previousCipherBlock := iv
    for i, c := range(cipherblocks){
        decryption, err := decryptAES128ECB(c, key)
        if err != nil {
			return nil, fmt.Errorf("failed to decrypt block: %v", err)
		}
        s := i*aes.BlockSize
        m := xor(decryption, previousCipherBlock)
        copy(plaintext[s:], m)
        previousCipherBlock = c
        
    }
	return plaintext, nil

}


func decryptAES128ECB(ciphertext []byte, key []byte) ([]byte, error) {
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}

	// Cipher text size safety check.
	if len(ciphertext)%aes.BlockSize != 0 {
		return nil, fmt.Errorf("ciphertext is not a multiple of the block size")
	}

	plaintext := make([]byte, len(ciphertext))

	for i := 0; i < len(ciphertext); i += aes.BlockSize {
		block.Decrypt(plaintext[i:i+aes.BlockSize], ciphertext[i:i+aes.BlockSize])
	}

	return plaintext, nil
}
```

As an inspection of the code above, encryption and decryption with ECB are still used within 
CBC encryption. The function which encrypts with CBC does the following:
 
- Split the input byte stream into segments of equal length, padding the last segment if needed. This is accomplished with the `message_blocks := splitIntoSymmetricBlocks(message, 16)` line. This function 
is not given but it is trivial to write. 

- Xor each block with the previous ciphertext, which is the input vector `iv` in the first 
iteration.

- Encrypt the xored block via AES encryption with ECB mode.

It is not necessary to have a separate ECB encryption function: one could call
the encryption logic within the CBC loop directly. But I wrote them separately
because I'm learning and I had my primitive ECB implementation at hand. The
decryption algorithm is quite simple too. For each block in a ciphertext, it
uses ECB decryption to decrypt it and it xores it with the previous ciphertext
block.

The same message, `"santiago lopez p my secret name santiago lopez p"`, is now encrypted 
as `�?p{=�@S�MOiMCo{_�Ӡl˨RiD`, which contains no repeating patterns.













const { initialize } = require('zokrates-js')
const fs = require('fs');

function generate_proof(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15){
    initialize().then((zokratesProvider) => {
        const source = 'import "hashes/sha256/512bitPacked" as sha256packed;\n def main(private field prefix1, private field prefixSalt1, private field prefixNextSalt1, public field prefixComm1, private field buffer1, private field bufferSalt1, private field bufferNextSalt1, public field bufferComm1, private field buffer2, private field bufferSalt2, public field bufferComm2, public field pos1, public field pos2, public field nextPrefixComm1, public field nextBufferComm1) -> field {\n field[2] prefixComm1_ = sha256packed([0, 0, prefix1, prefixSalt1]);\n field[2] bufferComm1_ = sha256packed([0, 0, buffer1, bufferSalt1]);\n field[2] bufferComm2_ = sha256packed([0, 0, buffer2, bufferSalt2]);\n field[2] nextBufferComm1_ = sha256packed([0, 0, buffer1 + buffer2, bufferNextSalt1]);\n field[2] nextPrefixComm1_ = if (pos1 > pos2) { sha256packed([0, 0, prefix1 + buffer2, prefixNextSalt1]) } else { sha256packed([0, 0, prefix1, prefixNextSalt1]) };\n field isCorrect = if (prefixComm1_[1] == prefixComm1 && bufferComm1_[1] == bufferComm1 && bufferComm2_[1] == bufferComm2 && nextBufferComm1_[1] == nextBufferComm1 && nextPrefixComm1_[1] == nextPrefixComm1) { 1 } else { 0 };\n return isCorrect;\n}'
                                      
        const artifacts = zokratesProvider.compile(source);
        const { witness, output } = zokratesProvider.computeWitness(artifacts, [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13,  a14, a15]);

        // var pkStr = "";
        // const pkRestored = new Uint8Array(Buffer.from(pkStr, 'base64')); 
        
        const keypair = zokratesProvider.setup(artifacts.program);
        const proof = zokratesProvider.generateProof(artifacts.program, witness, keypair.pk);

        console.log(proof.proof.a);
        console.log(proof.proof.b);
        console.log(proof.proof.c); 
        console.log(proof.inputs);
    
        const verifier = zokratesProvider.exportSolidityVerifier(keypair.vk);
        const isVerified = zokratesProvider.verify(keypair.vk, proof);

        var pkStr = Buffer.from(keypair.pk).toString('base64');
        console.log(pkStr);
        console.log(keypair.vk);
        console.log(verifier); 
    });
} 

prefix1 = "1"
prefixSalt1 = "0"
prefixNextSalt1 = "0"
prefixComm1 = "339056431533106736071583804247961371611"
buffer1 = "2"
bufferSalt1 = "0"
bufferNextSalt1 = "0"
bufferComm1 = "299153063507599340301092178978927370390"
buffer2 = "3"
bufferSalt2 = "0"
bufferComm2 = "303929493632454553601514655207594661358"
pos1 = "1"
pos2 = "0"
nextPrefixComm1 = "105936431165277967485493761855343418760"
nextBufferComm1 = "107478621429694020472261397218528956447"

generate_proof(prefix1, prefixSalt1, prefixNextSalt1, prefixComm1, buffer1, bufferSalt1, bufferNextSalt1, bufferComm1, buffer2, bufferSalt2, bufferComm2, pos1, pos2, nextPrefixComm1, nextBufferComm1)  

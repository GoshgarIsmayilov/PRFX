# PRFX
Privacy-Preserving Prefix Summation System with Zero-Knowledge Proof on Blockchain

Prefix summation has found its applications over the years in various important domains from sorting to geographical terrain analysis. In our work, we address the privacy-preserving prefix summation problem on blockchain where multiple parties aim to aggregate their secret values through a secure multi-party computation. For the given problem, we propose a novel cryptographic protocol (i.e. _PRFX_) by integrating zero-knowledge proof and hypercube network topology. In addition, we theoretically show the applicability of the proposed protocol on the privacy-preserving delegated proof-of-stake voting (i.e. _pp-dPoS_) using Euler Tour Technique. We analyze the protocol with respect to the security and scalability perspectives including the communication, computation and storage overheads. The proposed protocol is also exposed to the experimental study where its performance is measured through the blockchain gas cost, the zero-knowledge proof generation time and lastly the zero-knowledge proof size. 

# To Run 

The Metamask extension must be installed on the browser and the node-js extension must be also installed in order to run the server.js file.

In the directory of server.js file, execute ```node server.js``` in order to run the local server.

Execute ```http://localhost:3300/``` on the browser where Metamask prompts you to connect on your Ethereum account.

Steps to make a private transaction:

1. Deploy a new instance of the PRFX contract.
2. Register with secret value.
3. Submit the resulting prefix summation at every stage to the pair.
4. Genereate a zero-knowledge proof for the resulting prefix summation at every stage by providing the private key. The private key is used only inside browser and not transmitted over the network.

# Experimental Study

## Blockchain Gas Consumption

| Function         | Gas Units        | Gas Cost (Ether) | Gas Cost (USD)  |
| ---------------- | ---------------- | ---------------- | --------------- |
| Deploy Contract  | 2,099,791        | 0.00554550       | 11.50           |
| Register         | 251,692          | 0.00041469       | 0.86            |
| Submit Summation | 393,707          | 0.00063854       | 1.32            |
| Verify Summation | 1,486,103        | 0.00236184       | 4,90            |

The transaction hashes can be traced on ```https://sepolia.etherscan.io```:

1. Deploy Contract:

   0x6420834300C8F0B3f15EB544B6bBEd5C9eF540C1
   0xd172a6d8d8f75e69c8066e96c53a24cde4d077c7a366aba570a8201ec2839f2d
2. Register:

   0x8657106ecc5598e1873722050fd05ec3139a8eeeddff587972b03486721c06af
   0x484b0a0e20f77b774c415a44b4b058f660f34564c2d17f54e00b37f17b02b3c6
   0x47f1c281e68bdc415b737b928871a94978d91ac9b1de4b1f8274083fc2944cc7
   0x4bbb2e7232f16a0f5101858c52a5599e8ffc2133cee3d49ca4e7a04fda7351b5

3. Submit Prefix Summation:

   0x2c4ee0c2afdf0c5944f90c4075dc3b7b9e9287d09d7e7e6b33b234e22e2be9a6
   0xe1fa8dfb9b6b4807d46f2580188d83efc8b1f2c572b9ca9a622c0d23e5328bac
   0x6000936f8da35dad695de48e00413ce1d1580b8fc1591f7e926a23eaff324ba0
   0x867d661807a968f50a70880664ddb0b9e269b0caa10e30459e724d7df2c1ce05
   0x63e5ace4280acea9ca23d3a56fa033fedf14c7eba971632b671683052d41c01c
   0x05d70c0e6b7a616d6965792bf684c006031108ce9b15d72aac87c30e1b037bb4
   0x971ef861f0b274392dfbb7fa73ae42c07db4ce1b569e1f6b94b7badb7ccbc7ee
   0x564a5b8fa50ee9b637ba5c6ded2345df9fc2f45d89134ff26ef33f4c329ade96

4. Verify Prefix Summation:

   0x0f33afc8b3eed4328b86e749b81e4473a065f66eeecb5a89b0bd9deb98b852b3
   0xec1d7ab3433e3e53fe34decd23998331a94197057af5eeeb959c00838c6c081b
   0x7ef4a217f6b5d186895c6ad53c7e060ee213631b984f443f7e12a3b3aa34aae1
   0x3f8752154cac5126034ebf1a803859f1e9f1763270b335070335d0e3a9f62c9b
   0x969982e4b51401b4f111638c1526d5d5cddd12d6f4d90f39c04c880c7de166a0
   0x16055fdae62f7ea6fafacf0e803198d4670016cf2161fe0d096d6a39f0102f27
   0xe574ff75b183c7dd3d39da8049aa910763827b37b45d1f9705fd7baee455c098
   0x5e0af499f232bd3d8bd848e1e361f71b20578ea93f69f26cad4b629bd5efbd14
   
## Zero-Knowledge Proof Generation/Verification Times

| Run             | Generation Time (sec) | 
| --------------- | --------------------- | 
| 0               | 79.946                |   
| 1               | 81.809                |  
| 2               | 79.310                |  
| 3               | 84.234                |  
| 4               | 78.710                |  
| 5               | 81.152                |  
| 6               | 81.459                |  
| 7               | 81.740                |  
| 8               | 74.351                |  
| 9               | 76.814                |  
| 10              | 81.072                |  
| 11              | 83.584                |  
| 12              | 79.906                |  
| 13              | 80.063                |  
| 14              | 83.247                |  
| 15              | 77.978                |  
| 16              | 80.276                |  
| 17              | 79.732                |  
| 18              | 79.264                |  
| 19              | 73.518                |  

The zero-knowledge proofs are verified on-chain, without requiring any time cost. Note that the outliers are excluded in the figure.

<img src="https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/pgt.png" width="70%"/>

## Zero-Knowledge Proof Size

| Constraints     | Proving Key      | Verification Key | Proof Size      |
| --------------- | ---------------- | ---------------- | --------------- |
| 228,585         | 121 MB           | 2.7 KB           | 1.4 B           |

# Some Maths

## Problem Definition

## Privacy-Preserving Prefix Summation Protocol

# Web User Interface

Deploy Contract...   Register...  

https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/deploy.png

<img src="https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/deploy.png" width="39%"/> <img src="https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/register.png" width="34%"/>

Submit Prefix Summation...   Verify Prefix Summation...  

<img src="https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/submit.png" width="39%"/> <img src="https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/verify.png" width="30%"/>

# Publications to Read

1. S. Nakamoto, "Bitcoin: A peer-to-peer electronic cash system", Decentralized business review, 2008.

2. S. Goldwasser, S. Micali, C. Rackoff, "The knowledge complexity of interactive proof-systems", SIAM Journal on Computing, 18(1):186–208, 1989.

3. J. Eberhardt, S. Tai, "Zokrates-scalable privacy-preserving off-chain computations", In IEEE International Conference on Internet of Things (iThings) and Cyber, Physical and Social Computing (CPSCom), pages 1084–1091, 2018.

4. E. Ben-Sasson, A. Chiesa, E. Tromer, M. Virza, "Succinct Non-Interactive zero knowledge for a von neumann architecture", In 23rd USENIX Security Symposium (USENIX Security 14), pages 781–796, 2014.

5. G. Ismayilov, C. Ozturan, ”PTTS: Zero-Knowledge Proof-based Private Token Transfer System on Ethereum Blockchain and its Network Flow Based Balance Range Privacy Attack Analysis”, https://arxiv.org/pdf/2308.15139.pdf.

6. G. Ismayilov, C. Ozturan, ”Trustless Privacy-Preserving Data Aggregation on Ethereum with Hypercube Network Topology”, https://arxiv.org/pdf/2308.15267.pdf.

7. G. E. Blelloch, "Prefix sums and their applications", 1990.

8. Zokrates-js JavaScript Library, URL: https://www.npmjs.com/package/zokrates-js, last accessed: 6 September 2023.

# Disclaimer

This software is made available for educational purposes only.





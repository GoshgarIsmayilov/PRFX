# PRFX
Privacy-Preserving Prefix Summation System with Zero-Knowledge Proof on Blockchain

Prefix summation has found its applications over the years in various important domains from sorting to geographical terrain analysis. In our work, we address the privacy-preserving prefix summation problem on blockchain where multiple parties aim to aggregate their secret values through a secure multi-party computation. For the given problem, we propose a novel cryptographic protocol (i.e. \textit{PRFX}) by integrating zero-knowledge proof and hypercube network topology. In addition, we theoretically show the applicability of the proposed protocol on the privacy-preserving delegated proof-of-stake voting (i.e. \textit{pp-dPoS}) using Euler Tour Technique. We analyze the protocol with respect to the security and scalability perspectives including the communication, computation and storage overheads. The proposed protocol is also exposed to the experimental study where its performance is measured through the blockchain gas cost, the zero-knowledge proof generation time and lastly the zero-knowledge proof size. 

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

## Zero-Knowledge Proof Generation/Verification Times

## Zero-Knowledge Proof Size

# Some Maths

## Problem Definition

## Privacy-Preserving Prefix Summation Protocol

# Web User Interface


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





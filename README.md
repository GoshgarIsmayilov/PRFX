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

The privacy-preserving prefix summation on blockchain is a problem where a set of individual parties with certain secret values is interested in the sums of the prefixes of these values without disclosing them. Suppose that there exist an ordered set of $N$ secret values from $N$ different parties:

$$
\begin{align}
& X = [x_0, x_1, ..., x_{N-1}]
\end{align}
$$

\noindent
where $x_i \in X$ is the secret value of the party $i$. The privacy-preserving prefix summation problem defines a secure multi-party computation function $prf: (\mathbb{Z}^*, i) \to \mathbb{Z}$ which takes the ordered set of secret values and the order of the party calling the function in order to return the corresponding sum of prefixes:

$$
\begin{align}
& prf(X, i) = x_0 \oplus x_1 \oplus ... \oplus x_{i-1}
\end{align}
$$

\noindent
where $\oplus$ is a binary associative summation operator.

## Privacy-Preserving Prefix Summation Protocol

Once the contract is successfully deployed, the parties register with the commitments of their secret values:

$$
\begin{align}
& c_p = Comm(p = x, r_{p}) \\
& c_b = Comm(b = p, r_{b}) \\
& pk, sk = KeyGen(k) 
\end{align}
$$

\noindent
where $c_p$ and $c_b$ are the resulting commitments of the commitment function $Comm$, based on the secret value $x$, the prefix $p$, the buffer $b$ and their corresponding random values $r_{p}$ and $r_{b}$. Then, the parties can find their peers in the hypercube network:

$$
\begin{align}
& u \oplus 2^t = u^{{peer}^A} 
\end{align}
$$

\noindent
where $u^{{peer}}$ is the pair of the party $u$ in the hypercube network at the stage $t \in [0, log(N)-1]$. The buffers of the parties are encrypted with the public keys of their peer parties and submitted to the contract:

$$
\begin{align}
& E = Enc([b = b + b^{{peer}}], r, pk^{{peer}}) 
\end{align}
$$

\noindent
where $E$ is the resulting encryptions of the encryption function $Enc$ based on the cumulative buffers $b, b^{{peer}}$, the salting value $r$ and the public key $pk^{{peer}}$. The encryptions are later fetched from the smart contract and decrypted:

$$
\begin{align}
& [m^{{peer}}, r^{{peer}}] = D = Dec([E], sk)
\end{align}
$$

\noindent
where $D$ is the resulting decryptions of the decryption function $Dec$ based on the secret key $sk$. The parties perform the prefix summation operations and generate their corresponding zero-knowledge proofs about their correctness:

$$
\begin{align}
\pi = ZkpGen([& b = b + b^{{peer}}, \nonumber \\
& p = p + b^{{peer}} \vee p = p], \nonumber \\
& [r_p, r_b, r^{{peer}}_b, r^{{new}}_p, r^{{new}}_b], \nonumber \\
& [c_p, c_b, c^{{peer}}_b, c^{{new}}_p, c^{{new}}_b]) 
\end{align}
$$

\noindent
where $\pi$ is the resulting proof of the zero-knowledge proof generation function $ZkpGen$ with respect to the buffers $b, b^{{peer}}$, the prefix $p$, their salting values $r_p, r_b, r^{{peer}}_b, r^{{new}}_p, r^{{new}}_b$ and their commitments $c_p, c_b, c^{{peer}}_b, c^{{new}}_p, c^{{new}}_b$. The parties submit the resulting proofs to the smart contract in order to verify:

$$
\begin{align}
b = ZkpVfy([& \pi, c_p, c_b, c^{{peer}}_b, c^{{new}}_p, c^{{new}}_b])
\end{align}
$$

\noindent
where $b$ is Boolean output of the proof verification function $ZkpVfy$ to represent proof correctness. Once the proof is successfully verified, the old prefix and buffer commitments of the parties are replaced with new commitments. After the repetition of the third and the fourth phases in the hypercube networks, the parties eventually obtain their own prefix summations.

<img src="https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/hypercube.png" width="70%"/> 

## Delegated Proof-of-Stake with Euler Tour Technique (_pp-dPoS_)

We theoretically show the application of the proposed protocol on the privacy-preserving variant of the existing delegated proof-of-stake (i.e. _pp-dPoS_) voting mechanism where the nodes in the network transfer their validation rights into the delegate nodes by staking hidden amount of tokens into their pools. It can be formulated as the directed graph $G=(V,E)$ where $V$ is the set of public blockchain nodes while $E$ is the set of private stakes between these nodes in the network where their weights $w(e_{uv})$ are equal to the commitments of the amount of tokens staked. The goal of the problem is to find the total amount of tokens staked in the pool for every node with the following recursive formulation:

$$
\begin{align}
& \mathcal{S}(v) = w(e_{vu}) + \sum_{u \subset G(v)} \mathcal{S}(u) 
\end{align}
$$

\noindent
where $u \subset G(v)$ is the sub-graph whose root is the node $v$ and $\mathcal{S}(v)$ is the total stake of the node $v$ in the pool. The resolution of the resulting graph requires a linearization algorithm to traverse it. In this work, we use the depth-first traversal-based Euler Tour Technique, which splits each edge into two directed edges as downward (i.e. advance) and upward (i.e. retreat) edges. It basically transforms the traversal of the given graph into the traversal of the singly-linked list. We set the weights of the advance edges from node $u$ to $v$ as the commitments of the amounts of tokens staked, $w(e_{uv}) = c_{uv}$ and; the weights of the retreat edges simply as zero, $w(e_{vu}) = 0$.

<img src="https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/dpos1.png" width="50%"/> <img src="https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/dpos2.png" width="30%"/> 

The _PRFX_ protocol for the _pp-dPoS_ voting mechanism needs the following steps to be performed: (_i_) _staking_: the nodes privately stake tokens to the delegate nodes by generating zero-knowledge proof that they have enough balances to stake and a corresponding edge for that staking is appended to the global directed graph, (_ii_) _linearization_: the global graph is traversed into single-dimensional node array through Euler Tour Technique, (_iii_) _prefix submission_: the nodes pair-wise exchanges prefix summations, (_iv_) _prefix verification_: the nodes verify prefix summations with zero-knowledge proofs on-chain and finally (_v_) _stake computation_: the nodes privately learn the total amount of tokens staked in their pools. In _stake computation_, the nodes may end up with multiple prefix values $\mathcal{P}: (p_0, p_1, ..., p_i)$. To compute the total amount of tokens staked at their pools, they must use the following formula:

$$
\begin{align}
& \mathcal{S}(v) = max(\mathcal{P}) - min(\mathcal{P}) 
\end{align}
$$

\noindent
where $min(\mathcal{P})$ and $max(\mathcal{P})$ represent the minimum and maximum prefix values of the node $v$. For $V$ number of nodes in the system, the time complexity needs $O(V)$ for staking at most, $O(V+E)$ for the depth-first search-based graph traversal, $O(VlogV)$ for prefix summation and verification and $O(V)$ for stake computation, which eventually results in $O(VlogV)$ global complexity at the worst case scenario.

<img src="https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/dpos3.png" width="50%"/> <img src="https://github.com/GoshgarIsmayilov/PRFX/blob/main/Auxiliary/dpos4.png" width="40%"/> 

# Web User Interface

Deploy Contract...   Register...  

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





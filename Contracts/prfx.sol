// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "../zokrates/verifier.sol";

contract PRFX {
    mapping(address => uint256) registrationIds;
    mapping(address => uint256) bufferCommitments;
    mapping(address => uint256) prefixCommitments;
    mapping(address => string) publicKeys;

    mapping(address => uint256) tempPrefixCommitments;
    mapping(address => uint256) tempBufferCommitments;

    mapping(address => mapping (address => string)) secretMessages;

    address[] registeredUsers;

    uint256 maximumHypercubeStage = 0;
    uint256 currentHypercubeStage = 0;
    uint256 registrationStartTime = 0;
    uint256 registrationTimeLimit = 0;
    uint256 numberOfProofsVerified = 0;

    modifier duringRegistrationPeriod() {
        require(block.timestamp > registrationStartTime && block.timestamp < registrationStartTime + registrationTimeLimit, "Only allowed during registration period!");
        _;
    }

    modifier duringHypercubePeriod() {
        require(currentHypercubeStage < maximumHypercubeStage, "Only allowed during hypercube period!");
        _;
    }

    constructor(uint256 _registrationStartTime, uint256 _registrationTimeLimit) {  
        registrationStartTime = _registrationStartTime;
        registrationTimeLimit = _registrationTimeLimit;
    }  

    function register(uint256 commitment, string memory publicKey) public {
        require(bytes(publicKeys[msg.sender]).length == 0, "User has already registered!");
        registrationIds[msg.sender] = registeredUsers.length;
        prefixCommitments[msg.sender] = bufferCommitments[msg.sender] = commitment;
        publicKeys[msg.sender] = publicKey;
        registeredUsers.push(msg.sender);
        calculateMaximumHypercubeStage();
    }

    function calculateMaximumHypercubeStage() public {
        uint256 maximumUsersSupported = 2 ** maximumHypercubeStage;
        if (registeredUsers.length > maximumUsersSupported) {
            maximumHypercubeStage += 1;
        }
    }

    function getPair() public view returns (uint256) {
        return registrationIds[msg.sender] ^ (2 ** currentHypercubeStage);
    }

    function getPairAddress() public view returns (address) {
        uint256 pair = getPair();
        return registeredUsers[pair];
    }

    function getPairPublicKey() public view returns (string memory) {  
        address hypercubePairAddress = getPairAddress();
        return publicKeys[hypercubePairAddress];
    }  

    function submitEncryption(string memory secretMessage) public { 
        address hypercubePairAddress = getPairAddress();
        secretMessages[msg.sender][hypercubePairAddress] = secretMessage;
    }

    function fetchEncryption() public view returns (string memory, uint256, uint256, uint256, uint256) {  
        uint256 pair = getPair();

        address hypercubePairAddress = getPairAddress();
        return (secretMessages[hypercubePairAddress][msg.sender], 
                maximumHypercubeStage,
                currentHypercubeStage,
                registrationIds[msg.sender],
                pair);
    }

    function verifyPrefixAggregation(
        uint[2] memory a, 
        uint[2][2] memory b, 
        uint[2] memory c,
        uint256 nextPrefixCommitment,
        uint256 nextBufferCommitment) public returns (bool) {
            Verifier verifier = new Verifier();
            uint256 pair = getPair();

            bool isProofCorrect = verifier.verifyTx2(a, b, c, [prefixCommitments[msg.sender],
                                                               bufferCommitments[msg.sender], 
                                                               bufferCommitments[registeredUsers[pair]], 
                                                               registrationIds[msg.sender], 
                                                               pair,
                                                               nextPrefixCommitment, 
                                                               nextBufferCommitment, 
                                                               1]);
    
            if(isProofCorrect) {
                numberOfProofsVerified += 1;
                if (numberOfProofsVerified == registeredUsers.length) {
                    currentHypercubeStage += 1;
                    numberOfProofsVerified = 0;
                }

                if (tempBufferCommitments[registeredUsers[pair]] == 0) {
                    tempPrefixCommitments[msg.sender] = nextPrefixCommitment;
                    tempBufferCommitments[msg.sender] = nextBufferCommitment;
                }
                else { 
                    prefixCommitments[msg.sender] = nextPrefixCommitment;
                    prefixCommitments[registeredUsers[pair]] = tempPrefixCommitments[registeredUsers[pair]];
                    bufferCommitments[msg.sender] = nextBufferCommitment;
                    bufferCommitments[registeredUsers[pair]] = tempBufferCommitments[registeredUsers[pair]];
                    tempPrefixCommitments[registeredUsers[pair]] = 0;
                    tempBufferCommitments[registeredUsers[pair]] = 0;
                } 
            }

            return isProofCorrect; 
    } 

    function getContractState() public view returns (uint256, uint256, uint256, uint256, uint256, uint256, uint256) {
        return (bufferCommitments[msg.sender], tempBufferCommitments[msg.sender], 
                prefixCommitments[msg.sender], prefixCommitments[msg.sender],
                currentHypercubeStage, maximumHypercubeStage, numberOfProofsVerified);
    }
}


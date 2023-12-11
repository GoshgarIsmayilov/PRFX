// This file is MIT Licensed.
//
// Copyright 2017 Christian Reitwiessner
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;
library Pairing {
    struct G1Point {
        uint X;
        uint Y;
    }
    // Encoding of field elements is: X[0] * z + X[1]
    struct G2Point {
        uint[2] X;
        uint[2] Y;
    }
    /// @return the generator of G1
    function P1() pure internal returns (G1Point memory) {
        return G1Point(1, 2);
    }
    /// @return the generator of G2
    function P2() pure internal returns (G2Point memory) {
        return G2Point(
            [10857046999023057135944570762232829481370756359578518086990519993285655852781,
             11559732032986387107991004021392285783925812861821192530917403151452391805634],
            [8495653923123431417604973247489272438418190587263600148770280649306958101930,
             4082367875863433681332203403145435568316851327593401208105741076214120093531]
        );
    }
    /// @return the negation of p, i.e. p.addition(p.negate()) should be zero.
    function negate(G1Point memory p) pure internal returns (G1Point memory) {
        // The prime q in the base field F_q for G1
        uint q = 21888242871839275222246405745257275088696311157297823662689037894645226208583;
        if (p.X == 0 && p.Y == 0)
            return G1Point(0, 0);
        return G1Point(p.X, q - (p.Y % q));
    }
    /// @return r the sum of two points of G1
    function addition(G1Point memory p1, G1Point memory p2) internal view returns (G1Point memory r) {
        uint[4] memory input;
        input[0] = p1.X;
        input[1] = p1.Y;
        input[2] = p2.X;
        input[3] = p2.Y;
        bool success;
        assembly {
            success := staticcall(sub(gas(), 2000), 6, input, 0xc0, r, 0x60)
            // Use "invalid" to make gas estimation work
            switch success case 0 { invalid() }
        }
        require(success);
    }


    /// @return r the product of a point on G1 and a scalar, i.e.
    /// p == p.scalar_mul(1) and p.addition(p) == p.scalar_mul(2) for all points p.
    function scalar_mul(G1Point memory p, uint s) internal view returns (G1Point memory r) {
        uint[3] memory input;
        input[0] = p.X;
        input[1] = p.Y;
        input[2] = s;
        bool success;
        assembly {
            success := staticcall(sub(gas(), 2000), 7, input, 0x80, r, 0x60)
            // Use "invalid" to make gas estimation work
            switch success case 0 { invalid() }
        }
        require (success);
    }
    /// @return the result of computing the pairing check
    /// e(p1[0], p2[0]) *  .... * e(p1[n], p2[n]) == 1
    /// For example pairing([P1(), P1().negate()], [P2(), P2()]) should
    /// return true.
    function pairing(G1Point[] memory p1, G2Point[] memory p2) internal view returns (bool) {
        require(p1.length == p2.length);
        uint elements = p1.length;
        uint inputSize = elements * 6;
        uint[] memory input = new uint[](inputSize);
        for (uint i = 0; i < elements; i++)
        {
            input[i * 6 + 0] = p1[i].X;
            input[i * 6 + 1] = p1[i].Y;
            input[i * 6 + 2] = p2[i].X[1];
            input[i * 6 + 3] = p2[i].X[0];
            input[i * 6 + 4] = p2[i].Y[1];
            input[i * 6 + 5] = p2[i].Y[0];
        }
        uint[1] memory out;
        bool success;
        assembly {
            success := staticcall(sub(gas(), 2000), 8, add(input, 0x20), mul(inputSize, 0x20), out, 0x20)
            // Use "invalid" to make gas estimation work
            switch success case 0 { invalid() }
        }
        require(success);
        return out[0] != 0;
    }
    /// Convenience method for a pairing check for two pairs.
    function pairingProd2(G1Point memory a1, G2Point memory a2, G1Point memory b1, G2Point memory b2) internal view returns (bool) {
        G1Point[] memory p1 = new G1Point[](2);
        G2Point[] memory p2 = new G2Point[](2);
        p1[0] = a1;
        p1[1] = b1;
        p2[0] = a2;
        p2[1] = b2;
        return pairing(p1, p2);
    }
    /// Convenience method for a pairing check for three pairs.
    function pairingProd3(
            G1Point memory a1, G2Point memory a2,
            G1Point memory b1, G2Point memory b2,
            G1Point memory c1, G2Point memory c2
    ) internal view returns (bool) {
        G1Point[] memory p1 = new G1Point[](3);
        G2Point[] memory p2 = new G2Point[](3);
        p1[0] = a1;
        p1[1] = b1;
        p1[2] = c1;
        p2[0] = a2;
        p2[1] = b2;
        p2[2] = c2;
        return pairing(p1, p2);
    }
    /// Convenience method for a pairing check for four pairs.
    function pairingProd4(
            G1Point memory a1, G2Point memory a2,
            G1Point memory b1, G2Point memory b2,
            G1Point memory c1, G2Point memory c2,
            G1Point memory d1, G2Point memory d2
    ) internal view returns (bool) {
        G1Point[] memory p1 = new G1Point[](4);
        G2Point[] memory p2 = new G2Point[](4);
        p1[0] = a1;
        p1[1] = b1;
        p1[2] = c1;
        p1[3] = d1;
        p2[0] = a2;
        p2[1] = b2;
        p2[2] = c2;
        p2[3] = d2;
        return pairing(p1, p2);
    }
}

contract Verifier {
    using Pairing for *;
    struct VerifyingKey {
        Pairing.G1Point alpha;
        Pairing.G2Point beta;
        Pairing.G2Point gamma;
        Pairing.G2Point delta;
        Pairing.G1Point[] gamma_abc;
    }
    struct Proof {
        Pairing.G1Point a;
        Pairing.G2Point b;
        Pairing.G1Point c;
    }
    function verifyingKey() pure internal returns (VerifyingKey memory vk) {
        vk.alpha = Pairing.G1Point(uint256(0x231e4f143e04c26eddc3ccb60351cfbb96ba7257df8fe4ab9283ec52abbe9c82), uint256(0x0928553f8c1c8bb0b472434648165a50b54db21b6c96e55ad7482dd3ddc08a8d));
        vk.beta = Pairing.G2Point([uint256(0x24f136c11407f08b0c03b1799d85449726afdd87c1c730d339e6539c1276e6aa), uint256(0x1a789df5909f6fd280c5be03738087a817db873546595abc4f6821f7da0c04dc)], [uint256(0x1a4b1cdb209ec5f074d53deeddbdd1f3fb282a890d4630cad904eada38f1e5e0), uint256(0x11ee5f7c19857b66082c3c1c6bf42bbce2d8f14ad4611b080eacecf38f8ba5c7)]);
        vk.gamma = Pairing.G2Point([uint256(0x29ac6dfaffd7b2d1363bbb2024ad2158e195975968c1d2027746710a4e2709a1), uint256(0x117a866f7d60af515b4a93f77ab0636f40d4324cf3cc43d3d789773fbc9f1532)], [uint256(0x1d04d14bcf7e97e2a004c786847679d3c26fa6c2dc09582ccc1388e7de007b32), uint256(0x1319e4f4f4532143dd6442f44592d86e64021d573cab761802be7feb366a7e93)]);
        vk.delta = Pairing.G2Point([uint256(0x25d45f1c5e461687ebd4611453054977b1d919cbcd946a702dbfab0542d5c4b1), uint256(0x0c1d13234d3357f5717acb5258be24d16b911df762ba38f32168835e64f18b86)], [uint256(0x20640f3c2565c1071608a41f93f0f777d40bad0b30fbf4c6e97fb098bb05e284), uint256(0x29400c4f8944ff1caa079eff1bc47adc95e0e4cb24745d85faeb9757b8c2da58)]);
        vk.gamma_abc = new Pairing.G1Point[](9);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x03a5be3dee824a8177c5a928e39cf651bfb1351cc6d23b29eec8ab9bd700183d), uint256(0x27392898be165adb6301342716789ac4ff0eb4c4610317e67817eee36004a379));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x176bf172ac316470861365758f65907d09711b6bf38d3550bea5333774d2ad4e), uint256(0x12a303e8a9190135d2347009f5d7d5fba9fc67d92d25818947c0516e6734c5ba));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x120afde4b01f4c26f0044241f42b3e3bb5ceb92d63ca3eef222ff42adf3101f8), uint256(0x2113e86e6ba2f0bbf10c9453c5d7fde9f465db3015def8ba7763f9eb8689670e));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x1653050b629e6313e3463c8152acf22570052d1f9e89190b491b577f5b967ee2), uint256(0x0c2e7bfaf373a7ea1eaf18cea0ab71fc39ea8efb7362d833e1d3b0385d2b6426));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x12aac226d22842e9cc6e0af8ccea265ea62d76406860e55a950ec4f16e07898f), uint256(0x019a94fa1292a281d0594649468e4ad24f8170911fec44c2e6aa36f73ee71d72));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x1c655a672acf24d460b66bbbd3d62eb8dce05ec229850178e950702367373582), uint256(0x039737d8f0def992e2025fad1112a9414d480dbd7fe326b5be08750107df3f23));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x2345b2a8c12695d85feba1cb23672ea15cda86292212fe67836b9e6825f2b192), uint256(0x1848e0ce1a8f6bbea28d8392850ef70c5afb5e8d1d1d7a4969aee4b1add4d0c2));
        vk.gamma_abc[7] = Pairing.G1Point(uint256(0x1281a000c909eabd1addc8d20f9ec53cd5f59a40b8382f6791b9be540d3ddda5), uint256(0x215c41c0f2c1e9f0a265180093150b17b4ed008e8bd835919b62812c8e12dfb2));
        vk.gamma_abc[8] = Pairing.G1Point(uint256(0x20fff86b075810708cc1836ee15eaf875999c56d1686eb1eda51ed027b07668c), uint256(0x03ea12e9029b24c4a83b472a5e6ed4659e210d7eda6ede457540674836a3e85f));
    }
    function verify(uint[] memory input, Proof memory proof) internal view returns (uint) {
        uint256 snark_scalar_field = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
        VerifyingKey memory vk = verifyingKey();
        require(input.length + 1 == vk.gamma_abc.length);
        // Compute the linear combination vk_x
        Pairing.G1Point memory vk_x = Pairing.G1Point(0, 0);
        for (uint i = 0; i < input.length; i++) {
            require(input[i] < snark_scalar_field);
            vk_x = Pairing.addition(vk_x, Pairing.scalar_mul(vk.gamma_abc[i + 1], input[i]));
        }
        vk_x = Pairing.addition(vk_x, vk.gamma_abc[0]);
        if(!Pairing.pairingProd4(
             proof.a, proof.b,
             Pairing.negate(vk_x), vk.gamma,
             Pairing.negate(proof.c), vk.delta,
             Pairing.negate(vk.alpha), vk.beta)) return 1;
        return 0;
    }
    function verifyTx(
            Proof memory proof, uint[8] memory input
        ) public view returns (bool r) {
        uint[] memory inputValues = new uint[](8);
        
        for(uint i = 0; i < input.length; i++){
            inputValues[i] = input[i];
        }
        if (verify(inputValues, proof) == 0) {
            return true;
        } else {
            return false;
        }
    }

    function verifyTx2(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c, uint[8] memory input
        ) public view returns (bool r) {
        Proof memory proof;
        proof.a = Pairing.G1Point(a[0], a[1]);
        proof.b = Pairing.G2Point([b[0][0], b[0][1]], [b[1][0], b[1][1]]);
        proof.c = Pairing.G1Point(c[0], c[1]);
        uint[] memory inputValues = new uint[](8);
        
        for(uint i = 0; i < input.length; i++){
            inputValues[i] = input[i];
        }
        if (verify(inputValues, proof) == 0) {
            return true;
        } else {
            return false;
        }
    }
}


// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import {ChallengeFactory} from "../src/testnet/ChallengeFactory.sol";
import {ProofOfHacker} from "../src/arbitrum/ProofOfHacker.sol";
import {FactoryChallenge0} from "../src/testnet/challenges/Challenge0.factory.sol";

contract ContractScript is Script {
    function setUp() public {}

    function run() public {
        address MINTER = 0x09AB10F1305aA4bf84055843e2C2fdb23445F99e;
        vm.startBroadcast();
        address c0 = address(new FactoryChallenge0());
        address f = address(new ChallengeFactory());
        address nft = address(new ProofOfHacker(MINTER));
        vm.stopBroadcast();
        console.log("Factory");
        console.log((f));

        console.log("Challenge0");
        console.log(c0);
        console.log("NFT");
        console.log(nft);

        //FactoryChallenge0 f0 = new FactoryChallenge0();
        //FactoryChallenge1 f1 = new FactoryChallenge1();
        //FactoryChallenge2 f2 = new FactoryChallenge2();
        //FactoryChallenge3 f3 = new FactoryChallenge3();

        // f.addChallenge(0, address(f0));
        // f.addChallenge(1, address(f1));
        // f.addChallenge(2, address(f2));
        // f.addChallenge(3, address(f3));
    }
}

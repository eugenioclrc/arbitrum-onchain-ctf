// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// bad name, this is the factory interface that a challenge factoery should have

interface IChallengeFactory {
    // @notice create challenges contract
    function deploy(address player) external returns (address[] memory);

    // @notice return name of the contract challenges
    function contractNames() external view returns (string[] memory);

    // @notice return url for rending the nft
    function url() external view returns (string memory);

    /// @notice Will true if player has complete the challenge
    function isComplete(address[] calldata) external view returns (bool);
}

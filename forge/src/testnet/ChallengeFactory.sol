pragma solidity 0.8.17;

import {IChallengeFactory} from "./challenges/IChallengeFactory.sol";

contract ChallengeFactory {
    event Deployed(address indexed player, address indexed challengeFactory, address[] challengeContracts);

    mapping(address => mapping(address => address[])) public challenges;

    constructor() {}

    function deployChallenge(address _challengeFactory) external {
        address[] memory _challengeContracts = IChallengeFactory(_challengeFactory).deploy(msg.sender);

        challenges[msg.sender][_challengeFactory] = _challengeContracts;

        emit Deployed(msg.sender, _challengeFactory, _challengeContracts);
    }

    function getChallengesInstances(address user, address _challengeFactory) external view returns (address[] memory) {
        return challenges[user][_challengeFactory];
    }

    function checkChallenge(address user, address _challengeFactory) public view returns (bool) {
        if (challenges[user][_challengeFactory].length == 0) {
            return false;
        }

        return IChallengeFactory(_challengeFactory).isComplete(challenges[user][_challengeFactory]);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ECDSA} from "openzeppelin-contracts/utils/cryptography/ECDSA.sol";
import {Owned} from "solmate/auth/Owned.sol";
import {SoulBound1155} from "./SoulBound1155.sol";

contract ProofOfHacker is SoulBound1155, Owned {
    address public minter;

    mapping(uint256 => string) private _uri;

    error WrongSignature();
    error CantMintMoreThanOnce();

    error TokenNotExists(address);

    constructor(address _minter) Owned(msg.sender) {
        minter = _minter;
    }

    function setMinter(address _minter) external onlyOwner {
        minter = _minter;
    }

    function mint(address _player, address _challenge, string memory _ipfs, bytes calldata _signature) external {
        if (balanceOf[_player][uint256(uint160(_challenge))] > 0) {
            revert CantMintMoreThanOnce();
        }

        bytes32 hash = keccak256(abi.encodePacked(address(this), _challenge, _player, _ipfs));
        bytes32 message = ECDSA.toEthSignedMessageHash(hash);

        (address recovered, ECDSA.RecoverError error) = ECDSA.tryRecover(message, _signature);
        require(recovered == minter, "!minter");

        if (error != ECDSA.RecoverError.NoError || recovered != minter) {
            revert WrongSignature();
        }

        _uri[uint256(uint160(_challenge))] = _ipfs;

        _mint(_player, uint256(uint160(_challenge)), 1, "");
    }

    function uri(uint256 id) public view override returns (string memory url) {
        url = _uri[id];
        if (bytes(url).length == 0) {
            revert TokenNotExists(address(uint160(id)));
        }
    }
}

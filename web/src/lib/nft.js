import { get } from "svelte/store";
import { Contract } from "@ethersproject/contracts";
import { PUBLIC_NFT } from '$env/static/public';

import { chainId, signer } from "./eth";
//import abiFactory from "./abi.json";

const contractsDict = {};

const abiFactory = [
    "function mint(address _player, address _challenge, string memory ipfs, bytes calldata _signature) external",
    "function balanceOf(address, uint256) external view returns(uint256)"
]

export default async function getContract() {
  const $signer = await get(signer);
  const $chainId = await get(chainId);
  
  const contract = contractsDict[$chainId];
  if (contract) {
    return contract.connect($signer);
  }

  if (!PUBLIC_NFT) {
    throw new Error(`No contracts address for ${$chainId}`);
  }

  contractsDict[$chainId] = new Contract(PUBLIC_NFT, abiFactory, $signer);
  return contractsDict[$chainId];  
}
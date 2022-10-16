import { get } from "svelte/store";
import { Contract } from "@ethersproject/contracts";

import { chainId, signer } from "./eth";
//import abiFactory from "./abi.json";

const contractsDict = {};

const abiFactory = [
    "function mint(address _player, address _challenge, string memory ipfs, bytes calldata _signature) external"
]

const CONTRACTS_ADDRESS = {
  31337: '0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0',
};

export default async function getContract() {
  const $signer = await get(signer);
  const $chainId = await get(chainId);
  
  const contract = contractsDict[$chainId];
  if (contract) {
    return contract.connect($signer);
  }

  if (!CONTRACTS_ADDRESS[$chainId]) {
    throw new Error(`No contracts address for ${$chainId}`);
  }

  contractsDict[$chainId] = new Contract(CONTRACTS_ADDRESS[$chainId], abiFactory, $signer);
  return contractsDict[$chainId];  
}
import { get } from "svelte/store";
import { Contract } from "@ethersproject/contracts";

import { chainId, signer } from "./eth";
import abiFactory from "./abi.json";

const contractsDict = {};
/*
const abiFactory = [
    "function deployChallenge(address) external",
    "function getChallengesInstances(address,address) external view returns(address[] memory)"
              getChallengesInstances
]*/

const CONTRACTS_ADDRESS = {
  5: '0xd93296489cf51135b36bc0a7c1114c310a676bfd',
  31337: '0xe7f1725e7734ce288f8367e1bb143e90bb3f0512',
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

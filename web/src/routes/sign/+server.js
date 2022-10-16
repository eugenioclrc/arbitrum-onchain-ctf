
import { error, json } from '@sveltejs/kit';
import * as ethers from 'ethers';

import { env } from '$env/dynamic/private';
import { PUBLIC_MAINFACTORY, PUBLIC_NFT } from '$env/static/public';


const abiFactory = [
  "function deployChallenge(address) external",
  "function getChallengesInstances(address,address) external view returns(address[] memory)",
  "function checkChallenge(address user, address _challengeFactory) public view returns(bool)"
]

const challengeFactoryAbi = [
  "function url() external view returns (string memory)"
]

const factoryAddress =  PUBLIC_MAINFACTORY;
// nft is 
const contractAddress = PUBLIC_NFT;


/** @type {import('./$types').RequestHandler} */
export async function GET({ url }) {
  console.log(env);
  const challenge = url.searchParams.get('challenge');
  const player = url.searchParams.get('player');
 
  if (!player || !challenge) {
    throw error(400, 'params errors');
  }
 
  // todo check player has end challenge
  const provider = new ethers.providers.JsonRpcProvider(env.DEPLOYMENT_RPC);
  const signer = new ethers.Wallet(env.DEPLOYMENT_MINTERPK, provider);

  const factory = new ethers.Contract(factoryAddress, abiFactory, signer);
  const solved = await factory.checkChallenge(player, challenge);
  if (!solved) {
    throw error(400, 'not solved');
  }

  const factoryChallenge = new ethers.Contract(challenge, challengeFactoryAbi, signer);


  const nftUrl = await factoryChallenge.url();

  const hashed = ethers.utils.solidityKeccak256(
      ['address', 'address', 'address', 'string'],
      [
        contractAddress,
        challenge,
        player,
        nftUrl
      ]);

    const signature = await signer.signMessage(ethers.utils.arrayify(hashed))

	return json({
    keccak: hashed,
		signature,
		nftUrl
	});
}
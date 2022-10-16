
import { error, json } from '@sveltejs/kit';
import * as ethers from 'ethers';

const abiFactory = [
  "function deployChallenge(address) external",
  "function getChallengesInstances(address,address) external view returns(address[] memory)",
  "function checkChallenge(address user, address _challengeFactory) public view returns(bool)"
]

const challengeFactoryAbi = [
  "function url() external view returns (string memory)"
]

const factoryAddress = "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512";
// demo unsecure pk
// minter: 0x18e3d8745a9b0C065309986acFE1d837bb7537cD
// Private key: 9308343e9a8d724ab4c5d6dd66d694eabae4ddb68752dd02f18006cb2b427cca
const PK = "9308343e9a8d724ab4c5d6dd66d694eabae4ddb68752dd02f18006cb2b427cca"
// nft is 0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0
const contractAddress = "0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0"



/** @type {import('./$types').RequestHandler} */
export async function GET({ url }) {
  const challenge = url.searchParams.get('challenge');
  const player = url.searchParams.get('player');
 
  if (!player || !challenge) {
    throw error(400, 'params errors');
  }
 
  // todo check player has end challenge
  const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545');
  const signer = new ethers.Wallet(PK, provider);

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

import { error, json } from '@sveltejs/kit';
import ethers from 'ethers';
// deme fake pk
const PK = "ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
const contractAddress = "0x32848f42f30395defE5012f57c34Eb98fd08EedF"

/** @type {import('./$types').RequestHandler} */
export async function GET({ url }) {
  const challenge = url.searchParams.get('challenge');
  const player = url.searchParams.get('player');
 
  if (!player || !challenge) {
    throw error(400, 'params errors');
  }
 
  // todo check player has end challenge

  const signer = new ethers.Wallet(PK);

  const nftUrl = "ipfs metadata";


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
		signature,
		nftUrl
	});
}
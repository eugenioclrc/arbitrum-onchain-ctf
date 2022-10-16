<script>
    import ChallengeElement from '../Challenge.svelte';
  
    const nChallenge = 0;
    const addressChallenge = "0x5fbdb2315678afecb367f032d93f642f64180aa3";
    
    const baseurl = 'https://github.com/eugenioclrc/DeFi-Security-Summit-Stanford/tree/master/challenges_sources/'
    const instancesDescriptions = [
      {href: baseurl+'/Challenge0.VToken.sol', text: 'Challenge0.VToken.sol'},
    ];
  </script>
  <svelte:head>
    <title>Lender Pool</title>
  </svelte:head>
  
  <ChallengeElement nameChallenge="Lender Pool" {nChallenge} {addressChallenge} {instancesDescriptions}>
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
  


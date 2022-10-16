<script>
    import ChallengeElement from '../Challenge.svelte';
  
    const nChallenge = 1;
    
    const baseurl = 'https://github.com/eugenioclrc/DeFi-Security-Summit-Stanford/tree/master/challenges_sources/'
    const instancesDescriptions = [
      {href: baseurl+'Challenge1.lenderpool.sol', text: 'Challenge1.lenderpool.sol'},
      {href: baseurl+'tokens/tokenInsecureum.sol', text: 'tokenInsecureum.sol'},
    ];
  </script>
  <svelte:head>
    <title>Lender Pool</title>
  </svelte:head>
  
  <ChallengeElement nameChallenge="Lender Pool" {nChallenge} {instancesDescriptions}>
    <span slot="title">
      Challenge 1
      </span>
    <div slot="content">
      <blockquote>
        <p>What a nice Lender Pool!</p>
      </blockquote>
      <p>
        Secureum has raised a lot of Ether and decided to buy a bunch of <code>InSecureumToken</code> (<b>$ISEC</b>) in order to make them available to the community
        via flash loans. This is made possible by means of the <code>InSecureumLenderPool</code> contract.
      </p>
      <p>
        📌 The idea is that anyone can deposit <b>$ISEC</b>s to enlarge the pool's resources.
      </p>
      <p>
        Will you be able to <b>steal</b> the <b>$ISEC</b>s from the <code>InSecureumLenderPool</code>? 😈😈😈
      </p>
  
      Contracts;<br />
        <ul>
          {#each instancesDescriptions as {href, text}}
            <li><a class="link" href="{href}" target="_blank">{text}</a></li>
          {/each}
        </ul>
    </div>
  </ChallengeElement>
  
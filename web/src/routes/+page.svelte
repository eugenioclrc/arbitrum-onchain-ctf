<svelte:head>
  <title>CTF on chain</title>
</svelte:head>

<div class="min-h-screen max-w-md md:max-w-full flex flex-col">
  <div class="w-full h-1/2 min-h-[360px] flex-grow text-center hero bg-black" style="background-image: url(/logo.png);">
    <div class="flex flex-col">
      <div class="text-white text-6xl" style="
		text-shadow: 1px 0 0 #000, 0 -1px 0 #000, 0 1px 0 #000, -1px 0 0 #000;
	">Onchain CTF Protocol

	  </div><br />
	  <div class="text-white text-xl">
	  Build your onchain resume with Arbitrum
	  </div>
		<br>
      <a href="/play" class="btn btn-accent mx-4 md:mx-0 text-2xl">Let`s play!
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
          <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
        </svg>
        
      </a>
    </div>

  </div>
  <div class="bg-base-300 w-full h-1/2 py-5 flex-grow hero">
    <div class="flex flex-col xl:flex-row">
      <div class="card w-96 bg-base-100 shadow-xl m-2">
        <div class="card-body">
          <h2 class="card-title">Description</h2>
          <p>
            This Workshop consists in a series of challenges, of increasing difficulty, targetting 
            different <b>concepts</b> and common <b>vulnerabilities</b> found in <b>DeFi</b>. The CTF 
            is designed in different flavors for all kinds of users. 
            <a href="https://github.com/eugenioclrc/DeFi-Security-Summit-Stanford" target="_blank" class="link-secondary">Check out the repo</a>.
          </p>
        </div>
      </div>
      <div class="card w-96 bg-base-100 shadow-xl m-2">
        <div class="card-body">
          <h2 class="card-title">How do i play? 🕹️</h2>
          <p>
            First make sure that you have installed the Metamask extension.<br />
            Then make sure you have some Görli ETH on arbitrum, which you will use to send transactions. If 
			not you can get some from <a href="https://goerli-faucet.pk910.de/" target="_blank" class="link-primary">this faucet</a>
			and then you have to <a href="https://bridge.arbitrum.io/?l2ChainId=421613" target="_blank" class="link-primary"> bridge funds to Arbitrum testnet</a>
			<br />
            Finally click play to connect your wallet.
          </p>
        </div>
      </div>
      <div class="card w-96 bg-base-100 shadow-xl m-2">
        <div class="card-body">
          <h2 class="card-title">Especial thanks</h2>
          <p>
            Built by <a class="link-primary" target="_blank" href="https://github.com/eugenioclrc">eugenioclrc</a> and <a class="link-primary" target="_blank" href="https://github.com/luksgrin">luksgrin</a><br>
            special thanks to <a class="link-primary" target="_blank" href="https://github.com/patrickd-">patrickd</a>, <a class="link-primary" target="_blank" href="https://github.com/StErMi">StErMi</a>, <a class="link-primary" target="_blank" href="https://github.com/tinchoabbate">tinchoabbate</a> and <a href="https://twitter.com/0xrajeev" class="link-primary" target="_blank" rel="nofollow">Rajeev</a> for reviewing, commenting and helping during the elaboration and design of this CTF Workshop
          </p>
        </div>
      </div>
    </div>
  </div>
</div>
<script>

    import { wallet } from '$lib/eth.js';
    import getContract from '$lib/contract.js';
    import getNft from '$lib/nft.js';
    import confetti from 'canvas-confetti';
    
    import {Challenges} from '$lib/store.js';
    
    export let size = "";
    export let nChallenge;
    let hasBeenMinted = false;
    export let addressChallenge = "";
    export let nameChallenge = '';
    export let instancesDescriptions = [{href: '', text: ''}];
    
    let deploying = false;
    let modal = false;
    
    let solved = false;
    let notSolved = false;
    let instances = [];
    
    const twitterLink = "https://twitter.com/intent/tweet?text="+encodeURIComponent("I have just solve Challenge '"+nameChallenge+"' on https://ctf-maker-monorepo.vercel.app/play/challenge"+nChallenge+" #DEFISecuritySummitStanford #ctf #blockchain #defi")
    
    async function mint() {
        const _data = await (await fetch(`/sign?player=${$wallet}&challenge=${addressChallenge}`)).json()
        console.log(_data);
        const nft = await getNft();
        await nft.mint(
            $wallet, addressChallenge, _data.nftUrl, _data.signature
        );
    }

    async function loadData() {

      try {
      const contract = await getContract();
        instances = await contract.getChallengesInstances($wallet, addressChallenge);
        if(instances && instances.length) {
            solved = await contract.checkChallenge($wallet, addressChallenge);
        }
        const nft = await getNft();
    hasBeenMinted = Number(await nft.balanceOf($wallet, addressChallenge));
      } catch(err) {
        console.log({err})
      }
    }
    
    $: if($wallet && typeof nChallenge != 'undefined') {
      loadData();
      window.m = mint;
    }
    
    async function deploy() {
      const contract = await getContract();
      deploying = true;
      try {
        const tx = await contract.deployChallenge(addressChallenge);
        await tx.wait();
        
      } catch (e) {
        alert(e);
      }
      await loadData();
      deploying = false;
    }
    
    let showModal = false;
    
    async function check() {
      if (!solved) {
        notSolved = false;
        const contract = await getContract();
        solved = await contract.checkChallenge($wallet, addressChallenge);

        notSolved = !solved;
        // if (solved && !showModal) {
        //   showModal = true;
        //   setTimeout(() => {
        //     modal = true;
        //   }, 700);
        // }
      }
      if (solved) {
        confetti();
        if (solved && !showModal && !hasBeenMinted) {
          showModal = true;
          setTimeout(() => {
            modal = true;
          }, 700);
        }
      }
    }
    
    </script>
    
    <div class="max-w-8xl mx-auto px-4 sm:px-6 md:px-8">
      <div class="hero min-h-screen">
        <div class="hero-content flex-col lg:flex-row">
          <div class="card flex-shrink-0 w-full {size} shadow-2xl bg-base-100">
            <div class="card-body">
              <article class="prose">
                <h1 class="text-4xl font-bold">
                  {#if solved}
                    <span class="text-green-500">✓</span>
                  {/if}
                  <span class:line-through={solved}>
                    <slot name="title" />
                  </span>
                </h1>
                <slot name="content" />
              {#if instances && instances.length}
                <div class="font-mono">The contracts are deployed on;<br />
                  {#each instancesDescriptions as desc, i}
                    <a class="btn-link font-bold" href={desc.href} target="_blank">{desc.text}</a><br />
                    <span class="break-all">{instances[i]}</span><br />
                  {/each}
                </div>  
              {/if}
    
    
              <div class="form-control mt-6 w-1/2 mx-auto">
                {#if instances && instances.length}
                  {#if solved}

                  <button on:click={mint} disabled=hasBeenMinted} class="btn text-white no-underline text-xl btn-secondary mt-2" >Mint</button>
                  {/if}
                  <button on:click={() => check()} class:shake={notSolved} class="btn" class:btn-secondary={!solved} class:btn-link={solved}>Check</button>
                  <button on:click={() => deploy()} class:loading={deploying} class="btn btn-warning mt-2">Reset</button>
                {:else}
                  <button on:click={() => deploy()} class:loading={deploying} class="btn btn-primary">Deploy</button>
                {/if}
                <a href="/play" class="btn btn-outline mt-2">All challenges</a>
              </div>
              </article>
    
            </div>
          </div>
          <slot name="right" />
        </div> 
      </div>
    </div>
    
    
    <input type="checkbox" checked={modal} id="my-modal" class="modal-toggle" />
    <div class="modal">
      <div class="modal-box">
        <label on:click={() => modal = false} for="my-modal-3" class="btn btn-ghost btn-sm btn-circle absolute right-2 top-2">✕</label>
        <h3 class="font-bold text-lg">Congratulations for breaking this challenge!</h3>
        <p class="py-4">You are awesome! Why don`t you brag this achievement with your by minting an NFT?</p>
        <div class="modal-action">
            <button disabled={hasBeenMinted} on:click={() => { modal = false; mint(); }} class="btn text-white no-underline text-xl btn-secondary mt-2">Mint</button>
        </div>
      </div>
    </div>
    
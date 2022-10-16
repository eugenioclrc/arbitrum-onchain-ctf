<script>
    import { onMount } from 'svelte';
    import { login, init, wallet, chainId, changeNetwork } from '$lib/eth.js';
    // import { dev } from '$app/environment';
    
    import Header from './Header.svelte';
  import { PUBLIC_CHAINID } from '$env/static/public';
  
    onMount(
      async () => {
        // add a test to return in SSR context
        try {
          await init();
        } catch (err) {}
      }
    );
  </script>
  
  <svelte:head>
    <script type="text/javascript" src="https://unpkg.com/web3modal@1.9.8/dist/index.js"></script>
    <script type="text/javascript" src="https://unpkg.com/@walletconnect/web3-provider@1.7.8/dist/umd/index.min.js"></script>
  </svelte:head>
  {#if !$wallet}
    <div class="hero min-h-screen bg-base-200">
      <div class="hero-content flex-col lg:flex-row-reverse">
          <div class="card flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
            <div class="card-body">
                <div class="text-center lg:text-left">
                  <h1 class="text-4xl font-bold">Connect now!</h1>
                  <p class="py-6">To start playing please connect your metamask to this page</p>
                </div>
              
              <div class="form-control mt-6">
                <button on:click={login} class="btn btn-primary">Connect</button>
              </div>
            </div>
          </div>
      </div>
    </div>
    <!--  /* chaiin 421613 31337*/  -->
  {:else if $chainId != PUBLIC_CHAINID}
    <div class="hero min-h-screen bg-base-200">
      <div class="hero-content flex-col lg:flex-row-reverse">
          <div class="card flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
            <div class="card-body">
                <div class="text-center lg:text-left">
                  <h1 class="text-4xl font-bold">Wrong network</h1>
                  <p class="py-6">
                    Please connect to <b>Arbitrum Görli</b>, you can search and 
                    add it from <a class="link-primary" href="https://chainlist.org/" rel="noreferrer" target="_blank">https://chainlist.org/</a>
                  </p>
                </div>
              
              <div class="form-control mt-6">
                <button on:click={changeNetwork} class="btn btn-primary">Change network</button>
              </div>
            </div>
          </div>
      </div>
    </div>
  {:else}
    <Header />
    <slot />
  {/if}
  
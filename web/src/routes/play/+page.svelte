<script>
    import { wallet } from '$lib/eth.js';    
    import { Challenges } from '$lib/store.js';    
  </script>
  <svelte:head>
    <title>Demo challenges</title>
  </svelte:head>
  <div class="hero min-h-screen bg-base-200">
    <div class="hero-content flex-col lg:flex-row-reverse">
        <div class="card flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
          <div class="card-body">
            <div class="text-center lg:text-left">
              <h1 class="text-5xl font-bold">Challenges</h1>
              {#if $wallet}
                <p class="py-6">Welcome 
                  <b>{$wallet.slice(0,6)}...{$wallet.slice(-6)}</b>
                  <br />
                  <span class="underline">Please pick your challenge:</span>
                </p>
              {/if}
            </div>
            {#each ["Warm up","Take a flash loan"] as tip,s}
              <div class="form-control mt-6">
                <div class="tooltip" data-tip={tip}>
                  <a href="/play/challenge{s}" class="btn btn-primary" class:btn-link={$Challenges[s].solved}>
                    {#if $Challenges[s].solved}
                      <span class="text-green-500">✓</span>
                    {/if}
                    <span class:line-through={$Challenges[s].solved}>Challenge {s}</span>
                  </a>
                </div>
              </div>
            {/each}
            
          </div>
        </div>
    </div>
  </div>
import { writable, derived, get } from 'svelte/store';

import { wallet } from './eth';
import getContract from './contract';


function createChallenges() {
  const emptyBase = { instances: [], solved: false };
  const { subscribe, set, update } = writable(Array(4).fill(emptyBase));
  const ret = {
		subscribe,
    async check(nChallenge) {
      const $wallet = get(wallet);
      if (!$wallet) return;
      const $c = await getContract();
      
      const solved = await $c.checkChallenge($wallet, nChallenge);
      const newRet = get(ret);
      newRet[nChallenge].solved = solved;
      update(() => [...newRet]);
    },
    async load(nChallenge) {
      const $wallet = get(wallet);
      if(!$wallet) return;
      const $c = await getContract();
      const instances = await $c.getChallengesInstances($wallet, nChallenge);
      const solved = await $c.checkChallenge($wallet, nChallenge);
      const newRet = get(ret);
      newRet[nChallenge] = { instances, solved };
      update(() => [...newRet]);
    },
		reset: () => set(Array(4).fill(emptyBase))
	};
  wallet.subscribe(async ($wallet) => {
    ret.reset();
    if (!$wallet) {
      return;
    }
    try {
      const $c = await getContract();

      const solved = await $c.getChallengesNumber($wallet);
      const newRet = get(ret);
      for (let i = 0; i < solved.length; i++) {
        newRet[i].solved = solved[i];
      }
      set([...newRet]);
    } catch(err) {
      console.error(err);
    }
  });

	return ret;
}

export const Challenges = createChallenges();

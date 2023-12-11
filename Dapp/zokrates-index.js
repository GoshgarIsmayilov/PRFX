import zokrates_hash from './zokrates-hash';
import zokrates_prefix_proof from './zokrates-prefix';

window.zokrates_hash = async function(s, r){
    return await zokrates_hash(s, r);
}

window.zokrates_prefix_proof = async function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15){
    return await zokrates_prefix_proof(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15);
}
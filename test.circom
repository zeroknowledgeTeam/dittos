pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/sha256/sha256_2.circom";

// c = H(a,b)
template Main() {
    signal input a; //private
    signal input b; //private
    signal input c;
    signal output out;

    component sha256_2 = Sha256_2();

    sha256_2.a <== a;
    sha256_2.b <== b;
    out <== sha256_2.out;
    c === out;
}

component main = Main();

// pragma circom 2.0.0;

// include "../node_modules/circomlib/circuits/eddsamimc.circom";

// component main = EdDSAMiMCVerifier();

// pragma circom 2.0.0;

// include "../node_modules/circomlib/circuits/eddsaposeidon.circom";

// component main = EdDSAPoseidonVerifier();

// pragma circom 2.0.0;

// include "../node_modules/circomlib/circuits/eddsa.circom";

// component main = EdDSAVerifier(8);

// pragma circom 2.0.0;

// include "../node_modules/circomlib/circuits/pedersen.circom";
// include "../node_modules/circomlib/circuits/bitify.circom";


// template Main() {
//     signal input in;
//     signal output out[2];

//     component pedersen = Pedersen(256);

//     component n2b;
//     n2b = Num2Bits(253);

//     var i;

//     in ==> n2b.in;

//     for  (i=0; i<253; i++) {
//         pedersen.in[i] <== n2b.out[i];
//     }

//     for (i=253; i<256; i++) {
//         pedersen.in[i] <== 0;
//     }

//     pedersen.out[0] ==> out[0];
//     pedersen.out[1] ==> out[1];
// }

// component main = Main();



module dittos::dittos {
    use std::error;
    use std::signer;
    use aptos_std::groups::{Self, scalar_deserialize, BLS12_381_G1, BLS12_381_G2, deserialize_element_uncompressed, BLS12_381_Gt, BLS12_381_Fr}; //, serialize_element_uncompressed};
    use aptos_std::groth16::{ verify_proof, new_vk, new_proof};

//:!:>resource
    struct Uint8 has key {
        a: u8,
    }
//<:!:resource

    /// There is no message present
    const ENO_UINT: u64 = 0;

    public fun getUint(addr: address): u8 acquires Uint8 {
        assert!(exists<Uint8>(addr), error::not_found(ENO_UINT));
        *&borrow_global<Uint8>(addr).a
    }

    public entry fun setUint(account: signer, a: u8)
    acquires Uint8 {
        // assert!(verify(&account), 1);
        let account_addr = signer::address_of(&account);
        if (!exists<Uint8>(account_addr)) {
            move_to(&account, Uint8 {
                a
            })
        } else {
            let old_uint_holder = borrow_global_mut<Uint8>(account_addr);
            old_uint_holder.a = a;
        }
    }

    #[test(account = @0x1)]
    public fun verify(account : signer) {
        std::features::change_feature_flags(&account, vector[std::features::get_generic_group_basic_operations_feature(), std::features::get_bls12_381_groups_feature()], vector[]);

        let gamma_abc_g1: vector<groups::Element<BLS12_381_G1>> = vector[
            std::option::extract(&mut deserialize_element_uncompressed<BLS12_381_G1>(x"5bc4cfaeac82f7cdfa6419f47dee6975765288206bc558d6ddd1c8aef597f42c24356676800d26215b87323db405d01148457f5d78b22cad12e84a38bae36d9b497edcfe5c756477cf2e2ad1275f77b00b21c6a948c950cf6fcf355e303ca117")),
            std::option::extract(&mut deserialize_element_uncompressed<BLS12_381_G1>(x"a1c404f7f6ff8f4d684a01f2e62f94b1dc23964dccf4829062547ecbee02b1222443c1ff8b9569e72a0b84b0debf380991608f9de5837e8196d1d4e7d5bae1f0d998462c2943c6f267a0582bedfd185b657f1533a12ec55209556ce503eec60e")),
        ];

        let vk = new_vk<BLS12_381_G1,BLS12_381_G2,BLS12_381_Gt>(
            std::option::extract(&mut deserialize_element_uncompressed<BLS12_381_G1>(x"60e218c3888ee42e4f59b1f3de7ca6b4b9da24ad9dc3554be1fe94ee44a1962f197e8857cbb872553cf227237435a9054c5f56c4254f0cc6323da7926e3cf97b3d568626af73345f1917d87ac2e8872305458ba4e2ab05f7271e03ef28cbc202")),
            std::option::extract(&mut deserialize_element_uncompressed<BLS12_381_G2>(x"975d11c29720c4a94641e99058292066f233dc3777375592fbd28c160af917843e5c4603b3a745d9211d03a9185db00d9bdb1c646692f81d2fc2403e74a34cbcb2489ffb5c8ad6d1120808cb004967e4121763c9bd29bce672e490aea8c6570c2e46e5b70d7b62354b382c136016b956bd0bbf9332009502996b75f7cf9cbb52d23c88093bb7e5077d7dd031e593f00d7bfbdbb6d950b0ebbc83c7f1fd0b6b56bacd7011ae0e3ffbd67d68257c10e990298c993a079490d218a4c24821db1214")), //beta_g2
            std::option::extract(&mut deserialize_element_uncompressed<BLS12_381_G2>(x"b8bd21c1c85680d4efbb05a82603ac0b77d1e37a640b51b4023b40fad47ae4c65110c52d27050826910a8ff0b2a24a027e2b045d057dace5575d941312f14c3349507fdcbb61dab51ab62099d0d06b59654f2788a0d3ac7d609f7152602be0130128b808865493e189a2ac3bccc93a922cd16051699a426da7d3bd8caa9bfdad1a352edac6cdc98c116e7d7227d5e50cbe795ff05f07a9aaa11dec5c270d373fab992e57ab927426af63a7857e283ecb998bc22bb0d2ac32cc34a72ea0c40606")), //gamma_g2
            std::option::extract(&mut deserialize_element_uncompressed<BLS12_381_G2>(x"b8bd21c1c85680d4efbb05a82603ac0b77d1e37a640b51b4023b40fad47ae4c65110c52d27050826910a8ff0b2a24a027e2b045d057dace5575d941312f14c3349507fdcbb61dab51ab62099d0d06b59654f2788a0d3ac7d609f7152602be0130128b808865493e189a2ac3bccc93a922cd16051699a426da7d3bd8caa9bfdad1a352edac6cdc98c116e7d7227d5e50cbe795ff05f07a9aaa11dec5c270d373fab992e57ab927426af63a7857e283ecb998bc22bb0d2ac32cc34a72ea0c40606")), //delta_g2
            gamma_abc_g1
        );

        let proof = new_proof<BLS12_381_G1,BLS12_381_G2,BLS12_381_Gt>(
            std::option::extract(&mut deserialize_element_uncompressed<BLS12_381_G1>(x"f69c3a3751a830ae7d03d70d4f0f9f452c6debd4699d6a3ddea28eb7a82286b444b218a681109bfb861cca563ee6cd04366465bd19bd03a64f450e8193d86dedb86ac430ec3b5678f2a92939e01db76e46edda5f00047cbb188c483626fbac16")),
            std::option::extract(&mut deserialize_element_uncompressed<BLS12_381_G2>(x"b8a076279c44f37d310bda0683d569b0e656b51023167aa37db2a18a1dfcac17076977604f7be5a02d428a193369c7033324baff55d25f909866efcbb8dec687fe4635bd56d46d3a1f215267c03e3a0b7f3ff04ca2f400f8949ce7d7d096f90d3f1eeb5956d8485a1cc12574edf86bdc3ce504b969c34316179381a665137ad6231b18d51aa4e326b0675b5053913d1247985e8d35811d8a05e63f1b5665de556672df74a6c9593f27cadefb73e9815daaf2bfc696b91de2d290be17fc144711")),
            std::option::extract(&mut deserialize_element_uncompressed<BLS12_381_G1>(x"7b85ae5c3934483e8aa947165c53dbd09235b3952bed21327c5f21b710eccdb5b917d8b4879ee4a351e8404113ee231299bc9ffb29468227cd79120f3d98999da30680842bce9dfafd282d52e622d0c4c213d10d0dc67dc0103cf4748519180b"))
        );

        let public_inputs: vector<groups::Scalar<BLS12_381_Fr>> = vector[
            std::option::extract(&mut scalar_deserialize<BLS12_381_Fr>(&x"8b27a1ae6fe05d7fc384ed97b0d5aad4a8b85ef0bdbc59f47b73b00000000000")),
        ];
        assert!(verify_proof(&vk, &public_inputs, &proof), 1);
        // verify_proof(&vk, &public_inputs, &proof)

    }
}

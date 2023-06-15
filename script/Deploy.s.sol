// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Script.sol";
import "src/tokens/NFT721.sol";
import "src/tokens/NFT1155.sol";
import "src/tokens/Token.sol";

contract Deploy is Script {
    Token token;
    NFT721 nft721;
    NFT1155 nft1155;

    function run() public {
        vm.startBroadcast();
        deploy();
        mintToken();
        mint721();
        mint1155();
        vm.stopBroadcast();
    }

    function deploy() public {
        token = new Token();
        nft721 = new NFT721();
        nft1155 = new NFT1155();
    }

    function mintToken() public {
        token.mint(1000 * 10e18);
    }

    function mint721() public {
        nft721.mint();
    }

    function mint1155() public {
        nft1155.mint(1);
    }
}

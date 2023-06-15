// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT721 is ERC721, Ownable {
    uint256 public currentId;

    constructor() ERC721("ERC721", "NFT") {}

    function mint(uint256 _amount) external {
        for (uint256 i; i < _amount; ++i) {
            _mint(msg.sender, ++currentId);
        }
    }

    function burn(uint256 _tokenId) external {
        _burn(_tokenId);
    }
}

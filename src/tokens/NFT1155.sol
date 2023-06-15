// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT1155 is ERC1155, Ownable {
    string public name;
    string public symbol;
    uint256 public currentId;

    constructor() ERC1155("") {
        name = "ERC1155";
        symbol = "NFT";
    }

    function mint(uint256 _amount) external {
        _mint(msg.sender, ++currentId, _amount, "");
    }

    function burn(uint256 _id, uint256 _amount) external {
        _burn(msg.sender, _id, _amount);
    }
}

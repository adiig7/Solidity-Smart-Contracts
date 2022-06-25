// A minimal NFT minting smart contract
// Deployed to RINKEBY TESTNET: 0x358AA13c52544ECCEF6B0ADD0f801012ADAD5eE3

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract GameItem is ERC721{
    constructor() ERC721("GameItem", "ITM") {
        _mint(msg.sender, 1);
    }
}

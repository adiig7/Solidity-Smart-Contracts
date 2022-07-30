// NFT Smart Contract using IPFS
// Deployed on RINKEBY: 0xd9145CCE52D386f254917e481eB44e9943F39138

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract DopeNFTees is ERC721, ERC721Enumerable, ERC721URIStorage{
    using Counters for Counters.Counter;

    uint256 MAX_SUPPLY = 10000;

    Counters.Counter private _totalMintedNFTs;
    constructor() ERC721("Aditya", "ADIIG7"){
    }

    function safeMint(address to, string memory uri) public{
        uint tokenId = _totalMintedNFTs.current();
        require(tokenId < MAX_SUPPLY, "Oooppss! we are out of our stock :(");
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }


}

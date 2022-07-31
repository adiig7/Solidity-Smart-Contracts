// 0x595ED8547d82fd0F9916eC4eF61C7c001652bb60

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract FootNFTs is ERC721URIStorage{
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    struct footballPlayer{
        uint256 ranking;
        uint256 goals;
        uint256 numberOfClubs;
    }

    mapping(uint256 => footballPlayer) public tokenIdToPlayer;


    constructor() ERC721("Foot NFTs", "FOOT"){}

    function generateCharacter(uint256 tokenId) public view returns(string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',"Warrior",'</text>',
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Levels: ",getRanking(tokenId),'</text>',
            '</svg>'
        );
        return string(
            abi.encodePacked(
                 "data:image/svg+xml;base64,",
            Base64.encode(svg)
            )
        );
    }

    function getRanking(uint256 tokenId) public view returns(string memory){
        uint256 ranking = tokenIdToPlayer[tokenId].ranking;
        return ranking.toString();
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory){
    bytes memory dataURI = abi.encodePacked(
        '{',
            '"name": "Chain Battles #', tokenId.toString(), '",',
            '"description": "Battles on chain",',
            '"image": "', generateCharacter(tokenId), '"',
        '}'
    );
    return string(
        abi.encodePacked(
            "data:application/json;base64,",
            Base64.encode(dataURI)
        )
    );
}

    function mint() public {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _safeMint(msg.sender, newTokenId);
        tokenIdToPlayer[newTokenId].ranking = 0;
        tokenIdToPlayer[newTokenId].goals = 0;
        tokenIdToPlayer[newTokenId].numberOfClubs = 0;

        _setTokenURI(newTokenId, getTokenURI(newTokenId));
    }

    function rankUp(uint256 tokenId) public{
        require(_exists(tokenId));
        require(ownerOf(tokenId) == msg.sender, "Only owner can train their NFT");
        uint256 currentLevel = tokenIdToPlayer[tokenId].ranking;
        tokenIdToPlayer[tokenId].ranking = currentLevel+1;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}

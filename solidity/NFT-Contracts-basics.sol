//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BlockchainBeyondBasics is ERC721URIStorage  {
using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    uint256 public constant totalMintable=100;
    string public constant tokenURI = "https://ipfs.io/ipfs/QmeM7CTkJLNqHzU19XASNxc8brT2aLSr5HQfMz4LH2GBsR";

    constructor() ERC721("BlockchainBeyondBasics", "BBB") {}

    function BBBmintNFT() public returns (uint256)
    {
        _tokenIds.increment();
        uint256 nextTokenId = _tokenIds.current();
        require(nextTokenId <= totalMintable, "Max Mintable Limit Reached!");

        _safeMint(msg.sender, nextTokenId);
        _setTokenURI(nextTokenId, tokenURI);
        return nextTokenId;
    }
}
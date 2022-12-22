//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.8;

// importing the ERC721 URIStorage contract for NFT creation.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

// importing the utility contract for counters.
import "@openzeppelin/contracts/utils/Counters.sol";

//create a contract named BlockchainBeyondBasics, that inherits all the property of ERC721
contract BlockchainBeyondBasics is ERC721URIStorage  {

//use the utility counter  
using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    // To mine max 100 NFTs of the image
    uint256 public constant totalMintable=100;

    //IPFS URL of the Metadata file
    string public constant tokenURI = "https://ipfs.io/ipfs/QmeM7CTkJLNqHzU19XASNxc8brT2aLSr5HQfMz4LH2GBsR";

    //initiate a constructor for the NFT contract as BlockchainBeyondBasics with code BBB
    constructor() ERC721("BlockchainBeyondBasics", "BBB") {}

    //define a function to mint maximum 100 NFTs  
    function BBBmintNFT() public returns (uint256)
    {
        //auto increment the token_id
        _tokenIds.increment();
        uint256 nextTokenId = _tokenIds.current();

        //Ensure maximum 100 NFTs
        require(nextTokenId <= totalMintable, "Max Mintable Limit Reached!");

        //Mint the NFT using next token ID, with the TokenURI using the safemint function.
        //Mint a NFT, and assign it to the executioner of the contract(msg.sender)
        //_safeMint() is used in conjunction with IERC721Receiver which checks 
        //whether you are sending the minted token to an NFT-enabled contract or not. 
        //This is to prevent tokens from being lost.
        _safeMint(msg.sender, nextTokenId);
        _setTokenURI(nextTokenId, tokenURI);
        return nextTokenId;
    }
}
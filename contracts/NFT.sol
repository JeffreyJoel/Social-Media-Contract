// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721URIStorage, Ownable {
    constructor(
        string memory _symbol,
        string memory _name
    ) ERC721(_symbol, _name) {}

    function mint(uint _tokenId, string calldata _tokenUri) external onlyOwner {
        _mint(msg.sender, _tokenId);
        _setTokenURI(_tokenId, _tokenUri);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./NFT.sol"; // Import the NFT contract definition

contract NFTFactory {
    address[] public deployedNFTs;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function createNFT(string memory _name, string memory _symbol) public {
        require(msg.sender == owner, "Only the contract owner can create NFTs");
        NFT newNFT = new NFT(_name, _symbol, msg.sender); // Deploy a new instance of the NFT contract
        deployedNFTs.push(address(newNFT));
    }

    function getDeployedNFTs() public view returns (address[] memory) {
        return deployedNFTs;
    }
}

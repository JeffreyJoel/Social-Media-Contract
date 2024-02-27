// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./NFT.sol";

contract SocialMediaPlatform is  Ownable {
    enum UserRole {
        Admin,
        Creator,
        Moderator
    }

    // NFTFactory public nftFactory;

    struct User {
        string username;
        address userAddress;
        bool isRegistered;
    }

    // struct NFT {
    //     address nftAddress;
    //     string name;
    //     string symbol;
    // }

    struct Content {
        address creator;
        string contentHash;
        uint256 timestamp;
    }

    mapping(address => User) public users;
    mapping(address => UserRole) public userRoles;
    // mapping(uint256 => NFT) public nfts;
    mapping(address => NFT) public nfts;
    mapping(uint256 => Content) public contents;

    uint256 public nftCount;
    uint256 public contentCount;

    constructor() {
        setUserRole(msg.sender, UserRole.Admin);
    }

    function registerUser(string memory _username) public {
        require(!users[msg.sender].isRegistered, "User already registered");
        users[msg.sender] = User(_username, msg.sender, true);
    }

    function setUserRole(address user, UserRole role) public onlyAdmin {
        userRoles[user] = role;
    }

    function createNFT(
        string memory _name,
        string memory _symbol
    ) public onlyCreator returns (address) {
        NFT newNFT = new NFT(_symbol, _name);
        nftCount++;
        nfts[address(newNFT)] = newNFT;
        return address(newNFT);
    }

    //    function createNFT(string memory _name, string memory _symbol) public {
    //         nftFactory.createNFT(_name, _symbol);
    //     }
    function publishContent(string memory contentHash) public onlyCreator {
        contents[contentCount] = Content(
            msg.sender,
            contentHash,
            block.timestamp
        );
        contentCount++;
    }

    

    modifier onlyAdmin() {
        require(
            userRoles[msg.sender] == UserRole.Admin,
            "Caller is not an admin"
        );
        _;
    }

    modifier onlyCreator() {
        require(
            userRoles[msg.sender] == UserRole.Creator,
            "Caller is not a creator"
        );
        _;
    }
}

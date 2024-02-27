// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./NFTFactory.sol";

contract SocialMediaPlatform is IERC721Receiver, Ownable {
    enum UserRole {
        Admin,
        Creator,
        Moderator
    }

    NFTFactory public nftFactory;

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
    mapping(uint256 => NFT) public nfts;
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

    // function createNFT(
    //     address _nftAddress,
    //     string memory _name,
    //     string memory _symbol
    // ) public onlyCreator {
    //     nfts[nftCount] = NFT(_nftAddress, _name, _symbol);
    //     nftCount++;
    // }
   function createNFT(string memory _name, string memory _symbol) public {
        nftFactory.createNFT(_name, _symbol);
    }
    function publishContent(string memory contentHash) public onlyCreator {
        contents[contentCount] = Content(
            msg.sender,
            contentHash,
            block.timestamp
        );
        contentCount++;
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external pure override returns (bytes4) {
        return this.onERC721Received.selector;
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

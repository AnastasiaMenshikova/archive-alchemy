//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract NFTMarketplace is ERC721URIStorage {
    using Counters for Counters.Counter;

    /* ========== EVENTS ========== */

    /**
     * @notice The event emitted when a token is successfully listed
     */
    event TokenListedSuccess(
        uint256 indexed tokenId,
        address owner,
        address seller,
        uint256 price,
        bool currentlyListed
    );

    /* ========== STATE VARIABLES ========== */

    Counters.Counter private _tokenIds; // track how many NFTs was minted
    Counters.Counter private _itemSold; // track how many NFTs was sold

    mapping(uint256 => ListedToken) private idToListedTokens; // tokenId => token info (ListedToken)

    uint256 listPrice = 0.01 ether; // mint fee

    address payable owner;

    /* ========== TYPES ========== */

    /**
     * @notice The structure to store info about a listed token
     */
    struct ListedToken {
        uint256 tokenId;
        address payable owner;
        address payable seller;
        uint256 price;
        bool currentlyListed;
    }

    /* ========== CONSTRUCTOR ========== */

    constructor() ERC721("NFTMarketplace", "NFTM") {
        owner = payable(msg.sender);
    }

    /* ========== FUNCTIONS ========== */

    function createToken(string memory tokenUri, uint256 price) public payable returns (uint256) {
        require(msg.value == listPrice, "Send enough ether to list");
        require(price > 0, "Make sure price isn't negative");

        _tokenIds.increment();
        uint256 currentTokenId = _tokenIds.current();
        _safeMint(msg.sender, currentTokenId);
        _setTokenURI(currentTokenId, tokenUri);

        createListedToken(currentTokenId, price);

        return currentTokenId;
    }

    function createListedToken(uint256 tokenId, uint256 price) private {
        idToListedTokens[tokenId] = ListedToken(
            tokenId,
            payable(address(this)),
            payable(msg.sender),
            price,
            true
        );

        _transfer(msg.sender, address(this), tokenId);
    }

    function updateListPrice(uint256 _listPrice) public payable {
        require(owner == msg.sender, "Only owner can update the listing price");
        listPrice = _listPrice;
    }

    function executeSale(uint256 tokenId) public payable {
        uint256 price = idToListedTokens[tokenId].price;
        require(msg.value == price, "Please submit the asking price for NFT in order to purchase");

        address seller = idToListedTokens[tokenId].seller;
        idToListedTokens[tokenId].currentlyListed = true;
        idToListedTokens[tokenId].seller = payable(msg.sender);
        _itemSold.increment();

        _transfer(address(this), msg.sender, tokenId);

        approve(address(this), tokenId);

        payable(owner).transfer(listPrice);
        payable(seller).transfer(msg.value);
    }

    /* ========== GETTERS ========== */

    function getListPrice() public view returns (uint256) {
        return listPrice;
    }

    function getLatestIdToListedToken() public view returns (ListedToken memory) {
        uint256 currentTokenId = getCurrentToken();
        return getListedForTokenId(currentTokenId);
    }

    function getListedForTokenId(uint256 _tokenId) public view returns (ListedToken memory) {
        return idToListedTokens[_tokenId];
    }

    function getCurrentToken() public view returns (uint256) {
        return _tokenIds.current();
    }

    function getAllNfts() public view returns (ListedToken[] memory) {
        uint256 nftCount = _tokenIds.current();
        ListedToken[] memory tokens = new ListedToken[](nftCount);

        uint256 currentIndex = 0;
        for (uint256 i = 0; i < nftCount; i++) {
            uint256 currentId = i + 1;
            ListedToken storage currentItem = idToListedTokens[currentId];
            tokens[currentIndex] = currentItem;
            currentIndex += 1;
        }

        return tokens;
    }

    function getMyNfts() public view returns (ListedToken[] memory) {
        uint256 totalItemCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalItemCount; i++) {
            uint256 currentId = i + 1;
            if (
                idToListedTokens[currentId].owner == msg.sender ||
                idToListedTokens[currentId].seller == msg.sender
            ) {
                itemCount += 1;
            }
        }

        ListedToken[] memory items = new ListedToken[](itemCount);
        currentIndex = 0;
        for (uint256 i = 0; i < itemCount; i++) {
            uint256 currentId = i + 1;
            if (
                idToListedTokens[currentId].owner == msg.sender ||
                idToListedTokens[currentId].seller == msg.sender
            ) {
                ListedToken storage currentItem = idToListedTokens[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }

        return items;
    }
}

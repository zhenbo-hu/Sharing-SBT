// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import {ERC721URIStorageUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import {ERC721BurnableUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {CountersUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

contract SharingSBT is ERC721Upgradeable, ERC721URIStorageUpgradeable, ERC721BurnableUpgradeable, OwnableUpgradeable {
    using CountersUpgradeable for CountersUpgradeable.Counter;

    CountersUpgradeable.Counter private _tokenIdCounter;

    mapping(uint256 => address) private _tokenOwners;

    mapping(address => uint256) private _ownerTokens;

    function initialize() public initializer {
        __ERC721_init("SharingSBT", "SSBT");
        __Ownable_init();
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize) internal override(ERC721Upgradeable) {
        require(from == address(0), "Token not transferable");
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function mint(address to) public onlyOwner {
        require(_ownerTokens[to] != 0, "SharingSBT: everyone only can have one Sharing soul bound token");

        // counter start from 1
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();

        _safeMint(to, tokenId);

        _tokenOwners[tokenId] = to;
        _ownerTokens[to] = tokenId;
    }

    function _burn(uint256 tokenId) internal override(ERC721Upgradeable, ERC721URIStorageUpgradeable) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721Upgradeable, ERC721URIStorageUpgradeable) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}

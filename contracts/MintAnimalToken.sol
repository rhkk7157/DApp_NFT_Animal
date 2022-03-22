// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MintAnimalToken is ERC721Enumerable {
  constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

  mapping (uint256 => uint256) public animalTypes;

  function mintAnimalToken() public {

    uint256 animalTokenId = totalSupply() + 1;  // 지금 까지 민팅된 NFT 총량
    uint256 animalType = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, animalTokenId))) % 5 + 1;  // 1 ~ 5 까지 랜덤 

    animalTypes[animalTokenId] = animalType;
    _mint(msg.sender, animalTokenId);

  }
}
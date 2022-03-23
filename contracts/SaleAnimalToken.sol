// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./MintAnimalToken.sol";

contract SaleAnimalToken {
  MintAnimalToken public mintAnimalTokenAddress;

  constructor(address _mintAnimalTokenAddress) {
    mintAnimalTokenAddress = MintAnimalToken(_mintAnimalTokenAddress);
  }

  mapping (uint256 => uint256) public animalTokenPrices;  // 가격관리 mapping (tokenId => price)
  uint256[] public onSaleAnimalTokenArray;  // 프론트에서 어떤게 판매중인 토큰인지 확인가능한 배열

  // 판매
  function setForSaleAnimalToken(uint256 _animalTokenId, uint256 _price) public {
    address animalTokenOwner = mintAnimalTokenAddress.ownerOf(_animalTokenId);  
    
    require(animalTokenOwner == msg.sender, "Caller is not animal token owner.");
    require(_price > 0, "Price is zero or lower.");
    require(animalTokenPrices[_animalTokenId] == 0, "This animal token already on sale.");
    require(mintAnimalTokenAddress.isApprovedForAll(animalTokenOwner, address(this)), "Animal token owenr did not approve token."); // 판매권한 체크 

    animalTokenPrices[_animalTokenId] = _price;
    onSaleAnimalTokenArray.push(_animalTokenId);
  }

  // 구매
  function purchaseAnimalToken(uint256 _animalTokenId) public payable {
    uint256 price = animalTokenPrices[_animalTokenId];
    address animalTokenOwner = mintAnimalTokenAddress.ownerOf(_animalTokenId);

    require(price > 0, "Animal token not sale.");
    require(price <= msg.value, "Caller sent lower than price.");
    require(animalTokenOwner != msg.sender, "Caller is animal token owner.");
    
    payable(animalTokenOwner).transfer(msg.value);
    mintAnimalTokenAddress.safeTransferFrom(animalTokenOwner, msg.sender, _animalTokenId);

    // mapping 에서 제거
    animalTokenPrices[_animalTokenId] = 0;

    for(uint256 i = 0; i < onSaleAnimalTokenArray.length; i++) {
      if(animalTokenPrices[onSaleAnimalTokenArray[i]] == 0) {
        onSaleAnimalTokenArray[i] = onSaleAnimalTokenArray[onSaleAnimalTokenArray.length - 1];
        onSaleAnimalTokenArray.pop();
      }
    }
  }

  function getOnSaleAnimalTokenArrayLength() view public returns (uint256) {
    return onSaleAnimalTokenArray.length;
  }

  function getAnimalTokenPrice(uint256 _animalTokenId) public view returns(uint256) {
    return animalTokenPrices[_animalTokenId];
  }
}

/*
1.Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2.Transferring tokens: Players should be able to transfer their tokens to others.
3.Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4.Checking token balance: Players should be able to check their token balance at any time.
5.Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    struct ThingInStore {
        uint ID;
        string nameofItem;
        uint256 price;
    }

    ThingInStore[] public itemsInStore;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        itemsInStore.push(ThingInStore(1, "Sword", 100));
        itemsInStore.push(ThingInStore(2, "Car", 200));
        itemsInStore.push(ThingInStore(3, "Bike", 150));
        itemsInStore.push(ThingInStore(4, "Gun", 300));
        itemsInStore.push(ThingInStore(5, "Shield", 400));
    }

    function mint(address mintAddress, uint256 _amount) public onlyOwner {
        _mint(mintAddress, _amount);
    }

    function decimals() public pure override returns (uint8) {
        return 18; // Assuming standard ERC20 token with 18 decimals
    }

    function transferTokens(address _receiver, uint256 _amount) external {
        require(_amount > 0, "Transfer amount must be greater than zero!!");
        require(balanceOf(msg.sender) >= _amount, "Balance is low!");
        _transfer(msg.sender, _receiver, _amount);
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function burnTokens(uint256 _amount) external {
        require(balanceOf(msg.sender) >= _amount, "Insufficient balance to burn");
        _burn(msg.sender, _amount);
    }

    function convertInttoString(uint256 _index) internal pure returns (string memory) {
        if (_index == 0) {
            return "0";
        }

        uint256 temp = _index;
        uint256 length;
        while (temp != 0) {
            length++;
            temp /= 10;
        }

        bytes memory str = new bytes(length);
        uint256 j = length;
        while (_index != 0) {
            j--;
            uint8 tempByte = (48 + uint8(_index - _index / 10 * 10));
            bytes1 char = bytes1(tempByte);
            str[j] = char;
            _index /= 10;
        }

        return string(str);
    }

    function shopToRedeem() external view returns (string memory) {
        string memory shopItems = "Available items in store:\n";
        for (uint256 index = 0; index < itemsInStore.length; index++) {
            shopItems = string(abi.encodePacked(
                shopItems,
                convertInttoString(index + 1),
                ". ",
                itemsInStore[index].nameofItem,
                " - ",
                convertInttoString(itemsInStore[index].price / (10 ** uint256(decimals()))),
                " DGN",
                "\n"
            ));
        }
        return shopItems;
    }

    mapping(address => ThingInStore[]) public userItems;

    function redeemItem(uint256 itemIndex) external {
        require(itemIndex < itemsInStore.length, "Invalid index for item");
        
        ThingInStore memory item = itemsInStore[itemIndex];
        require(balanceOf(msg.sender) >= item.price, "Insufficient balance to redeem item");

        _burn(msg.sender, item.price);

        userItems[msg.sender].push(item);
    }

    function getUserItems(address user) external view returns (ThingInStore[] memory) {
        return userItems[user];
    }
}

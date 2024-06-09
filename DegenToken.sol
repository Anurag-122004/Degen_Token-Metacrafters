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
import "hardhat/console.sol";

contract DegenToken is ERC20("Degen", "DGN"), Ownable(msg.sender), ERC20Burnable {

    function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
    }

    function decimals() override public pure returns (uint8) {
        return 0;
    }

    function transferringofTokens(address _Reciever, uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen tokens");
        approve(msg.sender, _value);
        transferFrom(msg.sender, _Reciever, _value);
    }

    function getokenBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    function burningofTokens(uint256 _Value) external {
        require(balanceOf(msg.sender) >= _Value, "You do not have enough Degen Tokens");
        _burn(msg.sender, _Value);
    }

    function convertInttoString(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    struct Things {
        string name;
        uint256 price;
    }

    Things[] public itemsinStore;

    constructor()  {
        itemsinStore.push(Things("Sword", 50));
        itemsinStore.push(Things("Car", 200));
        itemsinStore.push(Things("Bike", 150));
        itemsinStore.push(Things("Gun", 100));
        itemsinStore.push(Things("Shield", 250));
    }

    mapping(address => uint256) public tokenBalance;
    event ItemPurchased(address indexed buyer, string itemName, uint256 itemPrice);
    
    function shopToRedeemItems() external view returns (string memory) {
        string memory shopItems = "Available items in store:\n";
        for (uint256 i = 0; i < itemsinStore.length; i++) {
            shopItems = string(abi.encodePacked(
                shopItems,
                convertInttoString(i + 1),
                ". ",
                itemsinStore[i].name,
                " - ",
                convertInttoString(itemsinStore[i].price / (10 ** decimals())),
                " DGN",
                "\n"
            ));
        }
        return shopItems;
    }

    function redeemItems(uint256 itemIndex) public {
        require(itemIndex < itemsinStore.length, "Invalid item index");
        Things memory item = itemsinStore[itemIndex];
        require(tokenBalance[msg.sender] >= item.price, "Insufficient token balance");
        tokenBalance[msg.sender] -= item.price;
        emit ItemPurchased(msg.sender, item.name, item.price);
    }

    function addTokenstouserBalance(uint256 amount) public {
        tokenBalance[msg.sender] += amount;
    }
}

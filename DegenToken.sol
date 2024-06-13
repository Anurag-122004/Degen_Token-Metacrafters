/*
1.Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2.Transferring tokens: Players should be able to transfer their tokens to others.
3.Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4.Checking token balance: Players should be able to check their token balance at any time.
5.Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/

// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    struct thingsInStore {
        uint ID;
        string nameofItem;
        uint256 price;
    }

    thingsInStore[] public itemsinStore;

    constructor() ERC20("Degen","DGN") Ownable(msg.sender) {
        itemsinStore.push(thingsInStore(1, "Sword", 100));
        itemsinStore.push(thingsInStore(2, "car", 200));
        itemsinStore.push(thingsInStore(3, "Bike", 150));
        itemsinStore.push(thingsInStore(4, "Gun", 300));
        itemsinStore.push(thingsInStore(5, "Shield", 400));
    }

    function mint(address mintAddress, uint256 _Amount) public onlyOwner {
        _mint(mintAddress, _Amount);
    }

    function decimals() override public pure returns(uint8) {
        return 0;
    }

    function transferTokens(address _reciever, uint256 _Amount) external {
        require(_Amount > 0, "Transfer amount must be greater than zero!!");
        require(balanceOf(msg.sender) >= _Amount, "Balance is low!");
        _transfer(msg.sender, _reciever, _Amount);
    }

    function getBalance() external view returns (uint256){
        return this.balanceOf(msg.sender);
    }

    function burnTokens(uint256 _Amount) external {
        require(balanceOf(
            msg.sender) >= _Amount,
            "You do not have enough Degen tokens to burn"
            );
        _burn(msg.sender, _Amount);
    }

    function convertInttoString(uint256 _index) internal pure returns (string memory){
        if ( _index == 0 ) {
            return "0";
        }

        uint256 vari = _index;
        uint256 leng;
        while ( vari != 0 ) {
            leng++;
            vari /= 10;
        }

        bytes memory bym = new bytes(leng);
        uint256 x = leng;
        while ( _index != 0 ){
            x--;
            uint8 tempVar = (48 + uint8(_index - _index / 10 * 10));
            bytes1 byt1 = bytes1(tempVar);
            bym[x] = byt1;
            _index /= 10;
        }

        return string(bym);
    }

    function shopToRedeem() external view returns (string memory) {
        string memory shopitems = "Available itmes in store:\n";
        for (uint256 index = 0; index < itemsinStore.length; index++) {
            shopitems = string(abi.encodePacked(
            shopitems,
            convertInttoString(index + 1),
            ". ",
            itemsinStore[index].nameofItem,
            " - ",
            convertInttoString(itemsinStore[index].price / (10 ** decimals())),
            " DGN",
            "\n"
            ));
        }
        return shopitems;
    }

    function redeemItems(uint256 itemIndex) public {
        require(itemIndex < itemsinStore.length, 
                "Invalid Index for an item");
        thingsInStore memory item = itemsinStore[itemIndex];
        require(balanceOf(msg.sender) >= item.price,
                "Tokens are less in account!");
        _burn(msg.sender, item.price);
    }
}

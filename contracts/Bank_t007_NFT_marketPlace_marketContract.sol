// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;
import "./Bank_t007_NFT_marketPlace_ownable.sol";

interface IBank{
    function transferFrom(address _from, address _to, uint _amount) external;
    function getBalance() external view returns(uint);
    function withdraw(uint _amount) external;
}

contract NFTMarket is Ownable {
    struct Kitty{
        uint256 id;
        string name;
        address owner;
    }

    Kitty[] kitties;
    mapping(address => uint256[])ownedKitties;
    uint private price = 1000000000000000000; //1ETH
    address private bankAddr = 0x0000000000000000000000000000000000000000;  //bankContractのアドレス
    IBank bank = IBank(bankAddr);

    function createKitty(string memory _name) external onlyOwner {
        Kitty memory newKitty = Kitty(kitties.length, _name, address(0));
        kitties.push(newKitty);
    }

    function getOwner() external view returns(address){
        return owner;
    }

    function viewKitty() external view returns(Kitty[] memory){
        return kitties;
    }

    function buyKitty(uint _id) external {
        require(kitties[_id].owner == address(0), "Kitty not for sale");
        ownedKitties[msg.sender].push(_id);
        kitties[_id].owner = msg.sender;
        bank.transferFrom(msg.sender, address(this), price);
    }

    function withdrawFromBank() external onlyOwner{
        uint balance = bank.getBalance();
        bank.withdraw(balance);
    }

    function transferToOwner() external onlyOwner{
        payable(msg.sender).transfer(address(this).balance);
    }

    function getBalance() external view onlyOwner returns(uint){
        return address(this).balance;
    }

    receive() external payable{

    }
}
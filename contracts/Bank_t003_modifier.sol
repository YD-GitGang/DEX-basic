// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

contract Bank {
    mapping(address => uint)balance;
    address owner;

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier balanceCheck(uint _amount){
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function getbalance() public view returns(uint){
        return balance[msg.sender];
    }

    function deposit() public payable onlyOwner{
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public balanceCheck(_amount){
        uint beforeWtithdraw = balance[msg.sender];
        balance[msg.sender] -= _amount;
        //balance[msg.sender] -= 2*_amount; エラー例
        payable(msg.sender).transfer(_amount);
        uint afterWithdraw = balance[msg.sender];
        assert(afterWithdraw == beforeWtithdraw - _amount);
    }

    function transfer(address _to, uint _amount) public onlyOwner balanceCheck(_amount){
        require(msg.sender != _to, "Invalid recipient");
        balance[msg.sender] -= _amount;
        balance[_to] += _amount;
    }
}
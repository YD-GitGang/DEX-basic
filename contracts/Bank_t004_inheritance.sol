// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "./Bank_t004_inheritance_ownable.sol";

contract Bank is Ownable{
    mapping(address => uint)balance;
    
    function getbalance() public view returns(uint){
        return balance[msg.sender];
    }

    function deposit() public payable onlyOwner{
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        balance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    function transfer(address _to, uint _amount) public {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        require(msg.sender != _to, "Invalid recipient");
        _transfer(msg.sender, _to, _amount);
    }

    function _transfer(address _from, address _to, uint _amount) private {
        balance[_from] -= _amount;
        balance[_to] += _amount;
    }
}
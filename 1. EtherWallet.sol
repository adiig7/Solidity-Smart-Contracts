// Deployed on Kovan Test Network : 0x78a69BFE315e39a0d28E3F237c32A449402F8d48


//SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

contract EtherWallet{

    // address which deployed the contract
    address payable public owner;

    constructor(){
        owner = payable(msg.sender);
    }

    // events for withdraw and deposit into the wallet
    event Withdraw(address indexed account, uint amount);
    event Deposit(address indexed account, uint amount);


    // checks if the owner is calling some xyz function or not
    modifier onlyOwner{
        require(owner == msg.sender, "You are not the owner");
        _;
    }

    // transfers the ether from this contract to owner
    function withdraw(uint amount) external onlyOwner{
        payable(msg.sender).transfer(amount);

        emit Withdraw(msg.sender, amount);
    }

    // returns the amount of ether in the contract
    function getBalance() external view returns(uint){
        return address(this).balance;
    }

    receive() external payable{
        emit Deposit(msg.sender, msg.value);
    }
}

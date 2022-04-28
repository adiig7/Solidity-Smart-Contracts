pragma solidity 0.8.0;
//SPDX-License-Identifier:MIT

contract Owner{
    address public owner;
    constructor(){
        owner = msg.sender;
    }
    
    //function to get the address of the owner
    function getOwner() view public returns(address){
        return owner;
    }
    
    //function to get the balance of the owner
    function getBalance() view public returns(uint){
        return owner.balance;
    }
}

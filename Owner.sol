// Deployed to Kovan Network: 0x264d4eE281552A0249B0caf84d5523C3DE787105

/* 
This smart contract does the following:
- the owner is set to the account that is deploying the contract
- renounce the ownership, i.e., make this smart contract that is not owned by anyone(only the owner has the right to renounce)
- transfer the ownership to any othe account
*/

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Owner{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(owner == msg.sender, "Only owner has access the key for the lock you are tryint to open");
        _;
    }

    function checkOwner() external view returns(address){
        return owner;
    }

    function renounceOwnership() public virtual onlyOwner{
        owner = address(0);
    }

    function changeOwnership(address newOnwer) public onlyOwner{
        require(newOnwer != address(0), "The address you entered is not valid!");
        owner = newOnwer;
    }
}

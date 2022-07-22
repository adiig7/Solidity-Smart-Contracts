//Deployed to Kovan network - 0x14b8E77fBf5b5518A134e9c17D193fde8058cB2d

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/* PiggyBank contract can let user to:
    - deposit money in the piggybank(smart contract)
    - withdraw the amount from piggybank(smart contract)
    - destroy the piggybank(smart contract)
*/

contract PiggyBank{
    event Withdraw(uint amount);
    event Deposit(uint amount);

    address payable public owner;

    modifier onlyOwner{
        require(owner == msg.sender, "Only owner can access this!");
        _;
    }

    function withdraw(uint amount) external onlyOwner{
        payable(msg.sender).transfer(amount);
        emit Withdraw(address(this).balance);
        selfdestruct(payable(owner)); // destroys the smart contract including it's ABIs and sends the remaining balance of ether from the contract to the address mentioned
    }

    receive() external payable{
        emit Deposit(msg.value);
    }
}

/* 
  This smart contract lets a user to gift 0.001eth the deployer as a vote of thanks for any good work the deployer has done.
  A user can gift 0.001 eth as well as can gift 0.003eth to the owner(deployer).
  Smart contract deployed on RINKEBY: 0xc7f2F0A9b17ED4F784Fb012d5885aC2976f767D9
*/


//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

contract  CoffeeByWallet {
    address payable owner;
    struct Gift{
        uint256 timestamp;
        string message;
        string name;
        address from;
    }

    event buyCoffee(address indexed from, string  name, string message, uint256 timestamp);
    
    Gift[] public gifts;

    constructor() {
        owner = payable(msg.sender);
    }

    function BuyCoffee(string memory name, string memory message) public payable{
        require(msg.value > 0, "You can't donate 0!");
        gifts.push(Gift(block.timestamp, message, name, msg.sender));
        emit buyCoffee(msg.sender, name, message, block.timestamp);
    }

    function getGifts() external view returns(Gift[] memory){
        return gifts;
    }

    function withdraw() public{
        require(owner.send(address(this).balance));
    }

    function updateWithdrawAddress(address newOwner) public{
        require(owner == msg.sender, "Only owner can change the withdraw address");
        owner = payable(newOwner);
    }

    function buyLargeCoffee(string memory name, string memory message) public payable{
        require(msg.value >= 3000000000000000, "Amount is too low for large coffee!");
        gifts.push(Gift(block.timestamp, name, message, msg.sender));
        emit buyCoffee(msg.sender, name, message, block.timestamp);
    }
}

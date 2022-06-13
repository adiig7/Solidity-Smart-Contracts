// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Counter{
    uint public count =256;

    function getCount() public view returns(uint){
        return count;
    }

    function increase() public {
        count++;
    }
    function decrease() public{
        count--;
    }
}

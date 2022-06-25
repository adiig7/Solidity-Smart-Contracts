/* This smart contract can be used to conduct an auction
Deployed to RINKEBY TESTNET - 0xd9145CCE52D386f254917e481eB44e9943F39138
*/


// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Auction{
    
    address payable public auctioneer;

    uint public startBlock;
    uint public endBlock;

    enum AucState {Started, Running, Ended, Cancelled}
    AucState public auctionState;

    uint public highestBid;
    uint public highestPayableBid;
    uint public bidIncrement;
    address payable public highestBidder;

    mapping(address => uint) public bids;

    constructor(){
        auctioneer = payable(msg.sender);
        auctionState = AucState.Running;
        startBlock = block.number;
        endBlock = startBlock + 240;
        bidIncrement = 1 ether;
    }

    modifier notOwner(){
        require(msg.sender != auctioneer, "Owner can't bid");
        _;
    }

    modifier Owner(){
        require(msg.sender == auctioneer, "Owner");
        _;
    }

    modifier started(){
        require(block.number > startBlock);
        _;
    }

    modifier beforeEnded(){
        require(block.number < endBlock);
        _;
    }

     function cancelAuction() public Owner{
        auctionState = AucState.Cancelled;
    }

    function endAuction() public Owner{
        auctionState = AucState.Ended;
    }

    function min(uint a, uint b) pure private returns(uint){
        if(a < b){
            return a;
        }else{
            return b;
        }
    }

    function bid() payable public notOwner started beforeEnded{
        require(auctionState == AucState.Running);
        require(msg.value > 1 ether);

        uint currentBid = bids[msg.sender] + msg.value;

        require(currentBid  > highestPayableBid);

        bids[msg.sender] = currentBid;

        if(currentBid < bids[highestBidder]){
            highestPayableBid = min(currentBid+ bidIncrement, bids[highestBidder]);
        }else{
            highestPayableBid = min(currentBid, bids[highestBidder] + bidIncrement);
            highestBidder = payable(msg.sender);
        }
    }

    function finalAuction() public{
        require(auctionState == AucState.Cancelled || auctionState == AucState.Ended || block.number > endBlock);
        require(msg.sender == auctioneer || bids[msg.sender] > 0);

        address payable person;
        uint value;
        
        if(auctionState == AucState.Cancelled){
            person = payable(msg.sender);
            value = bids[msg.sender];
        }else{
            if(msg.sender == auctioneer){
                person = auctioneer;
                value = highestPayableBid;
            }else{
                if(msg.sender == highestBidder){
                    person = highestBidder;
                    value = bids[highestBidder] - highestPayableBid;
                }else{
                    person = payable(msg.sender);
                    value = bids[msg.sender];
                }
            }
        }
        bids[msg.sender] = 0;
        person.transfer(value);
    }
}

// Deployed to RINKEBY TESTNET: 0xd2a5bC10698FD955D1Fe6cb468a17809A08fd005

// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract TwitterContract {

    event AddTweet(address recipient, uint tweetId);
    event DeleteTweet(uint tweetId, bool isDeleted);

    struct Tweet{
        uint id;
        address username;
        string tweetText;
        bool isDeleted;
    }

    Tweet[] private tweets;

    mapping(uint256 => address) tweetToOwner;

    function addTweet(string memory tweetText, bool isDeleted) external {
        uint tweetId = tweets.length;
        tweets.push(Tweet(tweetId, msg.sender, tweetText, isDeleted));
        tweetToOwner[tweetId] = msg.sender;
        emit AddTweet(msg.sender, tweetId);
    }

    // get all the tweets 
    function getAllTweets() external view returns (Tweet[] memory){
        Tweet[] memory temporaryTweets = new Tweet[](tweets.length);
        uint count = 0;
        for(uint i = 0; i < tweets.length; i++){
            if(tweets[i].isDeleted == false){
                temporaryTweets[count] = tweets[i];
                count++;
            }
        }

        Tweet[] memory result = new Tweet[](count);

        for(uint i = 0; i < count; i++){
            result[i] = temporaryTweets[i];
        }
        return result;
    }

    // get my tweets
    function getMyTweets() external view returns (Tweet[] memory){
        Tweet[] memory temporaryTweets = new Tweet[](tweets.length);
        uint count = 0;
        for(uint i = 0; i < tweets.length; i++){
            if(tweetToOwner[i] == msg.sender && tweets[i].isDeleted == false){
                temporaryTweets[count] = tweets[i];
                count++;
            }
        }

        Tweet[] memory result = new Tweet[](count);
        for(uint i = 0; i < count; i++){
            result[i] = temporaryTweets[i];
        }
        return result;
    }

    // delete tweet
    function deleteTweet(uint tweetId, bool isDeleted) external {
       if(tweetToOwner[tweetId] == msg.sender){
           tweets[tweetId].isDeleted = isDeleted;
           emit DeleteTweet(tweetId, isDeleted);
       }
    }

}

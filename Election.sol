// Deployed to RINKEBY TESTNET: 0xDA0bab807633f07f013f94DD0E6A4F96F8742B53


//SPDX-License-Identifier:MIT
pragma solidity 0.8.13;

contract ELection{

    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    uint public candidateCount;

    mapping(uint => Candidate) public candidates;

    mapping(address => bool) public hasVoted;

    event electionUpdated(
          uint id,
          string name,
          uint voteCount
    );

    constructor(){
        addCandidate("Donald Trump");
        addCandidate("Barack Obama");
    }

    function addCandidate(string memory name) public {
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, name, 0);
    }

    function Vote(uint _id) public{
        require(!hasVoted[msg.sender], 'you have voted for the participant');
        require(candidates[_id].id != 0, 'the id doesnt exist');
        candidates[_id].voteCount +=1;
        hasVoted[msg.sender] = true;
        emit electionUpdated(_id, candidates[_id].name, candidates[_id].voteCount);
    }
    
}

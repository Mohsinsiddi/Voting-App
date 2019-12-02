pragma solidity ^0.5.0;
 contract Election{
     //Model a candidate
     struct Candidate {
         uint id;
         string name;
         uint voteCount;
     }
     //store accounts that have voted
     mapping(address => bool) public voters;
     //Store Candidates
     //Fetch Candidate
     mapping(uint => Candidate) public candidates;
     //Store Candidate Count
     uint public candidatesCount;
     event votedEvent(
         uint indexed candidateID
     );
         constructor() public{
         addCandidate("Nicola Tesla");
         addCandidate("Albert Einstein");
         addCandidate("Stephen Hawkins");

     }
     function addCandidate(string memory CandidateName) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, CandidateName, 0);
     }
     function vote(uint candidateID) public {
         //check that they havent voted before
         require(!voters[msg.sender],"voted before");
         //check that they are valid candiate
         require(candidateID > 0 && candidateID <= candidatesCount,"not valid candidate");
         //record that voter has voted
         voters[msg.sender] = true;
         //update the vote count
         candidates[candidateID].voteCount++;
         //trigger voted event
         emit votedEvent(candidateID);
     }
 }
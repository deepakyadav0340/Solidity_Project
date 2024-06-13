pragma solidity ^0.8.0;

contract VotingSystem {
    // Structure to represent a candidate
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    // Structure to represent a voter
    struct Voter {
        bool hasVoted;
        uint256 candidateId;
    }

    // Array of candidates
    Candidate[] public candidates;

    // Mapping of voter addresses to Voter struct
    mapping(address => Voter) public voters;

    // Modifier to check if the sender has not voted
    modifier hasNotVoted() {
        require(!voters[msg.sender].hasVoted, "You have already voted.");
        _;
    }

    // Modifier to check if the candidate ID is valid
    modifier validCandidate(uint256 _candidateId) {
        require(_candidateId < candidates.length, "Invalid candidate ID.");
        _;
    }

    // Function to add a candidate
    function addCandidate(string memory _name) public {
        candidates.push(Candidate(_name, 0));
    }

    // Function to get the total number of candidates
    function getCandidateCount() public view returns (uint256) {
        return candidates.length;
    }

    // Function to cast a vote for a candidate
    function vote(uint256 _candidateId) public hasNotVoted validCandidate(_candidateId) {
        voters[msg.sender].hasVoted = true;
        voters[msg.sender].candidateId = _candidateId;
        candidates[_candidateId].voteCount++;
    }

    // Function to get the vote count for a candidate
    function getVoteCount(uint256 _candidateId) public view validCandidate(_candidateId) returns (uint256) {
        return candidates[_candidateId].voteCount;
    }
}

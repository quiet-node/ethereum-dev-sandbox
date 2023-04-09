pragma solidity ^0.8.0;

contract CommitRevealAuction {
    address public highestBidder;
    uint256 public highestBid;
    uint256 public auctionEndTime;
    uint256 public revealEndTime;

    mapping(address => bytes32) public commitments;

    constructor(uint256 _auctionDuration, uint256 _revealDuration) {
        auctionEndTime = block.timestamp + _auctionDuration;
        revealEndTime = auctionEndTime + _revealDuration;
    }

    // @dev allows user to commit the desired action
    // @notice the user compute commitment off-chain
    // @notice commitment is a 256-bit hash value computed from {uint bidValue, string secret}
    function commitBid(bytes32 commitment) external {
        require(block.timestamp < auctionEndTime, "Auction has ended");
        commitments[msg.sender] = commitment;
    }

    // @dev revealing sessions
    function revealBid(uint256 value, bytes32 secret) external {
        require(block.timestamp >= auctionEndTime && block.timestamp < revealEndTime, "Reveal phase is not active");
        require(keccak256(abi.encodePacked(value, secret)) == commitments[msg.sender], "Invalid bid reveal");

        if (value > highestBid) {
            if (highestBidder != address(0)) {
                // Refund the previous highest bidder
                payable(highestBidder).transfer(highestBid);
            }

            highestBidder = msg.sender;
            highestBid = value;
        }
    }

    function endAuction() external {
        require(block.timestamp >= revealEndTime, "Auction has not ended yet");
        selfdestruct(payable(highestBidder));
    }
}

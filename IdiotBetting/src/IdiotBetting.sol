// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

   uint256 endTime;
   address highestBidder;
   uint256 highestBid;
    function bet() public payable {
        require(msg.value != 0, "You must bid some amount of Ether");
        if (msg.value > highestBid) {
            highestBidder = msg.sender;
            highestBid = msg.value;
            endTime = block.timestamp + 1 hours;
        }

    }

    function claimPrize() public {
        require(block.timestamp >= endTime, "You cannot claim until auction has ended");
        if (msg.sender == highestBidder) {
            (bool succeed, ) = msg.sender.call{value: address(this).balance}("");
            require(succeed, "Prize Claim Failed");
        } else {
            revert();
        }
    }
}

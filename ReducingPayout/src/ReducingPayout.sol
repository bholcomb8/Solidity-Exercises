// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ReducingPayout {
    /*
        This exercise assumes you know how block.timestamp works.
        1. This contract has 1 ether in it, each second that goes by, 
           the amount that can be withdrawn by the caller goes from 100% to 0% as 24 hours passes.
        2. Implement your logic in `withdraw` function.
        Hint: 1 second deducts 0.0011574% from the current %.
    */

    // The time 1 ether was sent to this contract
    uint256 public immutable depositedTime;

    constructor() payable {
        depositedTime = block.timestamp;
    }

    function withdraw() public {
        //require(block.timestamp <= depositedTime + 86400, "You ran out of time to withdraw");
        uint256 amount;
        uint256 currentSecond = block.timestamp - depositedTime;

        if (block.timestamp < depositedTime + 86400) {
            amount = 1 ether - ((currentSecond * .0011574 ether) / 100);
        } else {
            amount = 0;
        }
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");

    }
}

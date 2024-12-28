// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract DeadmanSwitch {
    address payable public backup;
    address public owner;
    uint public Block;

    constructor(address payable _backup) {
        require(_backup != address(0), "Invalid beneficiary address");
        backup = _backup;
        owner = msg.sender;
        Block = block.number; // Initialize with the block number at deployment
    }

    receive() external payable {}

    function showBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function still_alive() public {
        require(msg.sender == owner, " You are not owner");
        Block = block.number;
    }

    function withdraw() public {
        require(block.number >= Block+10 , "Owner is still active");
        backup.transfer(showBalance());
    }

    function currentBlock() public view returns (uint256) {
        return block.number;
    }
}

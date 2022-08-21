// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract C_03_FixedEtherVault is ReentrancyGuard{
    mapping(address => uint256) private balanceOf;

    function deposit() external payable{
        balanceOf[msg.sender] += msg.value;
    }

    function withdrawAll() external nonReentrant{ // FIX: Apply nonReentrant calls from Openzeppelin 
        uint256 userBalance = getAllBalance(msg.sender);
        require(userBalance > 0, "Insufficient Balance!");
        
        // FIX: Apply check-effects-interactions pattern
        balanceOf[msg.sender] = 0; // Update state before call interaction

        (bool success, ) = msg.sender.call{value: userBalance}("");
        require(success, "Failed to send ether");


    }

    function getTotalDepositBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getAllBalance(address _user) public view returns (uint256) {
        return balanceOf[_user];
    }

}
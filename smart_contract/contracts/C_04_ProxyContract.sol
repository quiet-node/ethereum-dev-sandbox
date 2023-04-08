// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/** 
* This contract mimics the basic logic of proxy contracts utilizing `delegatecall` function. 
*
* Imagine contract `MainContract` is deployed permanently and holds all the important information of the whole system. Therefore, it would be very expensive 
* to redeploy the `MainContract` in case of upgrading new features within the contracts. Therefore, the idea of `ProxyContract` comes in to the place. `MainContract`
* utilizes the benefits of the `delegatecall` function to call the functions on the `ProxyContract` to update the states on `MainContract`
*
* `ProxyContract` can be redeployed anytime a new features completely implemented. `MainContract` will make the use of the new features in `ProxyContract` to 
* update the states inside `MainContract`
*/


contract ProxyContract {
    uint public num;
    address public sender;
    uint public value;

    function updateStates(uint _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract MainContract {
    uint public num;
    address public sender;
    uint public value;

    function updateStatesDelegateProxycontract(address _proxyContract, uint _num) external {
        // (bool success, ) =  _proxyContract.delegatecall(abi.encodeWithSignature("updateStates(uint256)", _num));
        (bool success, ) = _proxyContract.delegatecall(abi.encodeWithSelector(ProxyContract.updateStates.selector, _num));
        require(success);
    }
}

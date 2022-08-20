// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract00Messages {
    string public message;

    event messageChanged (string _message);

    constructor(string memory _message) {
        message = _message;
        emit messageChanged(message);
    }

    function updateMessage(string memory _message) public  {
        message = _message;
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

}
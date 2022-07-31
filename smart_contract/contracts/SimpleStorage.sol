//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SimpleStorage {
    uint256 private favoriteNumber;
    struct People {
        string name;
        uint256 favoriteNumber;
    }
    mapping(string => uint256) private nameToFavoriteNumber;
    People[] private people;

    function storeFavoriteNumber(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieveFavoriteNumber() public view returns (uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_name, _favoriteNumber));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

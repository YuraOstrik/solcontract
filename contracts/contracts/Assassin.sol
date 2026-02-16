// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./WarriorGuild.sol";

contract Assassin is WarriorGuild {

    function attack() public view override returns (uint256) {
        require(isRegistered(msg.sender), "Not a warrior");

        uint256 baseDamage =
            warriors[msg.sender].power +
            warriors[msg.sender].level * 4;

        if (block.number % 2 == 0) {
            return baseDamage * 3;
        }

        return baseDamage;
    }
}

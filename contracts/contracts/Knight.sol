// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./WarriorGuild.sol";

contract Knight is WarriorGuild {

    function attack() public view override returns (uint256) {
        require(isRegistered(msg.sender), "Not a warrior");

        uint256 damage =
            warriors[msg.sender].power +
            warriors[msg.sender].level * 5;

        return damage;
    }
}

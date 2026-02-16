// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./WarriorGuild.sol";

contract Mage is WarriorGuild {

    function attack() public view override returns (uint256) {
        require(isRegistered(msg.sender), "Not warrior");

        uint256 damage = warriors[msg.sender].power * 4
            + warriors[msg.sender].level * 10;

        return damage;
    }
}

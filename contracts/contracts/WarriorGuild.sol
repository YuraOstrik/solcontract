// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WarriorGuild {

    struct Warrior {
        bool registered;
        uint256 level;
        uint256 power;
    }

    mapping(address => Warrior) public warriors;

    function registerWarrior() external {
        require(!warriors[msg.sender].registered, "Already registered");

        warriors[msg.sender] = Warrior({
            registered: true,
            level: 1,
            power: 10
        });
    }

    function isRegistered(address user) public view returns (bool) {
        return warriors[user].registered;
    }

    function attack() public virtual returns (uint256) {
        revert("Attack not implemented");
    }
}

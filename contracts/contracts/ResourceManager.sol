// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ResourceUtils.sol";

contract ResourceManager {

    using ResourceUtils for uint256;

    struct PlayerResources {
        uint256 energy;
        uint256 gold;
        uint256 level;
    }

    mapping(address => PlayerResources) public players;

    function addResources(
        uint256 energy,
        uint256 gold
    ) external {
        players[msg.sender].energy += energy;
        players[msg.sender].gold += gold;
    }

    function distributePlayerEnergy(uint256 percent) external {
        uint256 distributed = players[msg.sender].energy.distributeEnergy(percent);
        players[msg.sender].energy -= distributed;
    }

    function upgrade(uint256 baseCost) external {
        PlayerResources storage p = players[msg.sender];

        uint256 cost = ResourceUtils.upgradeCost(baseCost, p.level);
        uint256 spend = ResourceUtils.optimizeGoldSpend(p.gold, cost);

        p.gold -= spend;
        p.level += 1;
    }

    function getPlayerResources(address player)
        external
        view
        returns (uint256 energy, uint256 gold, uint256 level)
    {
        PlayerResources memory p = players[player];
        return (p.energy, p.gold, p.level);
    }
}

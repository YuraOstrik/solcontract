// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ResourceUtils {

    function distributeEnergy(
        uint256 totalEnergy,
        uint256 percent
    ) internal pure returns (uint256) {
        return (totalEnergy * percent) / 100;
    }

    function upgradeCost(
        uint256 baseCost,
        uint256 level
    ) internal pure returns (uint256) {
        return baseCost * (level + 1);
    }

    function optimizeGoldSpend(
        uint256 gold,
        uint256 maxSpend
    ) internal pure returns (uint256) {
        if (gold > maxSpend) {
            return maxSpend;
        }
        return gold;
    }
}

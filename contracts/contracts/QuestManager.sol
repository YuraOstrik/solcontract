// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IQuest.sol";

contract QuestManager is IQuest {

    struct Quest {
        uint256 reward;
        uint256 requiredLevel;
        bool exists;
    }

    struct Player {
        uint256 level;
        uint256 experience;
    }

    mapping(uint256 => Quest) public quests;
    mapping(address => Player) public players;
    mapping(address => mapping(uint256 => bool)) public activeQuests;
    mapping(address => mapping(uint256 => bool)) public completedQuests;

    uint256 public constant EXP_PER_LEVEL = 100;

    function addQuest(
        uint256 questId,
        uint256 reward,
        uint256 requiredLevel
    ) external {
        quests[questId] = Quest(reward, requiredLevel, true);
    }

    function startQuest(uint256 questId) external override {
        Quest memory quest = quests[questId];

        require(quest.exists, "Quest not found");
        require(players[msg.sender].level >= quest.requiredLevel, "Level too low");
        require(!activeQuests[msg.sender][questId], "Quest already started");
        require(!completedQuests[msg.sender][questId], "Quest already completed");

        activeQuests[msg.sender][questId] = true;
    }

    function completeQuest(uint256 questId) external override {
        require(activeQuests[msg.sender][questId], "Quest not active");

        activeQuests[msg.sender][questId] = false;
        completedQuests[msg.sender][questId] = true;

        uint256 reward = quests[questId].reward;
        _addExperience(msg.sender, reward);
    }

    function getReward(uint256 questId) external view override returns (uint256) {
        return quests[questId].reward;
    }

    function _addExperience(address player, uint256 exp) internal {
        Player storage p = players[player];
        p.experience += exp;

        while (p.experience >= EXP_PER_LEVEL) {
            p.experience -= EXP_PER_LEVEL;
            p.level += 1;
        }
    }

    function getPlayer(address player) external view returns (uint256 level, uint256 experience) {
        Player memory p = players[player];
        return (p.level, p.experience);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title InteractionLogger
/// @notice Logs interactions (caller + timestamp) with no function inputs, no imports, and no constructor.
contract InteractionLogger {
    struct Interaction {
        address who;
        uint256 timestamp;
    }

    // storage of interactions by sequential id
    mapping(uint256 => Interaction) private interactions;
    uint256 private totalInteractions;

    // Event emitted each time an interaction is logged
    event InteractionLogged(address indexed user, uint256 timestamp, uint256 id);

    /// @notice Log an interaction. No inputs — uses msg.sender and block.timestamp.
    function logInteraction() external {
        uint256 id = totalInteractions;
        interactions[id] = Interaction({ who: msg.sender, timestamp: block.timestamp });
        emit InteractionLogged(msg.sender, block.timestamp, id);
        // increment after storing to keep ids sequential starting at 0
        totalInteractions = id + 1;
    }

    /// @notice Returns total number of interactions recorded. No inputs.
    function getTotalInteractions() external view returns (uint256) {
        return totalInteractions;
    }

    /// @notice Returns the latest interaction (user, timestamp, id). No inputs.
    /// @dev Reverts if no interactions exist.
    function getLatestInteraction() external view returns (address user, uint256 timestamp, uint256 id) {
        require(totalInteractions > 0, "No interactions recorded");
        uint256 idx = totalInteractions - 1;
        Interaction storage it = interactions[idx];
        return (it.who, it.timestamp, idx);
    }

    /// @notice Returns all recorded interactions as two arrays (users[], timestamps[]). No inputs.
    /// @dev For large numbers of interactions this could be expensive in gas when called on-chain;
    ///      it's intended for off-chain reads (call/staticcall).
    function getAllInteractions() external view returns (address[] memory users, uint256[] memory timestamps) {
        uint256 n = totalInteractions;
        users = new address[](n);
        timestamps = new uint256[](n);
        for (uint256 i = 0; i < n; ++i) {
            Interaction storage it = interactions[i];
            users[i] = it.who;
            timestamps[i] = it.timestamp;
        }
        return (users, timestamps);
    }
}

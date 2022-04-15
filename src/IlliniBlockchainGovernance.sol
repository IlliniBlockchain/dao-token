// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {GovernorVotes} from "./extensions/GovernorVotes.sol";
import {GovernorVotesQuorumFraction} from "./extensions/GovernorVotesQuorumFraction.sol";
import {IVotes} from "./utils/IVotes.sol";

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import {FxBaseChildTunnel} from "contract/contracts/tunnel/FxBaseChildTunnel.sol";

contract IlliniBlockchainGovernor is
    Governor,
    GovernorSettings,
    GovernorCountingSimple,
    GovernorVotes,
    GovernorVotesQuorumFraction,
    FxBaseChildTunnel
{
    constructor(
        IVotes _token,
        uint256 _tokenID,
        address _fxChild
    )
        Governor("IlliniBlockchainGovernor")
        GovernorSettings(
            0, /* 0 block */
            45818, /* 1 week */
            0
        )
        GovernorVotes(_token, _tokenID)
        GovernorVotesQuorumFraction(67)
        FxBaseChildTunnel(_fxChild)
    {}

    /* NOTE:
    - include variable vote time in proposal
    - implement voting with our token
    */

    // The following functions are overrides required by Solidity.

    function votingDelay()
        public
        view
        override(IGovernor, GovernorSettings)
        returns (uint256)
    {
        return super.votingDelay();
    }

    function votingPeriod()
        public
        view
        override(IGovernor, GovernorSettings)
        returns (uint256)
    {
        return super.votingPeriod();
    }

    function quorum(uint256 blockNumber)
        public
        view
        override(IGovernor, GovernorVotesQuorumFraction)
        returns (uint256)
    {
        return super.quorum(blockNumber);
    }

    function getVotes(address account, uint256 blockNumber)
        public
        view
        override
        returns (uint256)
    {
        return super.getVotes(account, blockNumber);
    }

    function proposalThreshold()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    {
        return super.proposalThreshold();
    }

    uint256 public latestStateId;
    address public latestRootMessageSender;
    bytes public latestData;

    function _processMessageFromRoot(
        uint256 stateId,
        address sender,
        bytes memory data
    ) internal override validateSender(sender) {
        latestStateId = stateId;
        latestRootMessageSender = sender;
        latestData = data;
    }

    function sendMessageToRoot(bytes memory message) public onlyGovernance {
        _sendMessageToRoot(message);
    }
}

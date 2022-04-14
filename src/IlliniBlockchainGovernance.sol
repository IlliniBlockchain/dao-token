// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {GovernorVotes} from "./extensions/GovernorVotes.sol";
import {GovernorVotesQuorumFraction} from "./extensions/GovernorVotesQuorumFraction.sol";
import {IVotes} from "./utils/IVotes.sol";

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";

contract IlliniBlockchainGovernor is
    Governor,
    GovernorSettings,
    GovernorCountingSimple,
    GovernorVotes,
    GovernorVotesQuorumFraction
{
    constructor(IVotes _token, uint256 _tokenID)
        Governor("IlliniBlockchainGovernor")
        GovernorSettings(
            0, /* 0 block */
            45818, /* 1 week */
            0
        )
        GovernorVotes(_token, _tokenID)
        GovernorVotesQuorumFraction(67)
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
}

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./IlliniBlockchainGovernor.sol";

contract IlliniBlockchainGovernorTest is DSTest {
    IlliniBlockchainGovernor gov;

    function setUp() public {
        // TODO: need IVotes token for governance constructor
        // gov = new IlliniBlockchainGovernor();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}

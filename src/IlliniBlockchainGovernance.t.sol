// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./IlliniBlockchainGovernance.sol";

contract IlliniBlockchainGovernanceTest is DSTest {
    IlliniBlockchainGovernance gov;

    function setUp() public {
        gov = new IlliniBlockchainGovernance();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}

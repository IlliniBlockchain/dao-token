// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./IlliniBlockchainSP22Token.sol";

contract IlliniBlockchainSP22TokenTest is DSTest {
    IlliniBlockchainSP22Token token;

    function setUp() public {
        token = new IlliniBlockchainSP22Token(address(0x123));
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}

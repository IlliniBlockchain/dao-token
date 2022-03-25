// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import "./test/Vm.sol";

import "./IlliniBlockchainSP22Token.sol";

contract IlliniBlockchainSP22TokenTest is DSTest {
    Vm vm = Vm(HEVM_ADDRESS);
    IlliniBlockchainSP22Token token;

    function setUp() public {
        token = new IlliniBlockchainSP22Token();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }

    function test_mint() public {}

    function testFail_mint() public {}

    function test_batch_mint() public {}

    function testFail_batch_mint() public {}
}

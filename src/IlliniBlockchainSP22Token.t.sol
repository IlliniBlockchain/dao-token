// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./IlliniBlockchainSP22Token.sol";
import "./Vm.sol";

contract IlliniBlockchainSP22TokenTest is DSTest {
    IlliniBlockchainSP22Token token;
    Vm vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    function setUp() public {
        token = new IlliniBlockchainSP22Token();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }

    function test_no_transfer() public {

        // example addresses
        address addr1 = address(0x1234);
        address addr2 = address(0x5678);

        // mint some new tokens to one address
        // NOTICE: _mint is an internal function, come back
        // to this later when minting is available
        address to = addr1;
        uint256[] memory ids = new uint256[](2);
        ids[0] = 8;
        ids[1] = 5;
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 3;
        amounts[1] = 4;
        bytes memory data = "";
        // token._mint(to, id, amount, data);

        // get balances
        uint256 bal1Before = token.balanceOf(addr1, ids[0]);
        uint256 bal2Before = token.balanceOf(addr2, ids[0]);
        uint256 tk2bal1Before = token.balanceOf(addr1, ids[1]);
        uint256 tk2bal2Before = token.balanceOf(addr2, ids[1]);

        // try to transfer to another address
        vm.prank(addr1);
        vm.expectRevert("");
        token.safeTransferFrom(addr1, addr2, ids[0], amounts[0], data);
        vm.expectRevert("");
        token.safeBatchTransferFrom(addr1, addr2, ids, amounts, data);

        // check token 1 balances
        uint256 bal1After = token.balanceOf(addr1, ids[0]);
        uint256 bal2After = token.balanceOf(addr2, ids[0]);
        assertEq(bal1Before, bal1After, "addr1 token 1 balance changed");
        assertEq(bal2Before, bal2After, "addr2 token 1 balance changed");

        // check token 2 balances
        uint256 tk2bal1After = token.balanceOf(addr1, ids[1]);
        uint256 tk2bal2After = token.balanceOf(addr2, ids[1]);
        assertEq(tk2bal1Before, tk2bal1After, "addr1 token 2 balance changed");
        assertEq(tk2bal2Before, tk2bal2After, "addr2 token 2 balance changed");

    }
}

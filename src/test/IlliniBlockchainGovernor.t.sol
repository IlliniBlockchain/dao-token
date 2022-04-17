// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import "./Vm.sol";

import "../IlliniBlockchainSP22Token.sol";
import "../IlliniBlockchainGovernor.sol";

contract IlliniBlockchainGovernorTest is DSTest {
    Vm vm = Vm(HEVM_ADDRESS);
    IlliniBlockchainSP22Token token;
    uint256 tokenID;
    IlliniBlockchainGovernor gov;
    address owner;
    address[10] tokenOwners;

    function setUp() public {
        vm.startPrank(owner);
        token = new IlliniBlockchainSP22Token();
        IlliniBlockchainSP22Token.TokenMetadataParams memory meta = IlliniBlockchainSP22Token
            .TokenMetadataParams({
                year: 2022,
                termId: 0 // Spring
            });
        tokenID = token.init(meta);
        gov = new IlliniBlockchainGovernor(token, tokenID);

        for (uint256 i = 0; i < tokenOwners.length; i++) {
            tokenOwners[i] = vm.addr(i + 1);
        }
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }

    function test_getVotes() public {
        vm.startPrank(owner);
        uint256 amount = 1;
        token.mint(tokenOwners[0], tokenID, amount, bytes(""));

        assertEq(amount, gov.getVotes(tokenOwners[0], block.number));
    }

    function test_updateTokenId() public {
        IlliniBlockchainSP22Token.TokenMetadataParams memory meta = IlliniBlockchainSP22Token
            .TokenMetadataParams({
                year: 2022,
                termId: 1 // Fall
            });

        vm.prank(owner);
        uint256 newTokenId = token.init(meta);
        uint256 amount = 1;

        vm.prank(address(gov));
        gov.updateTokenId(newTokenId);

        vm.prank(owner);
        token.mint(tokenOwners[0], newTokenId, amount, bytes(""));
        assertEq(amount, gov.getVotes(tokenOwners[0], block.number));
    }

    function testFail_updateTokenId() public {
        // Only governor should be able to update token id
        vm.startPrank(address(0x123));
        gov.updateTokenId(123);
    }
}

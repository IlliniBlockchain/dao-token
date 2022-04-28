// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import "./Vm.sol";

import "@openzeppelin/contracts/governance/IGovernor.sol";
import "../Governor.sol";
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

    function test_token_distribution() public {
        // Proposal can't start from genesis block
        vm.roll(10);

        string memory description = "Token Distribution";

        // Distribute initial tokens
        for (uint256 i = 0; i < tokenOwners.length; i++) {
            vm.prank(owner);
            token.mint(tokenOwners[i], tokenID, 1, bytes(""));
        }

        // Transfer token ownership to governor
        vm.prank(owner);
        token.transferOwnership(address(gov));

        // Setup new token metadata
        IlliniBlockchainSP22Token.TokenMetadataParams memory newMeta = IlliniBlockchainSP22Token
            .TokenMetadataParams({
                year: 2022,
                termId: 1 // Fall
            });
        uint256 newTokenID = tokenID + 1;

        Governor.ProposalParams memory proposalParams = Governor
            .ProposalParams({
                targets: new address[](tokenOwners.length + 2),
                values: new uint256[](tokenOwners.length + 2),
                calldatas: new bytes[](tokenOwners.length + 2),
                description: description,
                votingDelay: 0,
                votingPeriod: 100
            });

        // Setup calls for switching to new token
        proposalParams.targets[0] = address(token);
        proposalParams.values[0] = 0;
        proposalParams.calldatas[0] = abi.encodeWithSignature(
            "setTokenMetadata(uint256,(uint16,uint16))",
            newTokenID,
            newMeta
        );

        // Setup calls for distributing new tokens to previous owners
        for (uint256 i = 0; i < tokenOwners.length; i++) {
            proposalParams.targets[i + 1] = address(token);
            proposalParams.values[i + 1] = 0;
            proposalParams.calldatas[i + 1] = abi.encodeWithSignature(
                "mint(address,uint256,uint256,bytes)",
                tokenOwners[i],
                newTokenID,
                1,
                bytes("")
            );
        }

        // Switch to new token
        proposalParams.targets[tokenOwners.length + 1] = address(gov);
        proposalParams.values[tokenOwners.length + 1] = 0;
        proposalParams.calldatas[tokenOwners.length + 1] = abi
            .encodeWithSignature("updateTokenId(uint256)", newTokenID);

        // Propose
        vm.deal(tokenOwners[0], 1000);
        vm.prank(tokenOwners[0]);
        uint256 proposalID = gov.propose(proposalParams);

        // Vote
        vm.roll(15);
        for (uint256 i = 0; i < tokenOwners.length; i++) {
            vm.prank(tokenOwners[i]);
            gov.castVote(
                proposalID,
                1 /* For */
            );
        }

        // Go to proposal deadline
        // start Block + voting delay + voting period
        vm.roll(10 + 0 + 100 + 1);

        // Execute
        vm.prank(tokenOwners[0]);
        gov.execute(
            proposalParams.targets,
            proposalParams.values,
            proposalParams.calldatas,
            keccak256(bytes(description))
        );

        // Check new token
        for (uint256 i = 0; i < tokenOwners.length; i++) {
            assertEq(1, token.balanceOf(tokenOwners[i], newTokenID));
        }
    }
}

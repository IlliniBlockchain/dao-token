// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import "./Vm.sol";

import "../IlliniBlockchainSP22Token.sol";

contract IlliniBlockchainSP22TokenTest is DSTest {
    Vm vm = Vm(HEVM_ADDRESS);
    IlliniBlockchainSP22Token token;
    address owner = address(0x01);
    bytes errorMsg = "";

    function setUp() public {
        vm.startPrank(owner);
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
        bytes memory data = "203948321";
        vm.prank(owner);
        token.mint(to, ids[0], amounts[0], data);

        // get balances
        uint256 bal1Before = token.balanceOf(addr1, ids[0]);
        uint256 bal2Before = token.balanceOf(addr2, ids[0]);
        uint256 tk2bal1Before = token.balanceOf(addr1, ids[1]);
        uint256 tk2bal2Before = token.balanceOf(addr2, ids[1]);

        // try to transfer to another address
        vm.prank(addr1);
        vm.expectRevert(errorMsg);
        token.safeTransferFrom(addr1, addr2, ids[0], amounts[0], data);
        vm.expectRevert(errorMsg);
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

    function test_tokenSupply() public {
        uint256 tokenId = 1;
        IlliniBlockchainSP22Token.TokenMetadataParams
            memory meta = IlliniBlockchainSP22Token.TokenMetadataParams({
                year: 2022,
                termId: 1
            });

        // Token does not exist yet.
        assertEq(0, token.totalSupply(tokenId), "total supply not 0");

        // Mint token.
        vm.startPrank(owner);
        token.mint(owner, tokenId, 100, bytes(""));

        // Token exists now.
        assertEq(100, token.totalSupply(tokenId), "total supply not 100");

        // Set metadata.
        token.setTokenMetadata(tokenId, meta);
        // Token supply should not change.
        assertEq(
            100,
            token.totalSupply(tokenId),
            "total supply changed after setting metadata"
        );
    }

    function test_exists() public {
        uint256 tokenId = 1;
        IlliniBlockchainSP22Token.TokenMetadataParams
            memory meta = IlliniBlockchainSP22Token.TokenMetadataParams({
                year: 2022,
                termId: 1
            });

        // Token does not exist yet.
        assertTrue(!token.exists(tokenId), "total should not exist");

        // Mint token.
        vm.startPrank(owner);
        token.mint(owner, tokenId, 100, bytes(""));

        // Token exists now.
        assertTrue(token.exists(tokenId), "total should exist");

        // Set metadata.
        token.setTokenMetadata(tokenId, meta);
        // Token supply should not change.
        assertTrue(
            token.exists(tokenId),
            "total should still exist after setting metadata"
        );
    }

    function test_setTokenMetadata() public {
        uint256 tokenId = 1;
        IlliniBlockchainSP22Token.TokenMetadataParams
            memory meta = IlliniBlockchainSP22Token.TokenMetadataParams({
                year: 2022,
                termId: 1
            });
        vm.startPrank(owner);
        token.setTokenMetadata(tokenId, meta);

        (uint16 year, uint16 termId, uint224 totalSupply) = token.tokenMetadata(
            tokenId
        );
        assertEq(meta.year, year);
        assertEq(meta.termId, termId);
        assertEq(0, totalSupply);
    }

    function testFail_setTokenMetadata_owner() public {
        // setTokenMetadata should only be called by owner
        uint256 tokenId = 1;
        IlliniBlockchainSP22Token.TokenMetadataParams
            memory meta = IlliniBlockchainSP22Token.TokenMetadataParams({
                year: 2022,
                termId: 1
            });
        vm.startPrank(address(0x2022));
        token.setTokenMetadata(tokenId, meta);
    }

    function testFail_setTokenMetadata_twice() public {
        // setTokenMetadata should only be called once per tokenId
        uint256 tokenId = 1;
        IlliniBlockchainSP22Token.TokenMetadataParams
            memory meta = IlliniBlockchainSP22Token.TokenMetadataParams({
                year: 2022,
                termId: 1
            });
        vm.startPrank(owner);
        token.setTokenMetadata(tokenId, meta);
        token.setTokenMetadata(tokenId, meta);
    }

    function testFail_setTokenMetadata_termId() public {
        // termId must be less than 2 (Fall and Spring)
        uint256 tokenId = 1;
        IlliniBlockchainSP22Token.TokenMetadataParams memory meta = IlliniBlockchainSP22Token
            .TokenMetadataParams({
                year: 2022,
                termId: 2 // 2 is invalid
            });
        vm.startPrank(owner);
        token.setTokenMetadata(tokenId, meta);
    }

    function test_init() public {
        uint256 tokenId = 1;
        IlliniBlockchainSP22Token.TokenMetadataParams
            memory meta = IlliniBlockchainSP22Token.TokenMetadataParams({
                year: 2022,
                termId: 1
            });
        vm.startPrank(owner);
        address[] memory addrs = new address[](1);
        addrs[0] = owner;
        uint256 id = token.init(meta, addrs);
        assertEq(id, tokenId);
        assertEq(token.balanceOf(owner, tokenId), 1);
    }

    function testFail_init_owner() public {
        IlliniBlockchainSP22Token.TokenMetadataParams
            memory meta = IlliniBlockchainSP22Token.TokenMetadataParams({
                year: 2022,
                termId: 1
            });
        vm.startPrank(address(0x2022));
        address[] memory addrs = new address[](1);
        addrs[0] = owner;
        token.init(meta, addrs);
    }

    function test_mint() public {
        uint256 id = 1;
        uint256 amount = 100;
        bytes memory data = bytes("");
        vm.startPrank(owner);
        token.mint(owner, id, amount, data);

        assertEq(token.balanceOf(owner, id), amount);
    }

    function testFail_mint_owner() public {
        // mint should only be called by owner
        uint256 id = 1;
        uint256 amount = 100;
        bytes memory data = bytes("");
        vm.startPrank(address(0x2022));
        token.mint(owner, id, amount, data);
    }

    function test_contractURI() public {
        assertEq(
            token.contractURI(),
            "data:application/json;base64,eyJuYW1lIjoiSWxsaW5pQmxvY2tjaGFpbiIsImRlc2NyaXB0aW9uIjoiU3R1ZGVudCBvcmdhbml6YXRpb24gYXQgdGhlIFVuaXZlcnNpdHkgb2YgSWxsaW5vaXMgYXQgVXJiYW5hLUNoYW1wYWlnbi4iLCJleHRlcm5hbF9saW5rIjogImh0dHBzOi8vaWxsaW5pYmxvY2tjaGFpbi5jb20vIiwiaW1hZ2UiOiAiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCM2FXUjBhRDBuTXpVd0p5Qm9aV2xuYUhROUp6SXdNQ2NnZUcxc2JuTTlKMmgwZEhBNkx5OTNkM2N1ZHpNdWIzSm5Mekl3TURBdmMzWm5KeUIyYVdWM1FtOTRQU2N3SURBZ016VXdJREl3TUNjZ2MzUjViR1U5SjJKaFkydG5jbTkxYm1RdFkyOXNiM0k2ZDJocGRHVW5QanhrWldaelBqeHpkSGxzWlQ0dVlYdG1hV3hzT201dmJtVTdjM1J5YjJ0bE9pTXlNekZtTWpBN2MzUnliMnRsTFhkcFpIUm9Pakp3ZUgwdVludG1hV3hzT2lObVptWTdabTl1ZEMxbVlXMXBiSGs2SjBOdmRYSnBaWElnVG1WM0p5eHRiMjV2YzNCaFkyVTdabTl1ZEMxemFYcGxPakU0Y0hoOVBDOXpkSGxzWlQ0OEwyUmxabk0rUEhCaGRHZ2dZMnhoYzNNOUoyRW5JR1E5SjAwMU5pNHpJRGcwWXpJdU1pMDNJRE00TGpRdE1UY3VOQ0EwTUMweE5TNHpUVEV3TlM0MklEYzRMak5qTVM0eElERXVOUzB4T0M0eElETXpMall0TWpRdU9DQXpORTB4TnpFdU5TQXpNQzQyWXkweExqZ2dPUzR6TFRJNUxqZ2dNakl1Tmkwek1TQXhPUzQzVFRFeE5DNDBJREk0TGpaakxTNDJMVEV1T1NBek1TNDFMVEU0TGpZZ016Z3VOQzB4TlM0eVRUVTJMaklnTVRNekxqaGpNUzR6SURFdU15MHlNQzQ0SURJNUxqWXRNamd1TlNBek1FMDFMakVnTVRNNUxqZGpNUzQzTFRrdU1TQXpNQzB5TWk0M0lETXhMak10TVRrdU9TY3ZQanh3WVhSb0lHUTlKMDAzTXlBeE16UXVNbk10TXpjdU5DNHlMVE0zTGpNZ01HTXdJREF0TGpJdE16Y3VOQ0F3TFRNM0xqUWdNQ0F3SURNM0xqUXRMaklnTXpjdU15QXdJREFnTUNBdU1pQXpOeTQwSURBZ016Y3VOSG9uUGp4aGJtbHRZWFJsSUdGMGRISnBZblYwWlU1aGJXVTlKMlpwYkd3bklIWmhiSFZsY3owbkl6RXdNakl6WkRzalkyUTBOVE14T3lNeE1ESXlNMlFuSUdSMWNqMG5PSE1uSUhKbGNHVmhkRU52ZFc1MFBTZHBibVJsWm1sdWFYUmxKeTgrUEM5d1lYUm9Qanh3WVhSb0lHUTlKMDAzTXlBNU5pNDJZeTB1TXkwdU5DQXhNQzQwTFRFekxqTWdPQzQxTFRFekxqTXRMak11TWkwek5pNDRMUzQzTFRNM0xTNHliQzA0TGpjZ01UTXVOR011TWk0NEp6NDhZVzVwYldGMFpTQmhkSFJ5YVdKMWRHVk9ZVzFsUFNkbWFXeHNKeUIyWVd4MVpYTTlKeU14WlRRMU4ySTdJMlU0TnpnMk56c2pNV1UwTlRkaUp5QmtkWEk5Snpoekp5QnlaWEJsWVhSRGIzVnVkRDBuYVc1a1pXWnBibWwwWlNjdlBqd3ZjR0YwYUQ0OGNHRjBhQ0JrUFNkTk56TXVNaUF4TXpNdU9HdzRMall0TVRZdU4xWTRNeTQyWXkwdU1TMHVNeTA0TGpZZ01UTXVNaTA0TGpjZ01UTXVNU2MrUEdGdWFXMWhkR1VnWVhSMGNtbGlkWFJsVG1GdFpUMG5abWxzYkNjZ2RtRnNkV1Z6UFNjak1XWXpNVFl4T3lObE1UUmxNemc3SXpGbU16RTJNU2NnWkhWeVBTYzRjeWNnY21Wd1pXRjBRMjkxYm5ROUoybHVaR1ZtYVc1cGRHVW5MejQ4TDNCaGRHZytQSEJoZEdnZ1pEMG5UVEV6TXk0eElEUXhMalpqTFM0ekxTNDBJREV3TGpRdE1UTXVNeUE0TGpVdE1UTXVNeTB1TXk0eUxUTTJMamd0TGpjdE16Y3RMakpzTFRndU55QXhNeTQwWXk0eUxqZ25QanhoYm1sdFlYUmxJR0YwZEhKcFluVjBaVTVoYldVOUoyWnBiR3duSUhaaGJIVmxjejBuSTJVNE56ZzJOenNqTVdVME5UZGlPeU5sT0RjNE5qY25JR1IxY2owbk9ITW5JSEpsY0dWaGRFTnZkVzUwUFNkcGJtUmxabWx1YVhSbEp5OCtQQzl3WVhSb1BqeHdZWFJvSUdROUowMHhNek1nTnprdU1uTXRNemN1TkM0eUxUTTNMak1nTUdNd0lEQXRMakl0TXpjdU5DQXdMVE0zTGpRZ01DQXdJRE0zTGpRdExqSWdNemN1TXlBd0lEQWdNQ0F1TWlBek55NDBJREFnTXpjdU5Ib25QanhoYm1sdFlYUmxJR0YwZEhKcFluVjBaVTVoYldVOUoyWnBiR3duSUhaaGJIVmxjejBuSTJOa05EVXpNVHNqTVRBeU1qTmtPeU5qWkRRMU16RW5JR1IxY2owbk9ITW5JSEpsY0dWaGRFTnZkVzUwUFNkcGJtUmxabWx1YVhSbEp5OCtQQzl3WVhSb1BqeHdZWFJvSUdROUowMHhNek11TWlBM09DNDViRGd1TmkweE5pNDNWakk0TGpkakxTNHhMUzR6TFRndU5pQXhNeTR5TFRndU55QXhNeTR4Sno0OFlXNXBiV0YwWlNCaGRIUnlhV0oxZEdWT1lXMWxQU2RtYVd4c0p5QjJZV3gxWlhNOUp5TmxNVFJsTXpnN0l6Rm1NekUyTVRzalpURTBaVE00SnlCa2RYSTlKemh6SnlCeVpYQmxZWFJEYjNWdWREMG5hVzVrWldacGJtbDBaU2N2UGp3dmNHRjBhRDQ4ZEdWNGRDQjBjbUZ1YzJadmNtMDlKM1J5WVc1emJHRjBaU2d4TWpNZ01UQTFLU2NnWm1sc2JEMG5JekV4TWprMFlpY2dabTl1ZEMxbVlXMXBiSGs5SnlKRGIzVnlhV1Z5SUU1bGR5SW5JR1p2Ym5RdGQyVnBaMmgwUFNkaWIyeGtKeUJtYjI1MExYTnBlbVU5SnpNMEp6NDhkSE53WVc0Z2VEMG5NQ2NnZVQwbk1DYytTVXhNU1U1SlBDOTBjM0JoYmo0OGRITndZVzRnZUQwbk1DY2dlVDBuTXpZblBrSk1UME5MUTBoQlNVNDhMM1J6Y0dGdVBqd3ZkR1Y0ZEQ0OEwzTjJaejQ9In0="
        );
    }

    function test_uri() public {
        uint256 id = 1;
        uint256 amount = 100;
        bytes memory data = bytes("");
        IlliniBlockchainSP22Token.TokenMetadataParams memory meta = IlliniBlockchainSP22Token
            .TokenMetadataParams({
                year: 2022,
                termId: 0 // Spring
            });
        vm.startPrank(owner);
        token.mint(owner, id, amount, data);
        token.setTokenMetadata(id, meta);

        assertEq(
            token.uri(id),
            "data:application/json;base64,eyJuYW1lIjoiSWxsaW5pQmxvY2tjaGFpbiBTcHJpbmcgMjAyMiBNZW1iZXIiLCJkZXNjcmlwdGlvbiI6IklsbGluaUJsb2NrY2hhaW4gTWVtYmVyc2hpcCIsImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjNhV1IwYUQwbk16VXdKeUJvWldsbmFIUTlKekl3TUNjZ2VHMXNibk05SjJoMGRIQTZMeTkzZDNjdWR6TXViM0puTHpJd01EQXZjM1puSnlCMmFXVjNRbTk0UFNjd0lEQWdNelV3SURJd01DY2djM1I1YkdVOUoySmhZMnRuY205MWJtUXRZMjlzYjNJNmQyaHBkR1VuUGp4a1pXWnpQanh6ZEhsc1pUNHVZWHRtYVd4c09tNXZibVU3YzNSeWIydGxPaU15TXpGbU1qQTdjM1J5YjJ0bExYZHBaSFJvT2pKd2VIMHVZbnRtYVd4c09pTm1abVk3Wm05dWRDMW1ZVzFwYkhrNkowTnZkWEpwWlhJZ1RtVjNKeXh0YjI1dmMzQmhZMlU3Wm05dWRDMXphWHBsT2pFNGNIaDlQQzl6ZEhsc1pUNDhMMlJsWm5NK1BIQmhkR2dnWTJ4aGMzTTlKMkVuSUdROUowMDFOaTR6SURnMFl6SXVNaTAzSURNNExqUXRNVGN1TkNBME1DMHhOUzR6VFRFd05TNDJJRGM0TGpOak1TNHhJREV1TlMweE9DNHhJRE16TGpZdE1qUXVPQ0F6TkUweE56RXVOU0F6TUM0Mll5MHhMamdnT1M0ekxUSTVMamdnTWpJdU5pMHpNU0F4T1M0M1RURXhOQzQwSURJNExqWmpMUzQyTFRFdU9TQXpNUzQxTFRFNExqWWdNemd1TkMweE5TNHlUVFUyTGpJZ01UTXpMamhqTVM0eklERXVNeTB5TUM0NElESTVMall0TWpndU5TQXpNRTAxTGpFZ01UTTVMamRqTVM0M0xUa3VNU0F6TUMweU1pNDNJRE14TGpNdE1Ua3VPU2N2UGp4d1lYUm9JR1E5SjAwM015QXhNelF1TW5NdE16Y3VOQzR5TFRNM0xqTWdNR013SURBdExqSXRNemN1TkNBd0xUTTNMalFnTUNBd0lETTNMalF0TGpJZ016Y3VNeUF3SURBZ01DQXVNaUF6Tnk0MElEQWdNemN1TkhvblBqeGhibWx0WVhSbElHRjBkSEpwWW5WMFpVNWhiV1U5SjJacGJHd25JSFpoYkhWbGN6MG5JekV3TWpJelpEc2pZMlEwTlRNeE95TXhNREl5TTJRbklHUjFjajBuT0hNbklISmxjR1ZoZEVOdmRXNTBQU2RwYm1SbFptbHVhWFJsSnk4K1BDOXdZWFJvUGp4d1lYUm9JR1E5SjAwM015QTVOaTQyWXkwdU15MHVOQ0F4TUM0MExURXpMak1nT0M0MUxURXpMak10TGpNdU1pMHpOaTQ0TFM0M0xUTTNMUzR5YkMwNExqY2dNVE11TkdNdU1pNDRKejQ4WVc1cGJXRjBaU0JoZEhSeWFXSjFkR1ZPWVcxbFBTZG1hV3hzSnlCMllXeDFaWE05SnlNeFpUUTFOMkk3STJVNE56ZzJOenNqTVdVME5UZGlKeUJrZFhJOUp6aHpKeUJ5WlhCbFlYUkRiM1Z1ZEQwbmFXNWtaV1pwYm1sMFpTY3ZQand2Y0dGMGFENDhjR0YwYUNCa1BTZE5Oek11TWlBeE16TXVPR3c0TGpZdE1UWXVOMVk0TXk0Mll5MHVNUzB1TXkwNExqWWdNVE11TWkwNExqY2dNVE11TVNjK1BHRnVhVzFoZEdVZ1lYUjBjbWxpZFhSbFRtRnRaVDBuWm1sc2JDY2dkbUZzZFdWelBTY2pNV1l6TVRZeE95TmxNVFJsTXpnN0l6Rm1NekUyTVNjZ1pIVnlQU2M0Y3ljZ2NtVndaV0YwUTI5MWJuUTlKMmx1WkdWbWFXNXBkR1VuTHo0OEwzQmhkR2crUEhCaGRHZ2daRDBuVFRFek15NHhJRFF4TGpaakxTNHpMUzQwSURFd0xqUXRNVE11TXlBNExqVXRNVE11TXkwdU15NHlMVE0yTGpndExqY3RNemN0TGpKc0xUZ3VOeUF4TXk0MFl5NHlMamduUGp4aGJtbHRZWFJsSUdGMGRISnBZblYwWlU1aGJXVTlKMlpwYkd3bklIWmhiSFZsY3owbkkyVTROemcyTnpzak1XVTBOVGRpT3lObE9EYzROamNuSUdSMWNqMG5PSE1uSUhKbGNHVmhkRU52ZFc1MFBTZHBibVJsWm1sdWFYUmxKeTgrUEM5d1lYUm9Qanh3WVhSb0lHUTlKMDB4TXpNZ056a3VNbk10TXpjdU5DNHlMVE0zTGpNZ01HTXdJREF0TGpJdE16Y3VOQ0F3TFRNM0xqUWdNQ0F3SURNM0xqUXRMaklnTXpjdU15QXdJREFnTUNBdU1pQXpOeTQwSURBZ016Y3VOSG9uUGp4aGJtbHRZWFJsSUdGMGRISnBZblYwWlU1aGJXVTlKMlpwYkd3bklIWmhiSFZsY3owbkkyTmtORFV6TVRzak1UQXlNak5rT3lOalpEUTFNekVuSUdSMWNqMG5PSE1uSUhKbGNHVmhkRU52ZFc1MFBTZHBibVJsWm1sdWFYUmxKeTgrUEM5d1lYUm9Qanh3WVhSb0lHUTlKMDB4TXpNdU1pQTNPQzQ1YkRndU5pMHhOaTQzVmpJNExqZGpMUzR4TFM0ekxUZ3VOaUF4TXk0eUxUZ3VOeUF4TXk0eEp6NDhZVzVwYldGMFpTQmhkSFJ5YVdKMWRHVk9ZVzFsUFNkbWFXeHNKeUIyWVd4MVpYTTlKeU5sTVRSbE16ZzdJekZtTXpFMk1Uc2paVEUwWlRNNEp5QmtkWEk5Snpoekp5QnlaWEJsWVhSRGIzVnVkRDBuYVc1a1pXWnBibWwwWlNjdlBqd3ZjR0YwYUQ0OGRHVjRkQ0IwY21GdWMyWnZjbTA5SjNSeVlXNXpiR0YwWlNneE1qTWdNVEExS1NjZ1ptbHNiRDBuSXpFeE1qazBZaWNnWm05dWRDMW1ZVzFwYkhrOUp5SkRiM1Z5YVdWeUlFNWxkeUluSUdadmJuUXRkMlZwWjJoMFBTZGliMnhrSnlCbWIyNTBMWE5wZW1VOUp6TTBKejQ4ZEhOd1lXNGdlRDBuTUNjZ2VUMG5NQ2MrU1V4TVNVNUpQQzkwYzNCaGJqNDhkSE53WVc0Z2VEMG5NQ2NnZVQwbk16WW5Qa0pNVDBOTFEwaEJTVTQ4TDNSemNHRnVQand2ZEdWNGRENDhjbVZqZENCamJHRnpjejBuWVNjZ2VEMG5NU2NnZVQwbk1TY2dkMmxrZEdnOUp6TTBPQ2NnYUdWcFoyaDBQU2N4T1RnbklISjRQU2M1SnlCeWVUMG5PU2N2UGp4bklIUnlZVzV6Wm05eWJUMG5kSEpoYm5Oc1lYUmxLREkwTUNBeE5qVXBKejQ4Y21WamRDQjNhV1IwYUQwbk1UQXdjSGduSUdobGFXZG9kRDBuTWpad2VDY2djbmc5Snpod2VDY2djbms5Snpod2VDY2dabWxzYkQwbkl6RXhNamswWWljdlBqeDBaWGgwSUdOc1lYTnpQU2RpSno0OGRITndZVzRnZUQwbk1qQW5JSGs5SnpFM0p6NU5aVzFpWlhJOEwzUnpjR0Z1UGp3dmRHVjRkRDQ4TDJjK1BHY2dkSEpoYm5ObWIzSnRQU0owY21GdWMyeGhkR1VvTWpBd0lERXdLU0krUEhKbFkzUWdkMmxrZEdnOUlqRTBNSEI0SWlCb1pXbG5hSFE5SWpJMmNIZ2lJSEo0UFNJNGNIZ2lJSEo1UFNJNGNIZ2lJR1pwYkd3OUlpTmxOelJpTWpZaUlDOCtQSFJsZUhRZ1kyeGhjM005SW1JaVBqeDBjM0JoYmlCNFBTSXhNQ0lnZVQwaU1UY2lQbE53Y21sdVp5QXlNREl5UEM5MGMzQmhiajQ4TDNSbGVIUStQQzluUGp3dmMzWm5QZz09In0="
        );
    }
}

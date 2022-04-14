// SPDX-License-Identifier: MIT
// Modification of OpenZeppelin Contracts (last updated v4.5.0) (governance/extensions/GovernorVotes.sol)

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/governance/Governor.sol";
import {IVotes} from "../utils/IVotes.sol";

/**
 * @dev Extension of {Governor} for voting weight extraction from an {ERC20Votes} token, or since v4.5 an {ERC721Votes} token.
 *
 * _Available since v4.3._
 */
abstract contract GovernorVotes is Governor {
    IVotes public immutable token;
    uint256 public tokenId;

    constructor(IVotes tokenAddress, uint256 _tokenId) {
        token = tokenAddress;
        tokenId = _tokenId;
    }

    function updateTokenId(uint256 _tokenId) external virtual onlyGovernance {
        tokenId = _tokenId;
    }

    /**
     * Read the voting weight from the token's built in snapshot mechanism (see {Governor-_getVotes}).
     */
    function _getVotes(
        address account,
        uint256 blockNumber,
        bytes memory /*params*/
    ) internal view virtual override returns (uint256) {
        return token.getVotes(account, tokenId);
    }
}

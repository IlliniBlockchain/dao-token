// SPDX-License-Identifier: MIT
// Modification of OpenZeppelin Contracts (last updated v4.5.0) (governance/utils/IVotes.sol)
pragma solidity ^0.8.0;

/**
 * @dev Common interface for {ERC20Votes}, {ERC721Votes}, and other {Votes}-enabled contracts.
 *
 */
interface IVotes {
    /**
     * @dev Returns the current amount of votes that `account` has for the given token.
     */
    function getVotes(address account, uint256 tokenId)
        external
        view
        returns (uint256);

    /**
     * @dev Returns the total supply of votes available for a tokenId.
     */
    function totalSupply(uint256 tokenId) external view returns (uint256);
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {ERC1155} from "solmate/tokens/ERC1155.sol";
import "../utils/IVotes.sol";

abstract contract ERC1155Votes is ERC1155, IVotes {
    function getVotes(address account, uint256 tokenId)
        external
        view
        virtual
        override
        returns (uint256)
    {
        return balanceOf[account][tokenId];
    }

    function totalSupply(uint256 tokenId)
        external
        view
        virtual
        returns (uint256);
}

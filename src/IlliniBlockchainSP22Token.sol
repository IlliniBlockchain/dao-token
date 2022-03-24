// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import {ERC1155} from "solmate/tokens/ERC1155.sol";

contract IlliniBlockchainSP22Token is ERC1155 {
    struct TokenMetadata {
        uint8 year;
        uint8 termId;
    }
    string[] internal terms;
    mapping(uint256 => TokenMetadata) public tokenMetadata;

    constructor() public {
        terms = ["Fall", "Spring"];
    }

    function uri(uint256)
        public
        pure
        virtual
        override
        returns (string memory)
    {}
}

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import {ERC1155} from "solmate/tokens/ERC1155.sol";

contract IlliniBlockchainSP22Token is ERC1155 {
    function uri(uint256) public pure virtual override returns (string memory) {
        
    }
    
}

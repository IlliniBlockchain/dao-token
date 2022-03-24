// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import {ERC1155} from "solmate/tokens/ERC1155.sol";

contract IlliniBlockchainSP22Token is ERC1155 {
    modifier onlyOwner {
        // TODO: Change address 
      require(msg.sender == "0xfd8292f29c1406ecf70df3152a1cae4755068ee1", "This address is not allowed to mint");
   }

    function uri(uint256) public pure virtual override returns (string memory) {
        
    }

    function mint(uint8 _id, uint256 _amount, bytes memory _data)
        public
        onlyOwner
    {
        _mint(msg.sender, _id, _amount, _data);
    }

}

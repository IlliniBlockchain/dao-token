// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import {ERC1155} from "solmate/tokens/ERC1155.sol";

contract IlliniBlockchainSP22Token is ERC1155 {
    struct TokenMetadata {
        uint8 year;
        uint8 termId;
    }
    string[] internal terms;
    address owner;
    mapping(uint256 => TokenMetadata) public tokenMetadata;

    constructor(address _owner) public {
        terms = ["Fall", "Spring"];
        owner = _owner;
    }

    function uri(uint256)
        public
        pure
        virtual
        override
        returns (string memory)
    {}

    modifier onlyOwner() {
        // TODO: Change address
        require(msg.sender == owner, "This address is not allowed to mint");
    }

    function uri(uint256 _tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        TokenMetadata memory meta = tokenMetadata[_tokenId];
        string memory yearStr = meta.year.toString();
        string memory termStr = terms[meta.termId];
        string memory image = Base64.encode(
            bytes(
                NFTSVG.generateSVG(
                    NFTSVG.SVGParams({year: yearStr, term: termStr})
                )
            )
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"IlliniBlockchain ',
                                termStr,
                                " ",
                                yearStr,
                                ' Member",',
                                '"description:"IlliniBlockchain Membership",',
                                '"image": "',
                                "data:image/svg+xml;base64,",
                                image,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function mint(
        address _to,
        uint256 _id,
        uint256 _amount,
        TokenMetadata calldata _metadata,
        bytes memory _data
    ) public onlyOwner {
        tokenMetadata[_id] = _metadata;
        _mint(_to, _id, _amount, _data);
    }
}

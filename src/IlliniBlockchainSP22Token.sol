// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import {ERC1155} from "solmate/tokens/ERC1155.sol";
import {NFTSVG} from "./libraries/NFTSVG.sol";
import "openzeppelin-contracts/contracts/utils/Base64.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

contract IlliniBlockchainSP22Token is ERC1155 {
    using Strings for uint16;

    struct TokenMetadata {
        uint16 year;
        uint8 termId;
    }

    string[] internal terms;
    address owner;
    mapping(uint256 => TokenMetadata) public tokenMetadata;
    string public name = "IlliniBlockchain";

    constructor(address _owner) {
        terms = ["Fall", "Spring"];
        owner = _owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "This address is not allowed to mint");
        _;
    }

    function changeOwner(address _owner) public onlyOwner {
        owner = _owner;
    }

    function contractURI() public view returns (string memory) {
        string memory image = Base64.encode(
            bytes(abi.encodePacked(NFTSVG.baseSVG, "</svg>"))
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name,
                                '",',
                                '"description":"Student organization at the University of Illinois at Urbana-Champaign.",',
                                '"external_link": "https://illiniblockchain.com/",',
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
                                '"description":"IlliniBlockchain Membership",',
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

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import {ERC1155} from "solmate/tokens/ERC1155.sol";
import {NFTSVG} from "./libraries/NFTSVG.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/utils/Base64.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

contract IlliniBlockchainSP22Token is ERC1155, Ownable {
    using Strings for uint16;

    struct TokenMetadata {
        uint16 year;
        uint8 termId;
    }

    string[] internal terms;
    mapping(uint256 => TokenMetadata) public tokenMetadata;
    string public name = "IlliniBlockchain";

    constructor() {
        terms = ["Fall", "Spring"];
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

    function setTokenMetadata(
        uint256 _tokenId,
        uint16 _year,
        uint8 _termId
    ) public onlyOwner {
        require(_termId < terms.length, "Invalid term");
        require(
            tokenMetadata[_tokenId].year == 0,
            "Token already has metadata"
        );
        tokenMetadata[_tokenId] = TokenMetadata({year: _year, termId: _termId});
    }

    function mint(
        address _to,
        uint256 _id,
        uint256 _amount,
        bytes memory _data
    ) public onlyOwner {
        _mint(_to, _id, _amount, _data);
    }
}

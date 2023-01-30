// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import {ERC1155} from "solmate/tokens/ERC1155.sol";
import {ERC1155Votes} from "./extensions/ERC1155Votes.sol";
import {NFTSVG} from "./libraries/NFTSVG.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract IlliniBlockchainSP22Token is ERC1155, Ownable, ERC1155Votes {
    using Strings for uint16;

    struct TokenMetadata {
        uint16 year;
        uint16 termId;
        uint224 totalSupply;
    }

    struct TokenMetadataParams {
        uint16 year;
        uint16 termId;
    }

    string[2] internal terms;
    mapping(uint256 => TokenMetadata) public tokenMetadata;
    string public name = "IlliniBlockchain";

    // A nonce to ensure we have a unique id each time we mint.
    uint256 public nonce = 0;

    constructor() {
        terms = ["Spring", "Fall"];
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

    /**
     * @dev Total amount of tokens in with a given id.
     */
    function totalSupply(uint256 id)
        public
        view
        virtual
        override
        returns (uint256)
    {
        return tokenMetadata[id].totalSupply;
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 id) public view returns (bool) {
        return IlliniBlockchainSP22Token.totalSupply(id) > 0;
    }

    /**
     * @dev Sets metadata for token with given id only once.
     *
     * Can only be called once for a given id.
     */
    function setTokenMetadata(
        uint256 _id,
        TokenMetadataParams calldata _metadata
    ) public onlyOwner {
        require(_metadata.termId < terms.length, "Invalid term");
        require(tokenMetadata[_id].year == 0, "Token already has metadata");
        tokenMetadata[_id].year = _metadata.year;
        tokenMetadata[_id].termId = _metadata.termId;
    }

    /**
     * @dev Initializes a new token type from metadata.
     */
    function init(TokenMetadataParams calldata _metadata)
        public
        onlyOwner
        returns (uint256 _id)
    {
        setTokenMetadata(++nonce, _metadata);
        _id = nonce;
    }

    function mint(
        address _to,
        uint256 _id,
        uint256 _amount,
        bytes memory _data
    ) public onlyOwner {
        _mint(_to, _id, _amount, _data);
        tokenMetadata[_id].totalSupply += SafeCast.toUint224(_amount);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        revert();
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual override {
        revert();
    }
}

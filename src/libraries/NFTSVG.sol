// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

/// @title NFTSVG
/// @notice Provides a function for generating an SVG associated with a IlliniBlockchain NFT
library NFTSVG {
    struct SVGParams {
        string year;
        string term;
    }

    string constant baseSVG =
        "<svg width='350' height='200' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 350 200'><defs><style>.a{fill:none;stroke:#231f20;stroke-width:2px}.b{fill:#fff;font-family:'Courier New',monospace;font-size:18px}</style></defs><path class='a' d='M56.3 84c2.2-7 38.4-17.4 40-15.3M105.6 78.3c1.1 1.5-18.1 33.6-24.8 34M171.5 30.6c-1.8 9.3-29.8 22.6-31 19.7M114.4 28.6c-.6-1.9 31.5-18.6 38.4-15.2M56.2 133.8c1.3 1.3-20.8 29.6-28.5 30M5.1 139.7c1.7-9.1 30-22.7 31.3-19.9'/><path d='M73 134.2s-37.4.2-37.3 0c0 0-.2-37.4 0-37.4 0 0 37.4-.2 37.3 0 0 0 .2 37.4 0 37.4z'><animate attributeName='fill' values='#10223d;#cd4531;#10223d' dur='8s' repeatCount='indefinite'/></path><path d='M73 96.6c-.3-.4 10.4-13.3 8.5-13.3-.3.2-36.8-.7-37-.2l-8.7 13.4c.2.8'><animate attributeName='fill' values='#1e457b;#e87867;#1e457b' dur='8s' repeatCount='indefinite'/></path><path d='M73.2 133.8l8.6-16.7V83.6c-.1-.3-8.6 13.2-8.7 13.1'><animate attributeName='fill' values='#1f3161;#e14e38;#1f3161' dur='8s' repeatCount='indefinite'/></path><path d='M133.1 41.6c-.3-.4 10.4-13.3 8.5-13.3-.3.2-36.8-.7-37-.2l-8.7 13.4c.2.8'><animate attributeName='fill' values='#e87867;#1e457b;#e87867' dur='8s' repeatCount='indefinite'/></path><path d='M133 79.2s-37.4.2-37.3 0c0 0-.2-37.4 0-37.4 0 0 37.4-.2 37.3 0 0 0 .2 37.4 0 37.4z'><animate attributeName='fill' values='#cd4531;#10223d;#cd4531' dur='8s' repeatCount='indefinite'/></path><path d='M133.2 78.9l8.6-16.7V28.7c-.1-.3-8.6 13.2-8.7 13.1'><animate attributeName='fill' values='#e14e38;#1f3161;#e14e38' dur='8s' repeatCount='indefinite'/></path><text transform='translate(123 105)' fill='#11294b' font-family='\"Courier New\"' font-weight='bold' font-size='34'><tspan x='0' y='0'>ILLINI</tspan><tspan x='0' y='36'>BLOCKCHAIN</tspan></text>";
    string constant borderSVG =
        "<rect class='a' x='1' y='1' width='348' height='198' rx='9' ry='9'/>";
    string constant baseRoleSVG =
        "<g transform='translate(240 165)'><rect width='100px' height='26px' rx='8px' ry='8px' fill='#11294b'/><text class='b'><tspan x='20' y='17'>Member</tspan></text></g>";

    function generateSVG(SVGParams memory params)
        internal
        pure
        returns (string memory svg)
    {
        return
            string(
                abi.encodePacked(
                    baseSVG,
                    borderSVG,
                    baseRoleSVG,
                    generateSVGSemesterText(params.year, params.term),
                    "</svg>"
                )
            );
    }

    function generateSVGSemesterText(string memory year, string memory term)
        private
        pure
        returns (string memory svg)
    {
        svg = string(
            abi.encodePacked(
                '<g transform="translate(200 10)">',
                '<rect width="140px" height="26px" rx="8px" ry="8px" fill="#e74b26" />',
                '<text class="b">',
                '<tspan x="10" y="17">',
                term,
                " ",
                year,
                "</tspan>",
                "</text>",
                "</g>"
            )
        );
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "./Base64.sol";
import "./ERC721Holdable.sol";

contract AnimeLootPhysicalCharacteristics is ERC721Holdable, ReentrancyGuard {

    string[] private height = [
        "Very tall",
        "Tall",
        "Tall",
        "Medium",
        "Medium",
        "Short",
        "Short",
        "Very short"
    ];
    
    string[] private bodyShape = [
        "Strong",
        "Plump",
        "Normal",
        "Normal",
        "Slender"
    ];
    
    string[] private strengthOfRace = [
       "Pure",
       "Pure",
       "Pure",
       "Half",
       "Half",
       "Quarter",
       "Quarter",
       "One-eighth"
    ];
    
    string[] private impressiveColor = [
        "Red",
        "Yellow",
        "Green",
        "Blue",
        "Purple",
        "White",
        "Black",
        "Purple",
        "Gold",
        "Silver"
    ];

    string[] private facialFeature = [
        "Tiny",
        "Pretty",
        "Baby face",
        "Attractive",
        "Gallant",
        "Neat",
        "Astringent",
        "Dandy",
        "Scar on face",
        "Scar on tattoo",
        "One eye"
    ];


    string[] private appearanceFeature = [
        "Cleanliness",
        "Fair skin",
        "Dark skin",
        "Invalidism",
        "Healthy",
        "Boyish",
        "Neutral",
        "Girlish"
    ];

    
    function random(string memory input) internal pure returns (uint256) {
        // require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return uint256(keccak256(abi.encodePacked(input)));
    }
    
    function getHeight(uint256 tokenId) public view returns (string memory) {
        // require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return pluck(tokenId, "HEIGHT", height);
    }
    
    function getBodyShape(uint256 tokenId) public view returns (string memory) {
        // require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return pluck(tokenId, "BODYSHAPE", bodyShape);
    }
    
    function getStrengthOfRace(uint256 tokenId) public view returns (string memory) {
        // require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return pluck(tokenId, "STRENGTHOFRACE", strengthOfRace);
    }
    
    function getImpressiveColor(uint256 tokenId) public view returns (string memory) {
        // require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return pluck(tokenId, "IMPRESSIVECOLOR", impressiveColor);
    }
    
    function getFacialFeature(uint256 tokenId) public view returns (string memory) {
        // require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return pluck(tokenId, "FACIALFEATURE", facialFeature);
    }
    
    function getAppearanceFeature(uint256 tokenId) public view returns (string memory) {
        // require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return pluck(tokenId, "APPEARANCEFEATURE", appearanceFeature);
    }
    
    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string[17] memory parts;
        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: #000000; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="#FFF100" /><text x="10" y="20" class="base">';

        parts[1] = 'AnimeLoot Characteristics';

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] = getHeight(tokenId);

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] = getBodyShape(tokenId);

        parts[6] = '</text><text x="10" y="80" class="base">';

        parts[7] = getStrengthOfRace(tokenId);

        parts[8] = '</text><text x="10" y="100" class="base">';

        parts[9] = getImpressiveColor(tokenId);

        parts[10] = '</text><text x="10" y="120" class="base">';

        parts[11] = getFacialFeature(tokenId);

        parts[12] = '</text><text x="10" y="140" class="base">';

        parts[13] = getAppearanceFeature(tokenId);

        parts[14] = '</text><text x="10" y="160" class="base">';

        parts[15] = '';

        parts[16] = '</text></svg>';

        string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], parts[8]));
        output = string(abi.encodePacked(output, parts[9], parts[10], parts[11], parts[12], parts[13], parts[14], parts[15], parts[16]));
        
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Anime Character Characteristics #', toString(tokenId), '", "description": "AnimeLootCharacteristics is randomized anime characters characteristics generated and stored on chain. Other features of the characters are intentionally omitted for others to interpret. Feel free to use AnimeLootCharacteristics in any way you want.", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;
    }

    function claim(uint256 tokenId) public nonReentrant onlyHolder(tokenId) {
        require(tokenId > 0 && tokenId < 7778, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
    
    function ownerClaim(uint256 tokenId) public nonReentrant onlyOwner {
        require(tokenId > 7777 && tokenId < 8001, "Token ID invalid");
        _safeMint(owner(), tokenId);
    }
    
    function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT license
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
    
    constructor(address targetContract_) ERC721("AnimeLootPhysicalCharacteristics", "AnimeLootPhysicalCharacteristics") Ownable() ERC721Holdable(targetContract_) {}

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "./Base64.sol";
import "./ERC721Holdable.sol";

contract AnimeLootPhysicalCharacteristics is ERC721Holdable {

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
        return uint256(keccak256(abi.encodePacked(input)));
    }
    
    function getHeight(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "HEIGHT", height);
    }
    
    function getBodyShape(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "BODYSHAPE", bodyShape);
    }
    
    function getStrengthOfRace(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "STRENGTHOFRACE", strengthOfRace);
    }
    
    function getImpressiveColor(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "IMPRESSIVECOLOR", impressiveColor);
    }
    
    function getFacialFeature(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "FACIALFEATURE", facialFeature);
    }
    
    function getAppearanceFeature(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "APPEARANCEFEATURE", appearanceFeature);
    }
    
    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string[17] memory parts;
        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: #000000; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="#FFF100" /><text x="10" y="20" class="base">';

        parts[1] = 'AnimeLoot Physical Characteristics';

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

        string memory image = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], parts[8]));
        image = string(abi.encodePacked(image, parts[9], parts[10], parts[11], parts[12], parts[13], parts[14], parts[15], parts[16]));
        
        string[18] memory attParts;
        attParts[0] = '{"trait_type":"Height","value":"';
        attParts[1] = getHeight(tokenId);
        attParts[2] = '"},';

        attParts[3] = '{"trait_type":"Body shape","value":"';
        attParts[4] = getBodyShape(tokenId);
        attParts[5] = '"},';

        attParts[6] = '{"trait_type":"Strength of race","value":"';
        attParts[7] = getStrengthOfRace(tokenId);
        attParts[8] = '"},';

        attParts[9] = '{"trait_type":"Impressive color","value":"';
        attParts[10] = getImpressiveColor(tokenId);
        attParts[11] = '"},';

        attParts[12] = '{"trait_type":"Facial feature","value":"';
        attParts[13] = getFacialFeature(tokenId);
        attParts[14] = '"},';

        attParts[15] = '{"trait_type":"Appearance feature","value":"';
        attParts[16] = getAppearanceFeature(tokenId);
        attParts[17] = '"}';

        string memory attOutput = string(abi.encodePacked(attParts[0], attParts[1], attParts[2], attParts[3], attParts[4], attParts[5], attParts[6]));
        attOutput = string(abi.encodePacked(attOutput, attParts[7], attParts[8], attParts[9], attParts[10], attParts[11], attParts[12]));
        attOutput = string(abi.encodePacked(attOutput, attParts[13], attParts[14], attParts[15], attParts[16], attParts[17]));
        
        string memory json = Base64.encode(bytes(string(abi.encodePacked(
                '{"name": "Anime Character Physical Characteristics #', toString(tokenId), '",',
                '"description": "AnimeLoot Physical Characteristics is randomized anime characters physical characteristics generated and stored on chain. Other features of the characters are intentionally omitted for others to interpret. Feel free to use AnimeLoot Physical Characteristics in any way you want.",',
                '"image": "data:image/svg+xml;base64,', Base64.encode(bytes(image)), '",',
                '"attributes": [', attOutput, ']',
                '}'))));

        string memory output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;
    }

    function claim(uint256 tokenId) public override nonReentrant onlyHolder(tokenId) payable {
        require(tokenId > 0 && tokenId < 8001, "Token ID invalid. out of range");
        require(!_exists(tokenId), "Token ID invalid. Already claimed");
        require(ERC721Holdable.mintPrice <= msg.value, "Value sent is not correct");
        _safeMint(_msgSender(), tokenId);
    }
    
    function ownerClaim(uint256 tokenId) public nonReentrant onlyOwner payable {
        require(tokenId > 8000 && tokenId < 8334, "Token ID invalid");
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
    
    constructor(address targetContract_) ERC721Holdable("ReplicaAnimeLootPhysicalCharacteristics", "ReplicaAnimeLootPC", targetContract_) {}

}

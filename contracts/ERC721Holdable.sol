// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev Contract module which provides a 'only holder' mechanism, where
 * there is an account (an tokenId holder) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the contract address will be the one that deploys the contract. This
 * can later be changed with {changeTargetContract}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyHolder`, which can be applied to your functions to restrict their use to
 * the holder.
 */
abstract contract ERC721Holdable is ERC721Enumerable, Ownable {
    address private _targetContract;

    event TargetContractTransferred(address indexed previousContract, address indexed newContract);

    /**
     * @dev Initializes the contract setting.
     */
    constructor(address targetContract_) {
        _targetContract = targetContract_;
    }

    /**
     * @dev Returns the address of the target contract.
     */
    function getTargetContract() public view virtual returns (address) {
        return _targetContract;
    }

    /**
     * @dev Throws if called by any account other than the holder.
     */
    modifier onlyHolder(uint256 tokenId) {
        require(ERC721.ownerOf(tokenId) == _msgSender(), "Holdable: caller is not the holder");
        _;
    }

    /**
     * @dev Change target contract.
     * Can only be called by the current owner.
     */
    function changeTargetContract(address newTargetContract) public virtual onlyOwner {
        // allow zero address
        // require(newTargetContract != address(0), "Holdable: new target contract is the zero address");
        address oldTargetContract = _targetContract;
        _targetContract = newTargetContract;
        emit TargetContractTransferred(oldTargetContract, newTargetContract);
    }
}
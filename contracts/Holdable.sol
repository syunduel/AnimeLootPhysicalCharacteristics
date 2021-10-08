// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Holdable is Ownable {
    address private _targetContract;

    event TargetContractTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor(address targetContract) {
        _targetContract = targetContract;
    }

    /**
     * @dev Returns the address of the target current.
     */
    function getTargetContract() public view virtual returns (address) {
        return _targetContract;
    }

    /**
     * @dev Throws if called by any account other than the holder.
     */
    modifier onlyHolder(uint256 tokenId) {
        // TODO check msg.sender hold target contract tokenId
        // require(owner() == _msgSender(), "Ownable: caller is not the owner");
        require(true, "Holdable: caller is not the holder");
        _;
    }

    /**
     * @dev Change target contract.
     * Can only be called by the current owner.
     */
    function changeTargetContract(address newTargetContract) public virtual onlyOwner {
        require(newTargetContract != address(0), "Holdable: new target contract is the zero address");
        address oldTargetContract = _targetContract;
        _targetContract = newTargetContract;
        emit TargetContractTransferred(oldTargetContract, newTargetContract);
    }
}
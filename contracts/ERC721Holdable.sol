// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
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
abstract contract ERC721Holdable is ERC721Enumerable, Ownable, ReentrancyGuard {
    IERC721Enumerable public _targetContract;

    event TargetContractTransferred(address indexed previousContract, address indexed newContract);

    /**
     * @dev Initializes the contract setting.
     */
    constructor(string memory name_, string memory symbol_, address targetContractAddress_) ERC721(name_, symbol_) {
        _targetContract = IERC721Enumerable(targetContractAddress_);
    }

    /**
     * @dev Returns the address of the target contract.
     */
    function getTargetContract() public view virtual returns (address) {
        return address(_targetContract);
    }

    /**
     * @dev Throws if called by any account other than the holder.
     */
    modifier onlyHolder(uint256 tokenId) {
        require(_targetContract.ownerOf(tokenId) == _msgSender(), "Holdable: caller is not the holder");
        _;
    }

    /**
     * @dev claim. should be only holder. you should override and add/modify require.
     */
    function claim(uint256 tokenId) public virtual;

    /**
     * @dev claim all _msgSender can claim. Throws if there is no tokenId that can be claimed.
     */
    function claimAll() public virtual {

        uint256 count = _targetContract.balanceOf(_msgSender());
        require(count > 0, "Holdable: There is no tokenid that can be claimed");

        uint256 claimed = 0;
        for (uint256 i = 0; i < count; i++) {
            uint256 nowTokenId = _targetContract.tokenOfOwnerByIndex(_msgSender(), i);
            if (!_exists(nowTokenId)) {
                claim(nowTokenId);
                claimed++;
            }
        }

        require(claimed > 0, "Holdable: There is no tokenid that can be claimed");
    }

    /**
     * @dev Change target contract.
     * Can only be called by the current owner.
     */
    function changeTargetContract(address newTargetContract) public virtual onlyOwner {
        // allow zero address
        // require(newTargetContract != address(0), "Holdable: new target contract is the zero address");
        IERC721Enumerable oldTargetContract = _targetContract;
        _targetContract = IERC721Enumerable(newTargetContract);
        emit TargetContractTransferred(address(oldTargetContract), address(newTargetContract));
    }
}
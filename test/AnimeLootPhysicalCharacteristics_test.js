// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "./../contracts/AnimeLoot.sol";
import "./../contracts/AnimeLootPhysicalCharacteristics.sol";

contract MyALPCTest {
    AnimeLoot al;
    AnimeLootPhysicalCharacteristics alpc;
    
    // beforeEach works before running each test
    function beforeEach() public {
        al = new AnimeLoot();
        alpc = new AnimeLootPhysicalCharacteristics(address(al));
    }
}
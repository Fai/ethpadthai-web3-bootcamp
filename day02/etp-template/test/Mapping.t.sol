// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Mapping} from "../src/Mapping.sol";

contract MappingTest is Test { // --- inherit from Test
    Mapping map; // type contract
    function setUp() public {
        map = new Mapping();
    }

    function test_Mapping() public {
        map.set("abc", 10);
        console.log("Map get abc", map.get("abc"));
        // console.log(map.get("abc"));
        assertEq(map.get("abc"), 10, "abc != 10"); // --- more information return than assert by Solidity, from foundry, need to inherit Test
        // assert(map.get("abc") == 10); 
    }
}
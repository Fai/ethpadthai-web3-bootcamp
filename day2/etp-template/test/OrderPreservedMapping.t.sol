// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/OrderPreservedMapping.sol";

contract MappingTest is Test {
    using OrderPreservedMapping for OrderPreservedMapping.Map;

    OrderPreservedMapping.Map map;

    function test_OrderedMap() public {
        map.set("", 10);
        assertEq(map.get(""), 10, "Invalid getValue ''");

        map.set("a", 20);
        assertEq(map.get("a"), 20, "Invalid getValue 'a'");

        map.set("b", 30);
        assertEq(map.get("b"), 30, "Invalid getValue 'b'");

        uint256[] memory values = map.listValues();
        assertEq(values.length, 3, "Invalid values length");
        assertEq(values.length, map.size(), "Invalid size");

        assertEq(values[0], 10, "Invalid values[0]");
        assertEq(values[1], 20, "Invalid values[1]");
        assertEq(values[2], 30, "Invalid values[2]");

        map.set("a", 40);

        uint256[] memory newValues = map.listValues();
        assertEq(newValues.length, 3, "Invalid newValues length");
        assertEq(newValues.length, map.size(), "Invalid size");

        assertEq(newValues[0], 10, "Invalid newValues[0]");
        assertEq(newValues[1], 40, "Invalid newValues[1]");
        assertEq(newValues[2], 30, "Invalid newValues[2]");

        map.set("aa", 2);

        uint256[] memory newValues2 = map.listValues();
        assertEq(newValues2.length, 4, "Invalid newValues2 length");
        assertEq(newValues2.length, map.size(), "Invalid size");

        assertEq(newValues2[0], 10, "Invalid newValues2[0]");
        assertEq(newValues2[1], 40, "Invalid newValues2[1]");
        assertEq(newValues2[2], 30, "Invalid newValues2[2]");
        assertEq(newValues2[3], 2, "Invalid newValues2[3]");
    }
}

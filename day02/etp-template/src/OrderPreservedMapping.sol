// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library OrderPreservedMapping {
    // a map type
    struct Map {
        string[] keys;
        mapping(string => uint256) values;
        mapping(string => bool) exists;
    }

    // get a value from the map
    function get(
        Map storage map,
        string memory key
    ) public view returns (uint256) {
        return map.values[key];
    }

    // list all values in the map ordered by insertion
    function listValues(
        Map storage map
    ) public view returns (uint256[] memory values) {
        for (uint i = 0; i < map.keys.length; i++) {
            values[i] = map.values[map.keys[i]];
        }
    }

    // set a value in the map
    function set(
        Map storage map, // in this line, Map storage map is like __self__ in other languages
        string memory key,
        uint256 val
    ) public {
        if (map.exists[key] == false) {
            map.keys.push(key);
            map.exists[key] = true;
        }
        map.values[key] = val;
    }

    function size(
        Map storage map
    ) public view returns (uint256) {
        return map.keys.length;
    }
}

contract UseOrderPreservedMapping {
    using OrderPreservedMapping for OrderPreservedMapping.Map; // --- using library
    OrderPreservedMapping.Map map;
    // --- can also rewrite as
    // using OrderPreservedMapping for Map;
    // Map map;

    function setValue(string memory key, uint256 value) public {
        map.set(key, value);
    }

    function getValue(string memory key) public view returns (uint256) {
        return map.get(key);
    }
}

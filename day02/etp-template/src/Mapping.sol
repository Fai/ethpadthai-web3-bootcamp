// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13; // ---- smart contract version

contract Mapping {
    mapping(string => uint256) private map; // --- state variable, always exists in storage ate EVM

    function get(string memory key) public view returns (uint256 value) { // only ref var use memory
        value = map[key]; // --- return map[key];
    }

    function set(string memory key, uint256 value) public {
        map[key] = value;
    }
}

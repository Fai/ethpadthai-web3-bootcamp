// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IPalindromeChecker {
    function isPalindrome(string memory) external returns (bool);
}

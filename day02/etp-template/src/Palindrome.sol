// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {IPalindromeChecker} from "./interfaces/IPalindromeChecker.sol";
contract Palindrome is IPalindromeChecker {
    function isPalindrome(string memory str) public pure returns (bool) {
        bytes memory bstr = bytes(str);
        uint len = bstr.length;
        for (uint i = 0; i < len / 2; i++) {
            if (bstr[i] != bstr[len - i - 1]) {
                return false;
            }
        }
        return true;
    }
}

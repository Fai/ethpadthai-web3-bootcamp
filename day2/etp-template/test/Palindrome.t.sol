pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {IPalindromeChecker} from "../src/interfaces/IPalindromeChecker.sol";

contract PalindromeTest is Test {
    IPalindromeChecker checker;

    function setUp() public {}

    function test_CheckSimplePalindrome() public {
        assert(checker.isPalindrome("aa"));
        assert(checker.isPalindrome("b"));
        assert(checker.isPalindrome(""));
        assert(checker.isPalindrome("racerac"));
        assert(checker.isPalindrome("hello") == false);
        assert(checker.isPalindrome("level"));
        assert(checker.isPalindrome("abcba"));
        // Thanks for dapp world for test cases and problem
        assert(checker.isPalindrome("dappworld") == false);
        assert(checker.isPalindrome("contest") == false);
    }

    function test_CheckNotSimplePalidrome() public {
        assert(checker.isPalindrome("Aa"));
        assert(checker.isPalindrome("bA") == false);
        assert(checker.isPalindrome("madaMAdam"));
    }

    function test_CheckWildPalindrome() public {
        assert(checker.isPalindrome("A man a plan a canal Panama"));
        assert(checker.isPalindrome("madam, in Eden, I'm Adam"));
        assert(checker.isPalindrome("A Toyota's a Toyota."));
    }
}

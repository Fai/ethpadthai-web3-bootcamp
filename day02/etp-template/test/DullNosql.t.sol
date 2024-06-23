// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DullNoSql} from "../src/DullNoSql.sol";

contract DullNoSqlTest is Test {
    DullNoSql nosql;

    function setUp() public {
        nosql = new DullNoSql();
    }

    function test_AddDocument() public {
        uint doc1Index = nosql.addDocument("abc", 0, "key1", 10);
        assertEq(
            nosql.addDocument("abc", doc1Index, "key2", 50),
            doc1Index,
            "Invalid edit document return value, should return same as input index"
        );
        assertEq(
            nosql.getDocumentValue("abc", doc1Index, "key1"),
            10,
            "Invalid key1 value"
        );
        assertEq(
            nosql.getDocumentValue("abc", doc1Index, "key2"),
            50,
            "Invalid key2 value"
        );

        uint doc2Index = nosql.addDocument("abc", 0, "key1", 20);
        assertEq(
            doc2Index,
            doc1Index + 1,
            "Document index should be incremented by 1"
        );

        uint doc3Index = nosql.addDocument("abc", 0, "key2", 30);
        assertEq(
            doc3Index,
            doc2Index + 1,
            "Document index should be incremented by 1"
        );

        uint[] memory values = nosql.getDocumentValues("abc", "key1");
        assertEq(values.length, 2, "Invalid values length");
        assertEq(values[0], 10, "Invalid values[0]");
        assertEq(values[1], 20, "Invalid values[1]");

        uint[] memory values2 = nosql.getDocumentValues("abc", "key2");
        assertEq(values2.length, 2, "Invalid values2 length");
        assertEq(values2[0], 50, "Invalid values2[0]");
        assertEq(values2[1], 30, "Invalid values2[1]");
    }

    function test_UpdateDocumentValues() public {
        nosql.addDocument("abc", 0, "key1", 10);
        nosql.addDocument("abc", 0, "key1", 20);
        nosql.addDocument("abc", 0, "key2", 30);
        nosql.addDocument("abc", 0, "key1", 40);
        nosql.addDocument("abc", 0, "key2", 50);

        uint[] memory values = nosql.getDocumentValues("abc", "key1");
        assertEq(values.length, 3, "Invalid values length");
        assertEq(values[0], 10, "Invalid values[0]");
        assertEq(values[1], 20, "Invalid values[1]");
        assertEq(values[2], 40, "Invalid values[2]");

        uint[] memory values2 = nosql.getDocumentValues("abc", "key2");
        assertEq(values2.length, 2, "Invalid values2 length");
        assertEq(values2[0], 30, "Invalid values2[0]");
        assertEq(values2[1], 50, "Invalid values2[1]");

        assertEq(
            nosql.updateDocumentValues("abc", "key1", 100),
            true,
            "Key1 should be updated and return true"
        );
        uint[] memory values3 = nosql.getDocumentValues("abc", "key1");
        assertEq(values3.length, 3, "Invalid values3 length");
        assertEq(values3[0], 100, "Invalid values3[0]");
        assertEq(values3[1], 100, "Invalid values3[1]");
        assertEq(values3[2], 100, "Invalid values3[2]");

        assertEq(
            nosql.updateDocumentValues("abc", "key3", 100),
            false,
            "Key3 should not be updated and return false"
        );
        uint[] memory values4 = nosql.getDocumentValues("abc", "key3");
        assertEq(values4.length, 0, "Invalid values4 length");
    }

    function test_DeleteDocumentKeys() public {
        nosql.addDocument("abc", 0, "key1", 10);
        nosql.addDocument("abc", 0, "key1", 20);
        nosql.addDocument("abc", 0, "key2", 30);
        nosql.addDocument("abc", 0, "key1", 40);
        nosql.addDocument("abc", 0, "key2", 50);

        assertEq(
            nosql.deleteDocumentKeys("abc", "key1"),
            true,
            "Key1 should be deleted and should return true"
        );
        uint[] memory values3 = nosql.getDocumentValues("abc", "key1");
        assertEq(values3.length, 0, "Invalid values3 length");

        assertEq(
            nosql.deleteDocumentKeys("abc", "key1"),
            false,
            "Key1 is already deleted and should return false"
        );

        assertEq(
            nosql.deleteDocumentKeys("abc", "key3"),
            false,
            "Key3 should not be deleted and should return false"
        );
        uint[] memory values4 = nosql.getDocumentValues("abc", "key3");
        assertEq(values4.length, 0, "Invalid values4 length");
    }
}

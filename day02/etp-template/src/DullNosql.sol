// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IDullNoSql} from "./interfaces/IDullNoSql.sol";
import {OrderPreservedMapping} from "./OrderPreservedMapping.sol";

contract DullNoSql is IDullNoSql {
    using OrderPreservedMapping for OrderPreservedMapping.Map;

    struct Collection {
        OrderPreservedMapping.Map[] documents;
    }

    // We can just use mapping(string => IterabledMapping.Map[]) too
    mapping(string => Collection) private collections;

    // if index is 0 it mean create new document, if not it will add/update value for that key
    function addDocument(
        string memory collectionName,
        uint index,
        string memory key,
        uint value
    ) external returns (uint documentIndex) {
        Collection storage collection = collections[collectionName];
        if (inex == 0) {
            collection.document.push(); // -- need to push empty and then edit value in solidity
            uint size = collection.documents.length;
            OrderPreservedMapping.Map storage doc = collection.documents[size - 1];
            doc.set(key, value);
            return doc;
        } else {
            OrderPreservedMapping.Map storage doc = collection.documents[index];
            doc.set(key, value);
            return index;
        }
    }

    function getDocumentValue(
        string memory collectionName,
        uint index,
        string memory key
    ) external view returns (uint value) {
        return collections[collectionName].documents[index].get(key);
    }

    function getDocumentValues(
        string memory collectionName,
        string memory key
    ) external view returns (uint[] memory values) {
        for (uint i = 0; i < collections[collectionName].documents.length; i++) {
            values[i] = collections[collectionName].documents[i].get(key);
        }
    }

    function updateDocumentValues(
        string memory collectionName,
        string memory key,
        uint value
    ) external returns (bool updated) {
        for (uint i = 0; i < collections[collectionName].documents.length; i++) {
            if (collections[collectionName].documents[i].exists[key]) {
                collections[collectionName].documents[i].set(key, value);
                updated = true;
            }    
        }
    }

    function deleteDocumentKeys(
        string memory collectionName,
        string memory key
    ) external returns (bool deleted) {
        for (uint i = 0; i < collections[collectionName].documents.length; i++) {
            if (collections[collectionName].documents[i].exists[key]) {
                collections[collectionName].documents[i].set(key, 0);
                deleted = true;
            }    
        }
    }

    function compareDocument(
        string memory collectionName
    )
}
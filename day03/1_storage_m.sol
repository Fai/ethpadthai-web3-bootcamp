// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
import "hardhat/console.sol";

struct JustStruct {
    uint256 num;
    bool isTrue;
}

contract Storage {
    // JustStruct[] simple;
    mapping(uint256 => JustStruct) simple;
    uint256 size;

    function store(uint256 num, bool isTrue) public {
        simple[size] = JustStruct(num, isTrue);
        size++;
    }

    function read() public view returns (JustStruct[] memory) {
        JustStruct[] memory result = new JustStruct[](size);
        for(uint i=0; i < size; i++) {
            result[i] = simple[i];
        }
        return result;
    }

    function updateStruct(uint256 i, uint256 num, bool isTrue) public {
        JustStruct storage js = simple[i];
        js.num = num;
        js.isTrue = isTrue;
    }

    function removeStruct(uint256 i) public {
        simple[i] = simple[size];
        delete simple[size];
        size--;
    }
}
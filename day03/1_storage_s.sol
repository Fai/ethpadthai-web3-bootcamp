// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
import "hardhat/console.sol";

struct JustStruct {
    uint256 num;
    bool isTrue;
}

contract Storage {
    JustStruct[] simple;

    function store(uint256 num, bool isTrue) public {
        simple.push(JustStruct(num, isTrue));
        console.log("--Add--");
        console.log(isTrue);

        for(uint i = 0; i < simple.length; i++) {
            console.log("--Total--");
            console.log(simple[i].num);
            console.log(simple[i].isTrue);
        }
    }

    function read() public view returns (JustStruct[] memory) {
        return simple;
    }

    function updateStruct(uint256 i, uint256 num, bool isTrue) public {
        JustStruct storage js = simple[i];
        js.num = num;
        js.isTrue = isTrue;
    }

    function removeStruct(uint256 i) public {
        simple[i] = simple[simple.length-1];
        simple.pop();
    }
}
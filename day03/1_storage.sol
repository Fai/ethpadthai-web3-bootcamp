// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Storage {
    uint256 number;

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public { // 22k gas
        number = num;
    }

    /**
     * @dev Return value
     * @return value of number
     */
    function retrieve() public view returns (uint256){ // 2k gas
        return number;
    }

    function mathresult() public pure returns (uint256){ // 0.3 gas
        return 0;
    }
}
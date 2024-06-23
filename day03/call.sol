pragma solidity <0.9.0;

contract Callee {
    uint public x;
    uint public value;

    function setX(uint _x) public {
        x = _x;
    }

    function setXandSendEther(uint _x) public payable {
        x = _x;
        value = msg.value;
    }
}

contract Caller {
    Callee callee;

    constructor(address _colleeaddress) {
        callee = Callee(_colleeaddress);
    }

    function callSetX(uint _x) public {
        callee.setX(_x);
    }

    function calleeSetXAndSendEther(uint _x) public payable {
        callee.setXandSendEther{value: msg.value}(_x);
    }
}
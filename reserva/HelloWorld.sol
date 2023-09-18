pragma solidity >=0.4.22 <0.7.0;

contract HelloWorld {
    string public message = "Hello World!";

    function helloWorld() public view returns (string) {
        return message;
    }
}
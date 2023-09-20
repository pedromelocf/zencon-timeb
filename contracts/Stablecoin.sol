// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Stablecoin is ERC20 {
    constructor() ERC20("Stablecoin", "USD") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    function _approveContract(address sender, address spender, uint256 amount) external returns (bool) {
        _approve(sender, spender, amount);

        return true;
    }
}
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Interface ERC20 padrão
interface ERC20Token {
    function transfer(address to, uint256 value) external returns (bool);
    function balanceOf(address owner) external view returns (uint256);
}

contract FreelanceContract {
    ERC20Token public tokenContract;
    bool public projectDelivered;
    bool public clientAcceptedDelivery;
    uint256 public deliveryDeadline;
    uint256 public closedValue;

	mapping(address => mapping(address => uint256)) public tokensToTransfer;

    address public client;
    address public developer;

    constructor(address _tokenContract) {
        tokenContract = ERC20Token(_tokenContract);
        clientAcceptedDelivery = false;
        projectDelivered = false;
    }

    event ProjectDelivered();
    event RefundRequested();

    function newTransaction(address _developer, uint256 amount, uint256 deliveryDays) public {
        require(amount > 0, "Amount should be greater than 0");
        require(deliveryDays > 0, "Delivery days should be greater than 0");

        tokensToTransfer[client][_developer] = amount;
        deliveryDeadline = block.timestamp + (deliveryDays * 1 days);
    }

    function setDeliveryDays(uint256 _deliveryDays) internal {
        deliveryDeadline = block.timestamp + (_deliveryDays * 1 days);
    }

    function markProjectDelivered() public {
        require(block.timestamp <= deliveryDeadline, "Delivery deadline has passed");
        projectDelivered = true;
        emit ProjectDelivered();
    }

    function markClientReceive() public {
        require(projectDelivered, "Project must be delivered first");
        clientAcceptedDelivery = true;
    }

    function transferFundsAfterDelivery() public {
        require(projectDelivered, "Project must be delivered first");
        require(clientAcceptedDelivery, "Client must accept project delivery");
        uint256 amount = tokensToTransfer[client][developer];
        require(amount > 0, "No tokens to transfer for the specified developer");

        require(tokenContract.balanceOf(client) >= amount, "Insufficient balance for the client");
        require(tokenContract.transfer(developer, amount), "Token transfer failed");

        tokensToTransfer[client][developer] = 0;
    }

    function requestRefund() public {
        require(!projectDelivered && block.timestamp > deliveryDeadline, "Project has been delivered or deadline not passed");

        // Refund the client
        require(tokenContract.balanceOf(address(this)) >= closedValue, "Insufficient contract balance");
        tokenContract.transfer(client, closedValue);
        closedValue = 0;

        emit RefundRequested();
    }
}

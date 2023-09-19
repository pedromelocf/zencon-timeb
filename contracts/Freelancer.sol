// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract FreelanceContract {
    address payable public developer;
    address payable public client;
    uint256 public closed_value;
    bool public clientAccepted;
    bool public developerAccepted;
    bool public contractAccepted;
    bool public projectDelivered;
    bool public clientAcceptedDelivery;
    uint256 public deliveryDeadline;
    uint256 _deliveryDays = 30;

    // Event emitted when both parties accept the contract
    event ContractAccepted();

    // Event emitted when the project is delivered
    event ProjectDelivered();

    // Event emitted when the client accepts the project delivery
    event ClientAcceptedDelivery();

    // Constructor to initialize the contract
    constructor(
        address payable _client,
        address payable _developer,
        uint256 _closed_value
    ) {
        developer = _developer;
        client = _client;
        closed_value = _closed_value;
        deliveryDeadline = block.timestamp + (_deliveryDays * 1 days);
        clientAccepted = false;
        developerAccepted = false;
        contractAccepted = false;
        projectDelivered = false;
        clientAcceptedDelivery = false;
    }

    // Function for the client to accept the contract
    function acceptContractByClient() public {
        require(msg.sender == client, "Only the client can accept the contract");
        clientAccepted = true;
        checkContractAccepted();
    }

    // Function for the developer to accept the contract
    function acceptContractByDeveloper() public {
        require(msg.sender == developer, "Only the developer can accept the contract");
        developerAccepted = true;
        checkContractAccepted();
    }

    // Check if both parties have accepted the contract
    function checkContractAccepted() internal {
        if (clientAccepted && developerAccepted) {
            contractAccepted = true;
            emit ContractAccepted();
        }
    }

    // Function for the developer to mark the project as delivered
    function markProjectDelivered() public {
        require(msg.sender == developer, "Only the developer can mark the project as delivered");
        require(block.timestamp <= deliveryDeadline, "Delivery deadline has passed");
        projectDelivered = true;
        emit ProjectDelivered();
    }

    // Function for the client to accept the project delivery
    function acceptProjectDeliveryByClient() public {
        require(msg.sender == client, "Only the client can accept project delivery");
        require(projectDelivered, "Project must be delivered first");
        clientAcceptedDelivery = true;
        emit ClientAcceptedDelivery();
    }

    // Function to transfer funds to the developer after project delivery
    function transferFundsAfterDelivery() public {
        require(projectDelivered, "Project must be delivered first");
        require(clientAcceptedDelivery, "Client must accept project delivery");
        require(msg.sender == developer, "Only the developer can initiate fund transfer");

        // fee per transacion

        (bool success, ) = developer.call{value: closed_value}("");
        require(success, "Transfer failed.");
        closed_value = 0;
    }

    // Function to request a refund from the client if the project is not delivered on time
    function requestRefund() public {
        require(msg.sender == client, "Only the client can request a refund");
        require(!projectDelivered && block.timestamp > deliveryDeadline, "Project has been delivered or deadline not passed");
        
        // Provides refund to the customer
        client.transfer(closed_value);
    }
}


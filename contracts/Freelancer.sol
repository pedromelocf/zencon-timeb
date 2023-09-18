pragma solidity >=0.4.22 <0.7.0;

contract FreelanceContract {
    address payable public developer;
    address payable public client;
    uint256 public value;
    bool public clientAccepted;
    bool public developerAccepted;
    bool public contractAccepted;
    bool public projectDelivered;
    bool public clientAcceptedDelivery;
    uint256 public deliveryDeadline;

    // Event emitted when both parties accept the contract
    event ContractAccepted();

    // Event emitted when the project is delivered
    event ProjectDelivered();

    // Event emitted when the client accepts the project delivery
    event ClientAcceptedDelivery();

    // Constructor to initialize the contract
    constructor(
        address _client,
        address _developer,
        uint256 _value,
        uint256 _deliveryDays
    ) public {
        developer = address(uint160(_developer));
        client = address(uint160(_client));
        value = _value;
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
        require(address(this).balance >= value, "Insufficient contract balance");

        // fee per transacion
        address payable fee = address(uint160(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4));
        fee.transfer(value * 0.05);

        bool success = developer.send(value * 0.95);
        require(success, "Fund transfer failed");
    }

    // Function to request a refund from the client if the project is not delivered on time
    function requestRefund() public {
    require(msg.sender == client, "Only the client can request a refund");
    require(!projectDelivered && block.timestamp > deliveryDeadline, "Project has been delivered or deadline not passed");
    
    // Provides refund to the customer
    address payable payableClient = payable(client);
    payableClient.transfer(value);
    }
}


//
//    function startProject() public {
//        // Implement project start actions
//    }
//
//    function developerObligations() public {
//        // Implement developer obligations
//    }
//
//    function payment() public {
//        // Implement payment functionality
//    }
//
//    function informAdjustments() public {
//        // Implement informing adjustments
//    }
//
//    function terminateContract() public {
//        // Implement termination of the contract
//    }
//}
//
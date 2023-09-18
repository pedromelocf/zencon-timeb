pragma solidity >=0.4.22 <0.7.0;

contract FreelanceContract {
    address payable public developer;
    address payable public client;
    uint256 public value;
    bool public clientAccepted;
    bool public developerAccepted;
    bool public contractAccepted;
    bool public projectDelivered;

    // Event emitted when both parties accept the contract
    event ContractAccepted();

    // Event emitted when the project is delivered
    event ProjectDelivered();

    // Constructor to initialize the contract
    constructor(
        address _client,
        address _developer,
        uint256 _value
    ) public {
        developer = address(uint160(_developer));
        client = address(uint160(_client));
        value = _value;
        clientAccepted = false;
        developerAccepted = false;
        contractAccepted = false;
        projectDelivered = false;
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
        projectDelivered = true;
        emit ProjectDelivered();
    }

    // Function to transfer funds to the developer after project delivery
    function transferFundsAfterDelivery() public {
        require(projectDelivered, "Project must be delivered first");
        require(msg.sender == developer, "Only the developer can initiate fund transfer");
        require(address(this).balance >= value, "Insufficient contract balance");

        bool success = developer.send(value);
        require(success, "Fund transfer failed");
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
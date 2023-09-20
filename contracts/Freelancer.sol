// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

// Interface ERC20 padrão
interface ERC20Token {
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address owner) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function _approveContract(address sender, address spender, uint256 amount) external returns(bool);
}


contract FreelanceContract {
    ERC20Token public tokenContract;
    bool public projectDelivered;
    bool public clientAcceptedDelivery;
    uint256 public deliveryDeadline;

	mapping(address => mapping(address => uint256)) internal tokensToTransfer;

    address public client;
    address public developer;
    address public tokenAddress;

    constructor(address _tokenContract) {
        tokenContract = ERC20Token(_tokenContract);
        clientAcceptedDelivery = false;
        projectDelivered = false;
    }

    event ProjectDelivered();
    event RefundRequested();

    // modifica quem pode interagir com a função
    modifier onlyClient() {
        require(msg.sender == client, "Only the client can call this function");
        _;
    }

    // modifica quem pode interagir com a função
    modifier onlyDeveloper() {
        require(msg.sender == developer, "Only the developer can call this function");
        _;
    }

    // botao - cria uma novo acordo com aos especificacoes do contrato entre as partes 
    function newDeal(address _developer, uint256 amount, uint256 deliveryDays) public {
        require(amount > 0, "Amount should be greater than 0");
        require(deliveryDays > 0, "Delivery days should be greater than 0");

        developer = _developer;
        client = msg.sender;

        // approve transition
        require(tokenContract._approveContract(client, address(this), amount), "Approval failed");

        // transfer to contract
        require(tokenContract.transferFrom(client, address(this), amount), "Token transfer to contract failed");
        
        tokensToTransfer[client][_developer] = amount;
        deliveryDeadline = block.timestamp + (deliveryDays * 1 days);
    }

    // botao - marca a entrega do projeto
    function markProjectDelivered() public onlyDeveloper {
        require(block.timestamp <= deliveryDeadline, "Delivery deadline has passed");
        projectDelivered = true;
        emit ProjectDelivered();
    }

    // botao - marca que o cliente recebeu
    function markClientReceive() public onlyClient {
        require(projectDelivered, "Project must be delivered first");
        clientAcceptedDelivery = true;
    }

    // botao - desenvolvedor receber a grana apos o contrato ser entregue
    function transferFundsAfterDelivery() public onlyDeveloper {
        require(projectDelivered, "Project must be delivered first");
        require(clientAcceptedDelivery, "Client must accept project delivery");
        uint256 amount = tokensToTransfer[client][developer];
        require(amount > 0, "No tokens to transfer for the specified developer");

        require(tokenContract.transfer(developer, amount), "Token transfer failed");

        tokensToTransfer[client][developer] = 0;
    }

    // botao - client pode pedir a grana de volta caso o periodo de entrega esteja vencido e o contrato nao foi entregue
    function requestRefund() public onlyClient {
        require(!projectDelivered && block.timestamp > deliveryDeadline, "Project has been delivered or deadline not passed");

        // Refund the client
        require(tokensToTransfer[client][developer] >= 0, "Insufficient contract balance");

        uint256 amount = tokensToTransfer[client][developer];
        tokenContract.transfer(client, amount);
        tokensToTransfer[client][developer] = 0;

        emit RefundRequested();
    }

}

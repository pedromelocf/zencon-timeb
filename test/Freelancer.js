const FreelanceContract = artifacts.require("FreelanceContract");

contract("FreelanceContract", (accounts) => {
    let freelanceContract;
    const client = accounts[1];
    const developer = accounts[2];
    const value = web3.utils.toWei("1", "ether");
    
    beforeEach(async () => {
        freelanceContract = await FreelanceContract.new(client, developer, value);
    });

    it("should allow client and developer to accept the contract", async () => {
        await freelanceContract.acceptContractByClient({ from: client });
        await freelanceContract.acceptContractByDeveloper({ from: developer });

        const contractAccepted = await freelanceContract.contractAccepted();
        assert.isTrue(contractAccepted, "Contract should be accepted by both parties");
    });

    it("should allow developer to mark the project as delivered", async () => {
        await freelanceContract.acceptContractByClient({ from: client });
        await freelanceContract.acceptContractByDeveloper({ from: developer });

        await freelanceContract.markProjectDelivered({ from: developer });
        const projectDelivered = await freelanceContract.projectDelivered();
        assert.isTrue(projectDelivered, "Project should be marked as delivered");
    });

    it("should allow client to accept project delivery", async () => {
        await freelanceContract.acceptContractByClient({ from: client });
        await freelanceContract.acceptContractByDeveloper({ from: developer });

        await freelanceContract.markProjectDelivered({ from: developer });

        // Check project delivered and client not yet accepted delivery
        let projectDelivered = await freelanceContract.projectDelivered();
        let clientAcceptedDelivery = await freelanceContract.clientAcceptedDelivery();
        assert.isTrue(projectDelivered, "Project should be marked as delivered");
        assert.isFalse(clientAcceptedDelivery, "Client should not have accepted the delivery yet");

        // Client accepts project delivery
        await freelanceContract.acceptProjectDeliveryByClient({ from: client });

        // Check if client accepted the delivery
        clientAcceptedDelivery = await freelanceContract.clientAcceptedDelivery();
        assert.isTrue(clientAcceptedDelivery, "Client should have accepted the delivery");
    });

    it('should transfer funds to the developer after project delivery', async () => {
        // Aceitar o contrato por ambas as partes
        await freelanceContract.acceptContractByClient({ from: client });
        await freelanceContract.acceptContractByDeveloper({ from: developer });

        // Marcar o projeto como entregue
        await freelanceContract.markProjectDelivered({ from: developer });

        // Aceitar a entrega do projeto pelo cliente
        await freelanceContract.acceptProjectDeliveryByClient({ from: client });

        const initialDeveloperBalance = await web3.eth.getBalance(developer);
        await freelanceContract.transferFundsAfterDelivery({ from: developer });
        const updatedDeveloperBalance = await web3.eth.getBalance(developer);

        // Verificar se os fundos foram transferidos corretamente
        assert.isAbove(updatedDeveloperBalance - initialDeveloperBalance, 0);
    });
});

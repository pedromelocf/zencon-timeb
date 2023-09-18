const FreelanceContract = artifacts.require("FreelanceContract");

contract("FreelanceContract", (accounts) => {
    let freelanceContract;
    const client = accounts[1];
    const developer = accounts[2];
    const value = web3.utils.toWei("1", "ether"); // Convertendo 1 ether para wei

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

    it("should allow transferring funds to the developer after project delivery", async () => {
        await freelanceContract.acceptContractByClient({ from: client });
        await freelanceContract.acceptContractByDeveloper({ from: developer });

        await freelanceContract.markProjectDelivered({ from: developer });
        const initialDeveloperBalance = await web3.eth.getBalance(developer);

        await freelanceContract.transferFundsAfterDelivery({ from: developer });

        const finalDeveloperBalance = await web3.eth.getBalance(developer);
        const expectedFinalBalance = new web3.utils.BN(initialDeveloperBalance).add(new web3.utils.BN(value));
        assert.isTrue(finalDeveloperBalance.gte(expectedFinalBalance), "Funds were not transferred to the developer");
    });
});

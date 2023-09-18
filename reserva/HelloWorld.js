const HelloWorld = artifacts.require("HelloWorld");

contract('HelloWorld', function() {
    beforeEach(async () => {
        contract = await HelloWorld.new();
    });
    it('HelloWorld', async () => {
        const result = await contract.helloWorld();
        assert(result === 'Hello World')
    });
});
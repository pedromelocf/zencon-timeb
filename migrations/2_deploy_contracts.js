const FreelanceContract = artifacts.require("FreelanceContract");

function generateRandomAddress() {
  const characters = '0123456789abcdef';
  let address = '0x';

  for (let i = 0; i < 40; i++) {
      const randomIndex = Math.floor(Math.random() * characters.length);
      address += characters[randomIndex];
  }
  return address;
}

module.exports = function(deployer) {
  const clientAdd = generateRandomAddress(); // Endereço do cliente
  const developerAdd = generateRandomAddress(); // Endereço do desenvolvedor
  const value = 100; // Valor do contrato

  deployer.deploy(FreelanceContract, clientAdd, developerAdd, value);
};

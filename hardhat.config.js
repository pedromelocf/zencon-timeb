require("@nomicfoundation/hardhat-toolbox");

// Agora você pode acessar as variáveis de ambiente definidas no .env
const mnemonic = "range crack silent rather comic evidence wrap carbon tower eternal push tenant";

const accounts = { mnemonic };

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    zeniq: {
      accounts,
      url: "https://smart.zeniq.network:9545",
    }
  }
}
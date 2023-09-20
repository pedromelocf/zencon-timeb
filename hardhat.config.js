require("@nomicfoundation/hardhat-toolbox");


const mnemonic = "";

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

// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const stable = await hre.ethers.getContractFactory("Stablecoin");
  const freela = await hre.ethers.getContractFactory("FreelanceContract");

  const _stable = await stable.deploy();
  //const _freela = await freela.deploy(_stable.address);

  console.log("Stablecoin deployed to:", _stable.address);
  console.log("\nstablecoin\n", _stable);
  //console.log("\nfreelancer\n", _freela);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
const FreelanceContract = artifacts.require("./FreelanceContract");

module.exports = function(deployer) {
  deployer.deploy(FreelanceContract);
};

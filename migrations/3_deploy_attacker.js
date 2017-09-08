var Attacker = artifacts.require("./Attacker.sol");

module.exports = function(deployer) {
  deployer.deploy(Attacker);
};

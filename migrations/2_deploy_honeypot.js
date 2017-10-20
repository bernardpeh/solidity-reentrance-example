var honeypot = artifacts.require("./HoneyPot.sol");

module.exports = function(deployer) {
  deployer.deploy(honeypot);
};

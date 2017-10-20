var drainHoney = artifacts.require("./DrainHoney.sol");
var honeypot = artifacts.require("./HoneyPot.sol");

honeyAddress = honeypot.deployed().address;

module.exports = function(deployer) {
  deployer.deploy(drainHoney, honeyAddress);
};

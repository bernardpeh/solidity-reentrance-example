var honeypot = artifacts.require("./HoneyPot.sol");

module.exports = function(deployer) {
  deployer.deploy(honeypot, {value: 5*Math.pow(10,18)});
};

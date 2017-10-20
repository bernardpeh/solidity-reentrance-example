var dh = artifacts.require("./DrainHoney.sol");
var hp = artifacts.require("./HoneyPot.sol");

module.exports = function(deployer) {
  deployer.deploy(dh, hp.deployed().then(ins => {return ins.address}));
};

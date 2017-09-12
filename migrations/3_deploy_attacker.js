var Attacker = artifacts.require("./Attacker.sol");
var Dao = artifacts.require("./Dao.sol");

module.exports = function(deployer) {
  deployer.deploy(Attacker, Dao.deployed().then(ins => {return ins.address}));
};

var Dao = artifacts.require("./Dao.sol");

module.exports = function(deployer) {
  deployer.deploy(Dao);
};

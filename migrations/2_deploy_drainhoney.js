var dh = artifacts.require("./DrainHoney.sol");

module.exports = function(deployer) {
  deployer.deploy(dh, "0x935212B4d15cbF496FdDbFD63821ad4e04d0777d");
};

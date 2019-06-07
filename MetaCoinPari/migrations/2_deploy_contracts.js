const ConvertLib = artifacts.require("ConvertLib");
const MetaCoin = artifacts.require("MetaCoin");
const Paris = artifacts.require("Paris");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.deploy(Paris);
  deployer.link(ConvertLib, Paris);
 // deployer.deploy(MetaCoin);


};

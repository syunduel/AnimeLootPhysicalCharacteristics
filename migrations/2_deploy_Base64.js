const Base64Contract = artifacts.require("Base64");

module.exports = function(deployer) {
    deployer.deploy(Base64Contract);
}

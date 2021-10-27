const AnimeLootContract = artifacts.require("AnimeLoot");

module.exports = function(developer) {
    developer.deploy(AnimeLootContract);
}

const ALPCContract = artifacts.require("AnimeLootPhysicalCharacteristics");

contract("ALPC", () => {
    if("has been deployed successfully", async () => {
        const alpc = await ALPCContract.deployed();
        assert(alpc, "contract was not deployed");
    });

});
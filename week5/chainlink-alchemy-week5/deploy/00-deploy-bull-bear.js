const { network } = require("hardhat")
const { networkConfig } = require("../helper-hardhat-config")

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const chainId = network.config.chainId

    log("----------------------------------------------------")
    arguments = [
        networkConfig[chainId]["interval"],
        networkConfig[chainId]["ethUsdPriceFeed"],
        networkConfig[chainId]["vrfCoordinatorV2"],
    ]
    const bullBear = await deploy("BullBear", {
        from: deployer,
        args: arguments,
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })
}

module.exports.tags = ["all", "randomipfs", "main"]

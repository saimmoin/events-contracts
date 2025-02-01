/** @format */

require("@nomiclabs/hardhat-waffle");
const { version } = require("ethers");
const { PRIVATE_KEY } = require("./env");

module.exports = {
  solidity: {
    version: "0.8.22",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    bera: {
      url: "https://bartio.rpc.berachain.com",
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: {
      berachainBartio: "berachainBartio",
    },
  },
};

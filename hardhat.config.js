/** @format */

require("@nomiclabs/hardhat-waffle");
require("@nomicfoundation/hardhat-verify");

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
    auroraTestnet: {
      url: "https://testnet.aurora.dev",
      accounts: [PRIVATE_KEY],
    },
    sepolia: {
      url: "https://eth-sepolia.public.blastapi.io",
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: "4GSI1E1IH2RGQ341M9G81ZBUIBKMSYGPZV",
  },
};

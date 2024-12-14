/** @format */

require("@nomiclabs/hardhat-waffle");
const { version } = require("ethers");
const { PRIVATE_KEY } = require("./evn");

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
    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/OVZbMpDeon6wu0xPYvGvm-t3_6jDTXjm",
      accounts: [PRIVATE_KEY],
    },
  },
};

/** @format */

require("@nomiclabs/hardhat-waffle");
const {PRIVATE_KEY } = require("./evn");

module.exports = {
  solidity: "0.8.22",
  networks: {
    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/OVZbMpDeon6wu0xPYvGvm-t3_6jDTXjm",
      accounts: [PRIVATE_KEY],
    },
  },
};

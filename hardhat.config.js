/** @format */

require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.26",
  networks: {
    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/OVZbMpDeon6wu0xPYvGvm-t3_6jDTXjm",
      accounts: ["5468c80fffe3489ec1499cf8284a3ca42f238b43f484e44a256a27fb335c2fea"],
    },
  },
};

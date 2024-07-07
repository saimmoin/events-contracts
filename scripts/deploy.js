/** @format */

const hre = require("hardhat");

async function main() {
  const ChainConnect = await hre.ethers.getContractFactory("ChainConnect");
  const chainConnect = await ChainConnect.deploy();
  await chainConnect.deployed();
  console.log("Contract Deployed To: ", chainConnect.address);
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();

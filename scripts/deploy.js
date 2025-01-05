const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  await deployAlpha(deployer.address);
  await deployEvent(deployer.address);
  await deployOracle();
}

async function deployAlpha(address) {
  const Alpha = await hre.ethers.getContractFactory("Alpha");
  const alpha = await Alpha.deploy(address);
  await alpha.deployed();
  console.log("Alpha deployed to:", alpha.address);
}

async function deployEvent(address) {
  const Event = await hre.ethers.getContractFactory("Event");
  const event = await Event.deploy(address);
  await event.deployed();
  console.log("Event deployed to:", event.address);
}

async function deployOracle() {
  const Oracle = await hre.ethers.getContractFactory("Oracle");
  const oracle = await Oracle.deploy();
  await oracle.deployed();
  console.log("Oracle deployed to:", oracle.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
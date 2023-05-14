// scripts/upgrade_box.js
const { ethers, upgrades } = require("hardhat");
require('dotenv').config();

const SharingSBTContractAddress = process.env.FANTOM_TEST_SHARING_SBT_ADDRESS;

async function main() {
  const SharingSBT = await ethers.getContractFactory("SharingSBT");
  console.log("Upgrading SharingSBT...");
  await upgrades.upgradeProxy(SharingSBTContractAddress, SharingSBT);
  console.log("SharingSBT upgraded");
}

main();

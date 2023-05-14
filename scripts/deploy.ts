import { ethers, upgrades } from "hardhat";

async function main() {
  const SharingSBT = await ethers.getContractFactory("SharingSBT");
  const sharingSBT = await upgrades.deployProxy(SharingSBT);

  await sharingSBT.deployed();

  console.log("SharingSBT deployed at:: ", sharingSBT.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

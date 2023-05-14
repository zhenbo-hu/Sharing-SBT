import { expect } from "chai";
import { ethers } from "hardhat";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract } from "ethers";

describe("SharingSBT Test", function () {
  let contract: Contract;
  let owner: SignerWithAddress;

  beforeEach(async function () {
    [owner] = await ethers.getSigners();

    const SharingSBT = await ethers.getContractFactory("SharingSBT");
    contract = await SharingSBT.deploy();
  });

  it("should mint a sharingSBT", async () => {
    await contract.safeMint(owner.address);

    const value = await contract.ownerOf(0);
    expect(value).to.equal(owner.address);
  });
})
import { ethers } from "hardhat";
import { TokenSwapper } from "../contracts/TokenSwapper";

async function main() {
  // Deploy TokenSwapper contract
  const TokenSwapperFactory = await ethers.getContractFactory("TokenSwapper");
  const tokenSwapper = await TokenSwapperFactory.deploy();
  await tokenSwapper.deployed();

  console.log("TokenSwapper contract deployed to:", tokenSwapper.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
});
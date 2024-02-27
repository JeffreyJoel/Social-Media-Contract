import { ethers } from "hardhat";

async function main() {

  // const NFTFactory = await ethers.deployContract("NFTFactory");

  const SocialMediaPlatform = await ethers.deployContract("SocialMediaPlatform");

  // await NFTFactory.waitForDeployment();

  await SocialMediaPlatform.waitForDeployment();

  // console.log(
  //   `NFTFactory deployed at ${NFTFactory.target}`
  // );

  console.log(
    `SocialMediaPlatform deployed at ${SocialMediaPlatform.target}`
  );
}


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

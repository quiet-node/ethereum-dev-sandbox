import { ethers } from 'hardhat';

const main = async () => {
  const Storage = await ethers.getContractFactory('C01Storage');
  const storage = await Storage.deploy();
  await storage.deployed();
  console.log(`Storage deployed to: ${storage.address}`);
};

main().catch((e: any) => {
  console.error(e);
  process.exitCode = 1;
});

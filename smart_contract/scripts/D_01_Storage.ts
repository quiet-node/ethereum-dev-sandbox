import { ethers } from 'hardhat';

const D_01_deploy = async () => {
  const Storage = await ethers.getContractFactory('C_01_Storage');
  const storage = await Storage.deploy();
  await storage.deployed();
  console.log(`Storage deployed to: ${storage.address}`);
};

export default D_01_deploy;

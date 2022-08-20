import { ethers } from 'hardhat';

const main = async () => {
  const Messages = await ethers.getContractFactory('Messages');
  const messages = await Messages.deploy('Hello, Messages!');

  await messages.deployed();

  console.log(`Messages deployed to: ${messages.address}`);
};

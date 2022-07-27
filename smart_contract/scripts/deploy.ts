import { ethers } from 'hardhat';

const main = async () => {
  const Messages = await ethers.getContractFactory('Messages');
  const messages = await Messages.deploy('Hello, There');

  await messages.deployed();
  console.log(`Messages contract deployed to: ${messages.address}`);
};

main().catch((e: any) => {
  console.error(e);
  process.exitCode = 1;
});

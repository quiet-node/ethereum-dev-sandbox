import { ethers } from 'hardhat';

const D_00_deploy = async () => {
  const Messages = await ethers.getContractFactory('C_00_Messages');
  const messages = await Messages.deploy("Hawdy, it's Logan");

  await messages.deployed();

  console.log(`Messages deployed to address: ${messages.address}`);
};

export default D_00_deploy;

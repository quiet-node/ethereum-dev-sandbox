import { Contract, ContractFactory } from 'ethers';
import { ethers } from 'hardhat';

const D_02_deploy = async () => {
  const InsecureEtherVault: ContractFactory = await ethers.getContractFactory(
    'C_02_InsecureEtherVault'
  );
  const insecureEtherVault: Contract = await InsecureEtherVault.deploy();
  await insecureEtherVault.deployed();
  console.log(`InsecureEtherVault deployed to: ${insecureEtherVault.address}`);
};

export default D_02_deploy;

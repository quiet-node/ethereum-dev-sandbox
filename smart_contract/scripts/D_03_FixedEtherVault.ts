import { Contract, ContractFactory } from 'ethers';
import { ethers } from 'hardhat';

const D_03_deploy = async () => {
  const FixedEtherVault: ContractFactory = await ethers.getContractFactory(
    'C_03_FixedEtherVault'
  );
  const fixedEtherVault: Contract = await FixedEtherVault.deploy();
  await fixedEtherVault.deployed();
  console.log(`FixedEtherVault deployed to: ${fixedEtherVault.address}`);
};

export default D_03_deploy;

import { Contract, ContractFactory } from 'ethers';
import { ethers } from 'hardhat';

const main = async () => {
  const InsecureEtherVault: ContractFactory = await ethers.getContractFactory(
    'C_02_InsecureEtherVault'
  );
  const insecureEtherVault: Contract = await InsecureEtherVault.deploy();
  await insecureEtherVault.deployed();
  console.log(`InsecureEtherVault deployed to: ${insecureEtherVault.address}`);
};

main().catch((e: any) => {
  console.error(e);
  process.exitCode = 1;
});

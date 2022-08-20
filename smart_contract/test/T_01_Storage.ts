import { expect } from 'chai';
import { Contract } from 'ethers';
import { ethers } from 'hardhat';

describe('Storage Contract', () => {
  let storageContract: Contract;
  beforeEach(async () => {
    const Storage = await ethers.getContractFactory('C_01_Storage');
    storageContract = await Storage.deploy();
  });
});

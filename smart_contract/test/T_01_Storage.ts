import { expect } from 'chai';
import { Contract } from 'ethers';
import { ethers } from 'hardhat';

describe('Storage Contract', () => {
  let storageContract: Contract;
  beforeEach(async () => {
    const Storage = await ethers.getContractFactory('C_01_Storage');
    storageContract = await Storage.deploy();
  });

  describe('Storing lucky numbers', async () => {
    const _NAME = 'Logan';
    const _LUCKYNUMBER = 7;

    it("Should store lucky number into 'nameToLuckyNumber' mapping storage", async () => {
      await storageContract.storeLuckyNumber(_NAME, _LUCKYNUMBER);
      expect(await storageContract.getLuckyNumberByNames(_NAME)).to.eq(
        _LUCKYNUMBER
      );
    });

    it('Should add _NAME and _LUCKYNUMBER to People struct', async () => {
      await storageContract.storeLuckyNumber(_NAME, _LUCKYNUMBER);
      console.log(await storageContract.people()[0]);
    });
  });
});

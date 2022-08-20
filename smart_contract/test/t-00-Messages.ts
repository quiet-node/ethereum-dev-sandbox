import { expect } from 'chai';
import { Contract, ContractFactory } from 'ethers';
import { ethers } from 'hardhat';

describe('Messages', () => {
  let messages: Contract;
  let initialMessage: String = 'Hello, Messages Contract!';
  beforeEach(async () => {
    const Messages: ContractFactory = await ethers.getContractFactory(
      'Contract00Messages'
    );
    messages = await Messages.deploy(initialMessage);
  });

  describe('Deployment', () => {
    it("Should deploy with the 'initialMessage' message", async () => {
      expect(await messages.message()).to.eq(initialMessage);
    });
  });

  describe('Updating Messages', () => {
    const newUpdatedMessage: String = 'New updated message';
    it("Should update a new message based the user's input", async () => {
      await messages.updateMessage(newUpdatedMessage);
      expect(await messages.getMessage()).to.eq(newUpdatedMessage);
    });
  });
});

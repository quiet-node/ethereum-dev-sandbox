import D_00_deploy from './D_00_Messages';
import D_01_deploy from './D_01_Storage';
import D_02_deploy from './D_02_InsecureEtherVault';
import D_03_deploy from './D_03_FixedEtherVault';

const main = async () => {
  await D_00_deploy();
  await D_01_deploy();
  await D_02_deploy();
  await D_03_deploy();
};

main().catch((e: any) => {
  console.error(e);
  process.exitCode = 1;
});

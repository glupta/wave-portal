const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory("Web3pedia");
    const waveContract = await waveContractFactory.deploy({});
    await waveContract.deployed();
    console.log("Web3pedia address: ", waveContract.address);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.error(error);
      process.exit(1);
    }
  };
  
  runMain();
const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory("Web3pedia");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log("Contract addy:", waveContract.address);
  
    const waveTxn = await waveContract.ask("This is wave #1");
    await waveTxn.wait();
    console.log(waveTxn);

    const waveTxn2 = await waveContract.answer(1, "This is wave #1");
    await waveTxn2.wait();
    console.log(waveTxn2);

    const waveTxn3 = await waveContract.answer(1, "This is wave #2");
    await waveTxn3.wait();
    console.log(waveTxn3);
  }
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();
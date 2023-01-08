// Initialize a library ethereumjs-tx, if you don't have this library then you need to install it. 
var Tx = require('ethereumjs-tx').Transaction

// Initialize a library web3, if you don't have this library then you need to install it. 
const Web3 = require('web3')

// Use the environment secret goerli_infura_url
// Very similar to the functions that could be run on console to initiate web3 instance handler
// Initiate a handler to Goerli Test Network
// Create a constant for chain_name - in this case Goerli. 
const goerli_infura_url = process.env['goerli_infura_url']
const chain_name = "goerli"
const web3 = new Web3(goerli_infura_url)

// Define two constants, one fromAccount, and the second one as privateKeyFromAccount
// use the environment secret privateKeyFromAccount, and then convert it into Hex.
const fromAccount = '0x702e9fC0Af5e1C090396fa7297bED614A7623816'
const privateKeyFromAccount = Buffer.from(process.env['privateKeyFromAccount'], 'hex')

// add these 3-steps
// The incl-abi-data.js contains two constants, viz: contractData & contractABI 
var include_constants = require("./incl-abi-data.js")
const contractData = include_constants.contractData
const contractABI = include_constants.contractABI

//Read the contract that was created in the previous step
const contractAddr = '0x1f89b5e1D2eD5591d6FE0c0e5FcA756Afc1B5C31' //FLUX TOKEN
const contractHandler = new web3.eth.Contract(contractABI, contractAddr)

//7231635

//Get the past events
// Essentially, you are creating a filter here to get all events from a block 7231635 to the latest block

contractHandler.getPastEvents(
  'AllEvents',
  {
    fromBlock: 7231635,
    toBlock: 'latest'
  },
  (error, events) => { console.log(events) }

)

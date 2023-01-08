var Tx  = require('ethereumjs-tx').Transaction
const Web3 = require('web3')

const goerli_infura_url = process.env['goerli_infura_url']
const chain_name = "goerli"
const web3 = new Web3(goerli_infura_url)

const fromAccount = '0x702e9fC0Af5e1C090396fa7297bED614A7623816' 
const privateKeyFromAccount = Buffer.from(process.env['privateKeyFromAccount'], 'hex')

//add these 3-steps
var include_constants = require("./incl-abi-data.js")
const contractData = include_constants.contractData
const contractABI = include_constants.contractABI

//Read the contract that was created in the previous step
const contractAddr = '0x1f89b5e1D2eD5591d6FE0c0e5FcA756Afc1B5C31' //FLUX TOKEN
const contractHandler = new web3.eth.Contract(contractABI, contractAddr)

//7231635

//Get the past events
contractHandler.getPastEvents(
  'AllEvents',
  {
    fromBlock: 7231635,
    toBlock: 'latest'
  },
  (error, events) => {console.log(events)}
  
)

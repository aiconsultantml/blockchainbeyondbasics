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

// Define two constants, one fromAccount and another toAccount
const fromAccount = '0x702e9fC0Af5e1C090396fa7297bED614A7623816'
const toAccount = '0x630D38E1D5e30d798319DC82FAc592c45aBC3073'

// use the environment secret privateKeyFromAccount, and then convert it into Hex.
const privateKeyFromAccount = Buffer.from(process.env['privateKeyFromAccount'], 'hex')

// The following code will do three things 
// a- Create a transaction object
// b- Sign the transaction 
// c= Send the transaction 
web3.eth.getTransactionCount(fromAccount, (err, txCount) => {
  // Create a transaction object, define the data elements
  // nonce is the one up number for the fromAccount, it starts from index 0. 
  // therefore logically the count of the transactions, will be the next nonce for the FromAccount 
  // Transferring 0.01 ether in the value section
  // The data field is blank.
  const transactionObject = {
    nonce: web3.utils.toHex(txCount),
    to: toAccount,
    value: web3.utils.toHex(web3.utils.toWei('0.01', 'ether')),
    gasLimit: web3.utils.toHex(26000),
    gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
    data: web3.utils.toHex("")
  }

  // Sign the transaction, you will need the ethereum-js.transaction object. 
  // This would end up creating a Signed transaction object using the private key
  // To convert the signed transaction object in the raw form, you need to first serialize it
  // Concatenate ‘0x’ as prefix to the Serialized object to convert it to Hex

  const signedTxObj = new Tx(transactionObject, { 'chain': chain_name })
  signedTxObj.sign(privateKeyFromAccount)
  
  const serializedTxObj = signedTxObj.serialize()
  const rawTx = '0x' + serializedTxObj.toString('hex')

  // Send the transaction raw signed transaction and wait for the confirmation receipt
  web3.eth.sendSignedTransaction(rawTx).on('receipt', console.log)
}
)
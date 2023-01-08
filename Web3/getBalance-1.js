//goerli_infura_url is defined as a secret key
const goerli_infura_url = process.env['goerli_infura_url']

// Very similar to the functions that could be run on console to initiate web3 instance handler
// Initiate a handler to Goerli Test Network
var Web3 = require('web3')
var web3 = new Web3(goerli_infura_url)

// Your Metmask Wallet Address 

const acctAddr = '0x702e9fC0Af5e1C090396fa7297bED614A7623816'

//get the balance and then display it in the console log in wei
web3.eth.getBalance(acctAddr).then(console.log)

//Following is another method of getting the balance from the an wallet
//The function getBalance below returns two parameters, error (err) and balance in wei (wei)
//This (==>) symbol means that pass the output of the getBalance command, to the following sub-function
//In the sub-function, using the web3.utils, wei could be converted to ether
//Console.log will display the balance in Ether.

web3.eth.getBalance(acctAddr, (err, wei) => {
            var acctBalance = web3.utils.fromWei(wei, 'ether')
            console.log(acctBalance)
        })


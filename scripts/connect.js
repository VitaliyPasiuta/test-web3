const Web3 = require('web3');
const RealEstate = artifacts.require("RealEstate");

const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545")); // змінити URL, якщо використовуєте інший мережі

RealEstate.deployed().then(function(instance) {
    return instance.addProperty(100);
  }).then(function(result) {
    console.log("Property added successfully!");
  }).catch(function(err) {
    console.log(err);
  });
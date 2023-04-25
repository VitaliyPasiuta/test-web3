module.exports = {
  // Налаштування мережі для розробки
  networks: {
    // Локальна мережа Ganache
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "5777"
    }
  },
  // Налаштування компілятора Solidity
  compilers: {
    solc: {
      version: "0.8.0", // Версія компілятора
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
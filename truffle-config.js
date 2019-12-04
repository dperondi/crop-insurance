/**
 * Use this file to configure your truffle project. It's seeded with some
 * common settings for different networks and features like migrations,
 * compilation and testing. Uncomment the ones you need or modify
 * them to suit your project as necessary.
 *
 * More information about configuration can be found at:
 *
 * truffleframework.com/docs/advanced/configuration
 *
 * To deploy via Infura you'll need a wallet provider (like truffle-hdwallet-provider)
 * to sign your transactions before they're sent to a remote public node. Infura accounts
 * are available for free at: infura.io/register.
 *
 * You'll also need a mnemonic - the twelve word phrase the wallet uses to generate
 * public/private key pairs. If you're publishing your code to GitHub make sure you load this
 * phrase from a file you've .gitignored so it doesn't accidentally become public.
 *
 */

 const HDWalletProvider = require("truffle-hdwallet-provider");
 module.exports = {
  networks: {
    rinkeby: {
      provider: () => new
 HDWalletProvider("pyramid gap media vast flush month scan fog devote smooth trigger space","https://rinkeby.infura.io/v3/c5fe79499e2d43a484d3ce7bc1f36b16"),
      network_id: 4,
      confirmation: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
      gas: 6600000,
      gasPrice: 10 * (10 ** 9),
     },
   },
   compilers: {
     solc: {
       version: "0.5.2",
       settings: {
         optimizer: {
           enabled: true,
           runs: 200,
         },
       },
     },
   },
 };

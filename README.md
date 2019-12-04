# Crop Insruance with Blockchain

Decentralized crop insurance application.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Noje.Js hould be installed on your computer. If you already have it, then check its version. It shouldn’t be too old. Use at least version 8.12.0 or later (to see if Node.js is installed, open your terminal and type “node -v”, this should show you a current version)

The Etherisc team has created a “sandbox” environment where product builders are able to experiment with their products in a test mode.

### Installing

A step by step series of examples that tell you how to get a development env running

Install gifcli.

```
npm install -g @etherisc/gifcli
```

Check the “gifcli version” command. When installed correctly, it should return a version

```
gifcli version
```

### Registration in sandbox

In order to create products, you have to be registered as a product owner. Use the “gifcli user:register” command to register in the sandbox. It will require to insert some information: firstname, lastname, email, and password.

```
gifcli user:register
```

After the registration, the product owner is permitted to create a product. Let’s create the first one.

```
gifcli product:create
```

That’s it. Now we can start creating a smart contract for the product.

## Configuration

Now we are ready to build a product. Clone the git repository.

```
git clone https://github.com/dperondi/crop-insurance
```

Install required dependencies:

```
npm init -y
npm install truffle truffle-hdwallet-provider@1.0.6 @etherisc/gif openzeppelin-solidity
./node_modules/.bin/truffle init
```

Compile:

```
npm run compile
```

Migrate:

```
npm run migrate -- --network rinkeby
```

## Interact with smart contract

Send artifacts of your deployment to GIF Sandbox:

```
gifcli artifact:send --file ./build/contracts/CropInsurance.json --network rinkeby
```

After that, the product will be approved automatically and you can start interacting with it. Enter the console mode:

```
gifcli console
```

Run these commands one by one to go through the whole policy lifecycle from application creation to policy payout.

```
gif.product.get()
```

Create a new customer. This data is private and available only to the product owner.

```
gif.customer.create({ firstname: "Jow", lastname: "York", email: "jow@york.net" })
```

Now start a new business process.
```
gif.bp.create({ customerId: "8a0561353100a160d89efa083366bb163a8086f3ddc80fe5dbed2209394bbeeb" })
```

Here is how you can call your contract data:
```
gif.contract.call("CropInsurance", "getQuote", [100])
```

Now let’s apply for a policy:
```
gif.contract.send("CropInsurance", "applyForPolicy", [ "Peanut", "206", "2018", 1000, 100, "EUR", "984d57ed13104c1ba02a3ab2e11f96c7"])
```

Check if it is created:
```
gif.application.list()
```

Underwrite the application. A new policy should be issued.
```
gif.contract.send("CropInsurance", "underwriteApplication", [1037])
```

Check the new policy:
```
gif.policy.list()
```

Create a claim for the policy:
```
gif.contract.send("CropInsurance", "createClaim", [604])
```

Check the claim:
```
gif.claim.list()
```

Confirm the claim. A new payout should be created.
```
gif.contract.send("CropInsurance", "confirmClaim", [ 1037, 119])
```

Check the payout status:
```
gif.payout.list()
```

As soon as we use fiat payments here, the external payout should be confirmed.
```
gif.contract.send("CropInsurance", "confirmPayout", [ 29, 100 ])
```

And check the final payout status:
```
gif.payout.list()
```

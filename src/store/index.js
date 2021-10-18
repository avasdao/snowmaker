import { createStore } from 'vuex'

export default createStore({
    state: {
        /* Set Smartstarter contract address. */
        smartstarterContractAddr: '0x68a5748c6Dd12CFDbBF322ae24B69DEB16760781',

        /* Set Campaign contract address. */
        campaignContractAddr: '0x92F7378e0412f44AB3c1DABCAE51DD836Ae16C1b',

        /* Set mainnet provider. */
        mainnetProvider: 'https://smartbch.devops.cash/mainnet',

        /* Set testnet provider. */
        testnetProvider: 'https://smartbch.devops.cash/testnet',

        smartstarterAbi: require('../../contracts/Smartstarter.json'),
        campaignAbi: require('../../contracts/Campaign.json'),

        /* Set amount funded. */
        // amountFunded: 1.337,

        /* Set amount requested. */
        amountRequested: 30,

        /* Set summary. */
        summary: `
Smartstarter introduces a brand new set of smart contract features, elevating the existing Flipstarter platform in ways that ONLY SmartBCH can deliver.
Make a pledge now to help our team deliver this 100% Free and Open Source Software (FOSS) platform to support Bitcoin's builders TODAY.
        `,

        /* Set description. */
        description: `
# Introducing SMARTSTARTER!

### [https://smartstarter.cash](https://smartstarter.cash)

![Badge](https://i.imgur.com/hVN5DVB.png)

Smartstarter introduces a brand new set of smart contract functionality; elevating the existing __[Flipstarter](https://flipstarter.cash)__ platform in ways that ONLY __[SmartBCH](https://smartbch.org/)__ can deliver:

- __100% On-chain Transparency:__ With all data stored on-chain, full transparency is GUARANTEED!
- __Self-Reporting:__ Transparent accountability after a campaign has been funded will be highly encouraged and fully supported with our NEW Report Cards.
- __Android & iPhone Compatible:__ Smartstarter is built mobile-first which allows for easy campaign pledging and management while you're on-the-go.
- __NO Minimum Pledge Amount:__ Smartstarter removes the need to set a minimum pledge amount, while also supporting unlimited contributions.
- __Secure, Managed Hosting:__ No need to deploy your own server. Simply point your domain's __[CNAME](https://en.wikipedia.org/wiki/CNAME_record)__ to smartstarter.cash .. and DONE!

Bitcoin Cash is leading the way in peer-to-peer crowdfunding.
SmartBCH introduces an improved system for managing public, peer-to-peer fundraisers.
__All data is stored on-chain.__
This guarantees 100% transparency with every satoshi earned and spent.

## Campaign Goals

1. __FOSS PLATFORM:__ Build and deploy a self-hosted FOSS "smart" crowdfunding platform to the DigitalOcean app marketplace.
2. __REPORT CARDS:__ Develop a self-reporting portal with tools and resources for campaign managers.
3. __HOW-TO VIDEOS:__ Produce step-by-step How-to "Smart" Pledge videos (English, Spanish & Chinese).

### FOSS Platform

The primary goal of this campaign is to complete and successfully deploy the Smartstarter Peer-to-Peer Crowdfunding Platform.

Smartstarter is 100% Free and Opensource Software (FOSS).
Initially, it will be built and deployed to DigitalOcean's app marketplace, as we plan to closely replicate the current process used by Flipstarter to launch self-hosted campaigns.

_NOTE: We also plan to offer a "managed-hosting" solution that will allow campaigns to be conveniently created and deployed in under 5 minutes._

### Report Cards

Over the past year, the #1 request from Flipstarter supporters has been better accountability and transparency from campaigns that they've sponsored.
Smartstarter will introduce and support transparent accountability for peer-to-peer crowdfunding.

We're developing a simple system of Report Cards to encourage frequent status updates from campaign managers.

Report Cards are specifically designed to present a campaign's supporters with the most relevent information.

Our team will be proposing a new specification to allow report data to be saved directly on-chain.
This would allow ANY peer-to-peer platform to directly access (read & write) this data for the purpose of building additional tools and services.

### How-to Videos

As SmartBCH is an extremely nascent technology, we believe it's critical to provide adequte educational materials for new users.

We will produce 3 How-to "Smart" Pledge videos (in English, Spanish and Chinese) explaining step-by-step how to pledge "Smart" Bitcoins.

These videos will be further supported by printed documents (in PDF format) and a web portal that will be kept updated as needed.

## Delivery

### IN 30 DAYS OR LESS

Our team has already laid the initial groundwork for this new platform.
Please check out our __[GitLab repository](https://gitlab.com/bchplease/smartstarter)__.

We intend to deliver this platform very quickly, within 30 days of the successfull completion of this campaign.

## Frequently Asked Questions

If you've got questions, we're very happy to answer them:

- support [at] bchplease [dot] org
- [Join Our Slack](https://join.slack.com/t/bchplease/shared_invite/zt-e7jj03j5-vJbe47kNrPBjTgTXwLNRkA)

### #1 Will Smartstarter be FREE to use?

Yes! We will create a 100% FOSS platform that can be easily deployed and run on a standard VPS -OR- launched directly from DigitalOcean's app marketplace.

### #2 Can I use Smartstarter from a mobile device?

Yes! You can easily install __[Metamask](https://metamask.io/)__ (or ANY compatible DApp browser) on your Android or iPhone to manage your pledges while on-the-go.

## Stretch Goals

Beyond this initial Mininum Viable Product (MVP) release, our team intends to extend the platform further by:

1. Launching the __[Pay It Forward (PIF)](https://pif.cash)__ infrastructure and development fund.
2. Developing and maintaining a system to automagically refund expired pledges.
3. Performing a 3rd-party audit of our __[Solidity contracts](https://gitlab.com/bchplease/smartstarter/-/tree/master/contracts)__ by a certified security firm.

## SmartBCH Resources

Here are some helpful tools to get you started with SmartBCH.

### [Smartscan](https://smartmask.cash/)

If you're having trouble getting your MetaMask setup for SmartBCH, __[Josh Ellithorpe](https://twitter.com/zquestz)__ recently deployed __[smartscan.cash](https://smartmask.cash/)__ to help you out.

## Donate Directly

Send BCH  → [bitcoincash:qqvl7fwc ... mlm053fy](https://blockchair.com/bitcoin-cash/address/qqvl7fwcthhhntsew056t8007pw55k258vmlm053fy)

Send SLP  → [simpleledger:qqxtz0fw ... uxr25a2s](https://simpleledger.info/address/simpleledger:qqxtz0fw3gs5ndmwjm2we92k20zu3z99uuuxr25a2s)

Don't trust. Verify!
[https://bchplease.org](https://bchplease.org) (at our site's footer)


        `,

        /* Set highlights. */
        highlights: [
            {
                id: 'ad9986b9-fe8a-48c3-808c-51fa914bea49',
                cat: 'SOFTWARE',
                heading: `Build and deploy a self-hosted FOSS package to the DigitalOcean app marketplace`,
            },
            {
                id: '658d8cdd-ee9a-4538-90dc-46fe6addb352',
                cat: 'SOFTWARE',
                heading: `Develop a campaign reporting toolkit`,
            },
            {
                id: '96b7e126-1b33-44ab-8fdc-04b522a820f7',
                cat: 'MEDIA',
                heading: `Produce a step-by-step "How-to Pledge" video `,
            },
        ],

        /* Set sponsors. */
        sponsors: [
            {
                id: 'ad9986b9-fe8a-48c3-808c-51fa914bea49',
                cat: 'BUILD',
                heading: `Bitcoin.com`,
            },
            {
                id: '658d8cdd-ee9a-4538-90dc-46fe6addb352',
                cat: 'BUILD',
                heading: `Satoshi Nakamoto`,
            },
            {
                id: '9d57daf4-145c-4f0b-a8cc-11ee35190ac1',
                cat: 'BUILD',
                heading: `Bitcoin Jesus`,
            },
            {
                id: '96b7e126-1b33-44ab-8fdc-04b522a820f7',
                cat: 'RECORD',
                heading: `Step-by-step Video Pledging Demo`,
            },
            {
                id: '746f500c-5cd1-4d33-993a-136944e80374',
                cat: 'WRITE',
                heading: `Step-by-step pledging PDF Guide`,
            },
        ],

    },
    mutations: {
        //
    },
    actions: {
        //
    },
    modules: {
        //
    },
})

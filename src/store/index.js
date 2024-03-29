import { createStore } from 'vuex'

export default createStore({
    state: {
        /* Initialize network. */
        // NOTE: Current available options are `mainnet` and `testnet`.
        network: null,

        /* Set constants. */
        ONE_BITCOIN: 100000000,

        notif: {
            isShowing: false,
            icon: null,
            title: null,
            description: null,
            delay: 7000,
        },

        /* Set amount funded. */
        // amountFunded: 1.337,

        /* Set amount requested. */
        amountRequested: 30,

        /* Set summary. */
        summary: `
Snowmaker introduces a brand NEW suite of smart contracts,  allowing for a permissionless crowdfunding experience that ONLY Avalanche can deliver.
Make a pledge now to help our team deliver this 100% Free and Open Source Software (FOSS) platform to support Avalanche's builders TODAY.
        `,

        /* Set description. */
        description: `
# Introducing SNOWMAKER!

### [https://snowmaker.io](https://snowmaker.io)

![Badge](https://i.imgur.com/hVN5DVB.png)

Snowmaker introduces a brand new set of smart contract functionality; elevating the existing crowdfunding platforms in ways that ONLY __[Avalanche](https://avax.network/)__ can deliver:

- __100% On-chain Transparency:__ With all data stored on-chain, full transparency is GUARANTEED!
- __Self-Reporting:__ Transparent accountability after a campaign has been funded will be highly encouraged and fully supported with our NEW Report Cards.
- __Android & iPhone Compatible:__ Snowmaker is built mobile-first which allows for easy campaign pledging and management while you're on-the-go.
- __NO Minimum Pledge Amount:__ Snowmaker removes the need to set a minimum pledge amount, while also supporting unlimited contributions.
- __Secure, Managed Hosting:__ No need to deploy your own server. Simply point your domain's __[CNAME](https://en.wikipedia.org/wiki/CNAME_record)__ to snowmaker.io .. and DONE!

Avalanche is leading the way in peer-to-peer crowdfunding.
Snowmaker introduces an improved system for managing public, peer-to-peer fundraisers.
__All data is stored on-chain.__
This guarantees 100% transparency with every satoshi earned and spent.

## Campaign Goals

1. __FOSS PLATFORM:__ Build and deploy a self-hosted FOSS "smart" crowdfunding platform to the DigitalOcean app marketplace.
2. __REPORT CARDS:__ Develop a self-reporting portal with tools and resources for campaign managers.
3. __HOW-TO VIDEOS:__ Produce step-by-step How-to "Smart" Pledge videos (English, Spanish & Chinese).

### FOSS Platform

The primary goal of this campaign is to complete and successfully deploy the Snowmaker Peer-to-Peer Crowdfunding Platform.

Snowmaker is 100% Free and Opensource Software (FOSS).
Initially, it will be built and deployed to DigitalOcean's app marketplace, as we plan to closely replicate the current process used by other successful crowdfunding platforms to launch self-hosted campaigns.

_NOTE: We also plan to offer a "managed-hosting" solution that will allow campaigns to be conveniently created and deployed in under 5 minutes._

### Report Cards

Over the past year, the #1 request from crowdfunding supporters has been better accountability and transparency from campaigns that they've sponsored.
Snowmaker will introduce and support transparent accountability for peer-to-peer crowdfunding.

We're developing a simple system of Report Cards to encourage frequent status updates from campaign managers.

Report Cards are specifically designed to present a campaign's supporters with the most relevent information.

Our team will be proposing a new specification to allow report data to be saved directly on-chain.
This would allow ANY peer-to-peer platform to directly access (read & write) this data for the purpose of building additional tools and services.

### How-to Videos

As Snowmaker is an extremely nascent technology, we believe it's critical to provide adequte educational materials for new users.

We will produce 3 How-to "Smart" Pledge videos (in English, Spanish and Chinese) explaining step-by-step how to pledge AVAX.

These videos will be further supported by printed documents (in PDF format) and a web portal that will be kept updated as needed.

## Delivery

### IN 30 DAYS OR LESS

Our team has already laid the initial groundwork for this new platform.
Please check out our __[GitHub repository](https://github.com/modenero/snowmaker)__.

We intend to deliver this platform very quickly, within 30 days of the successfull completion of this campaign.

## Frequently Asked Questions

If you've got questions, we're very happy to answer them:

- support [at] avasdao [dot] org
- [Follow Our Twitter](https://twitter.com/Snowmaker_IO)

### #1 Will Snowmaker be FREE to use?

Yes! We will create a 100% FOSS platform that can be easily deployed and run on a standard VPS -OR- launched directly from DigitalOcean's app marketplace.

### #2 Can I use Snowmaker from a mobile device?

Yes! You can easily install __[Metamask](https://metamask.io/)__ (or ANY compatible DApp browser) on your Android or iPhone to manage your pledges while on-the-go.

## Stretch Goals

Beyond this initial Mininum Viable Product (MVP) release, our team intends to extend the platform further by:

1. Launching the __[Pay It Forward (PIF)](https://pif.cash)__ infrastructure and development fund.
2. Developing and maintaining a system to automagically refund expired pledges.
3. Performing a 3rd-party audit of our __[Solidity contracts](https://github.com/modenero/snowmaker/-/tree/master/contracts)__ by a certified security firm.
4. Add support for the __[Ledger](https://www.ledger.com/)__ hardware wallet.

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
                id: '658d8cdd-ee9a-4538-90dc-46fe6addb352',
                heading: `Pangolin`,
                url: 'https://pangolin.exchange/',
            },
            {
                id: '9d57daf4-145c-4f0b-a8cc-11ee35190ac1',
                heading: `Ava Labs`,
                url: 'https://www.avalabs.org/',
            },
        ],

    },
    getters: {
        getProvider(_state) {
            /* Validate network. */
            if (_state.network === 'mainnet') {
                return 'https://smartbch.devops.cash/mainnet'
            } else if (_state.network === 'testnet') {
                return 'https://smartbch.devops.cash/testnet'
            }

            return null
        },

        getSnowmakerAbi() {
            return require('../../contracts/Snowmaker.json')
        },

        getSnowmakerAddr(_state) {
            /* Validate network. */
            if (_state.network === 'mainnet') {
                return '0xf8226c5a9429DcAdbEff5AA98Ba1c90A45A6a241'
            } else if (_state.network === 'testnet') {
                return '0x8aBDa61456243fB8BBc81c2e3c0Cff516f45EB8A'
            }

            return null
        },

        getCampaignAbi() {
            return require('../../contracts/Campaign.json')
        },

        getCampaignAddr(_state) {
            /* Validate network. */
            if (_state.network === 'mainnet') {
                // return '0xF681789b4d1254Ca56A9BCaef0B4b326dd53bE57' // first test
                return '0x76b5f82B3Bb1C70B61A2d646CB94BE6C8af80989'
            } else if (_state.network === 'testnet') {
                return '0x8B5113D4698C15da9396c8Ef273418a27089572F'
            }

            return null
        },

    },
    actions: {
        /* Set network. */
        setNetwork({ commit }, _network) {
            commit('setNetwork', _network)
        },

        /* Show notification. */
        showNotif({ state, commit }, _pkg) {
            console.log('SHOW NOTIF', _pkg);

            /* Enable showing flag. */
            _pkg.isShowing = true

            /* Set new master (private) key. */
            commit('setNotif', _pkg)

            /* Set timeout to close/reset. */
            setTimeout(() => {
                /* Commit notification. */
                commit('setNotif', {
                    isShowing: false,
                    icon: null,
                    title: null,
                    message: null,
                })
            }, state.notif.delay)
        },

    },
    mutations: {
        /* Set network. */
        setNetwork(_state, _network) {
            _state.network = _network
        },

        /* Set notification. */
        setNotif(_state, _pkg) {
            // console.log('ACTIONS (pkg):', _pkg);

            /* Set showing flag. */
            const isShowing = _pkg.isShowing

            /* Set icon. */
            const icon = _pkg.icon

            /* Set title. */
            const title = _pkg.title

            /* Set message. */
            const message = _pkg.message

            /* Retrieve delay. */
            const delay = _state.notif.delay

            /* Set notification. */
            _state.notif = {
                isShowing,
                icon,
                title,
                message,
                delay,
            }
        }
    },
    modules: {
        //
    },
})

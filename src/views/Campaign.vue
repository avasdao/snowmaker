<template>
    <main class="bg-white">
        <!-- <MobileMenu /> -->

        <!-- <Header /> -->

        <section class="mx-auto pt-14 pb-10 px-4 sm:pt-16 sm:pb-20 sm:px-6 lg:max-w-7xl lg:px-8">
            <!-- Product -->
            <div class="lg:grid lg:grid-rows-1 lg:grid-cols-7 lg:gap-x-8 lg:gap-y-10 xl:gap-x-16">
                <!-- Product image -->
                <div class="lg:row-end-1 lg:col-span-4">
                    <div class="aspect-w-4 aspect-h-3 lg:aspect-h-2 bg-gray-100 overflow-hidden rounded-lg lg:rounded-3xl">
                        <img
                            src="https://tailwindui.com/img/ecommerce-images/product-page-05-product-01.jpg"
                            alt="Sample of 30 icons with friendly and fun details in outline, filled, and brand color styles."
                            class="object-center object-cover"
                        />
                    </div>
                </div>

                <!-- Product details -->
                <div class="max-w-2xl mx-auto mt-14 sm:mt-16 lg:max-w-none lg:mt-0 lg:row-end-2 lg:row-span-2 lg:col-span-3">

                    <div class="flex flex-col-reverse">
                        <Title />

                        <Reviews />
                    </div>

                    <p class="text-gray-500 mt-6 text-lg">
                        {{summary}}
                    </p>

                    <div class="mt-5">
                        <h4 class="sr-only">Status</h4>

                        <p class="text-3xl text-center font-medium text-gray-700">
                            {{$store.state.amountFunded}} sBCH of {{$store.state.amountRequested}} sBCH
                        </p>

                        <p class="text-center text-sm text-gray-500 font-medium">
                            {{fundedDisplay}} of {{requestedDisplay}}
                        </p>

                        <div class="mt-6" aria-hidden="true">
                            <div class="bg-gray-200 rounded-full overflow-hidden">
                                <div class="h-2 bg-green-600 rounded-full" style="width: 80%"></div>
                            </div>

                            <div class="text-sm font-medium text-gray-600 mt-1 pl-5">
                                <div class="text-green-600">Campaign is <span class="text-xl">78%</span> complete...</div>
                            </div>

                        </div>
                    </div>

                    <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-2">
                        <button
                            @click="makePledge"
                            type="button"
                            class="w-full bg-indigo-600 border border-transparent rounded-md py-3 px-8 flex items-center justify-center text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-indigo-500"
                        >
                            Make a Pledge
                        </button>

                        <!-- <button
                            @click="follow"
                            type="button"
                            class="w-full bg-indigo-50 border border-transparent rounded-md py-3 px-8 flex items-center justify-center text-base font-medium text-indigo-700 hover:bg-indigo-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-indigo-500"
                        >
                            Subscribe for Updates
                        </button> -->

                        <button
                            @click="reclaim"
                            type="button"
                            class="w-full bg-indigo-50 border border-transparent rounded-md py-3 px-8 flex items-center justify-center text-base font-medium text-indigo-700 hover:bg-indigo-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-indigo-500"
                        >
                            Reclaim My Pledge
                        </button>
                    </div>

                    <Monitor class="hidden" />

                    <Highlights />

                    <Sponsors />

                    <Share />

                    <Disclaimer />

                </div>

                <div class="w-full max-w-2xl mx-auto mt-16 lg:max-w-none lg:mt-0 lg:col-span-4">
                    <div>
                        <Menu @tabbed="toggleMenu" />

                        <Contributors v-if="showContributors" />
                        <Description v-if="showDescription" />
                        <Feedback v-if="showFeedback" />
                        <ReportCards v-if="showReportCards" />

                    </div>
                </div>
            </div>

            <Policy />

            <Related />

            <CTA class="mt-20 rounded-3xl overflow-hidden" />

        </section>

    </main>
</template>

<script>
/* global BigInt */

/* Import modules. */
import { ethers } from 'ethers'
import numeral from 'numeral'
import superagent from 'superagent'

/* Import (global) components. */
import CTA from '@/components/CTA.vue'

/* Import (local) components. */
import Contributors from './Campaign/Contributors.vue'
import Description from './Campaign/Description.vue'
import Disclaimer from './Campaign/Disclaimer.vue'
import Feedback from './Campaign/Feedback.vue'
import Highlights from './Campaign/Highlights.vue'
import Policy from './Campaign/Policy.vue'
import Menu from './Campaign/Menu.vue'
import Monitor from './Campaign/Monitor.vue'
import Related from './Campaign/Related.vue'
import ReportCards from './Campaign/ReportCards.vue'
import Reviews from './Campaign/Reviews.vue'
import Share from './Campaign/Share.vue'
import Sponsors from './Campaign/Sponsors.vue'
import Title from './Campaign/Title.vue'

/* Set ticker endpoint. */
const TICKER_ENDPOINT = 'https://api.telr.io/v1/ticker/quote/BCH'

// const ONE_BITCOIN = BigInt(100000000)

const SMARTSTARTER_CONTRACT = '0xD15f180780A1cae0128Df05C8D9312514C065F5A'
const CAMPAIGN_CONTRACT = '0x70e4801D675e90bd2f98D503E00c2be3E7eeC642'

export default {
    components: {
        CTA,

        Contributors,
        Description,
        Disclaimer,
        Feedback,
        Highlights,
        Policy,
        Menu,
        Monitor,
        Related,
        ReportCards,
        Reviews,
        Share,
        Sponsors,
        Title,
    },
    data: () => {
        return {
            blockNum: null,

            usd: null,
            summary: null,
            description: null,

            showContributors: null,
            showDescription: null,
            showFeedback: null,
            showReportCards: null,
        }
    },
    computed: {
        fundedDisplay() {
            if (!this.$store.state.amountFunded) return 'n/a'

            return numeral(this.$store.state.amountFunded * this.usd).format('$0,0.00')
        },

        requestedDisplay() {
            if (!this.$store.state.amountRequested) return 'n/a'

            return numeral(this.$store.state.amountRequested * this.usd).format('$0,0.00')
        },

    },
    methods: {
        async init() {
            /* Request ticker. */
            const response = await superagent
                .get(TICKER_ENDPOINT)
                .catch(err => console.error(err))

            /* Validate response. */
            if (!response) {
                throw new Error('Failed to receive ticker from remote API.')
            }

            /* Set response body. */
            const body = response.body
            // console.log('BODY', body)

            /* Validate body. */
            if (!body) {
                throw new Error('Failed to receive ticker from remote API.')
            }

            /* Set USD price. */
            this.usd = body.price

            // FOR DEVELOPMENT PURPOSES ONLY
            this.summary = this.$store.state.summary

            // FOR DEVELOPMENT PURPOSES ONLY
            this.description = this.$store.state.description

            // FOR DEVELOPMENT PURPOSES ONLY
            this.amountFunded = 1.337

            // FOR DEVELOPMENT PURPOSES ONLY
            this.amountRequested = 30

        },

        async initBlockchain() {
            /* Initialize provider. */
            const provider = new ethers
                .providers
                // .JsonRpcProvider('https://smartbch.fountainhead.cash/mainnet') // no CORS available
                .JsonRpcProvider('https://smartbch.devops.cash/testnet')
            console.log('PROVIDER', provider)

            this.blockNum = await provider.getBlockNumber()
            console.log('BLOCK NUM', this.blockNum)

            /* Set Smartstarter contract address. */
            const sAddr = SMARTSTARTER_CONTRACT

            /* Set Smartstarter ABI. */
            const sAbi = require('../../contracts/Smartstarter.json')

            // FOR DEVELOPMENT PURPOSES ONLY
            // The first campaign contract is hardcoded.
            const cAddr = CAMPAIGN_CONTRACT

            /* Set Campaign ABI. */
            const cAbi = require('../../contracts/Campaign.json')

            /* Initialize Smartstarter instance. */
            const smartstarter = new ethers.Contract(sAddr, sAbi, provider)
            console.log('CONTRACT (smartstarter):', smartstarter)

            console.log('ALL CAMPAIGNS', await smartstarter.getCampaigns());

            /* Initialize campaign instance. */
            const campaign = new ethers.Contract(cAddr, cAbi, provider)
            console.log('CONTRACT (campaign):', campaign)

            /* Request campaign info. */
            const campaignInfo = await campaign.getCampaign()
            console.log('CAMPAIGN (info):', campaignInfo)

            /* Set starting block. */
            const startingBlock = campaignInfo.startingBlock.toNumber()

            // const eventFilter = campaign.filters.PledgeReceived()
            // console.log('CAMPAIGN (events):', eventFilter)

            /* Set from block. */
            // FIXME: How should we determine this number??
            const fromBlock = startingBlock

            /* Set to block. */
            // FIXME: How should we determine this number??
            const toBlock = this.blockNum

            let query

            /* Request event data. */
            query = await campaign
                .queryFilter('PledgeReceived', fromBlock, toBlock)
            console.log('QUERY (PledgeReceived):', query)

            /* Handle event entries. */
            query.forEach(entry => {
                /* Set contributor. */
                const contributor = entry.args.contributor

                /* Set funds raised. */
                const fundsRaised = entry.args.fundsRaised

                /* Set pledge amount. */
                const pledgeAmount = entry.args.pledgeAmount

                console.log('CONTRIBUTOR', contributor, fundsRaised.toString(), pledgeAmount.toString())
            })

            /* Request event data. */
            query = await campaign
                .queryFilter('PledgeReclaimed', fromBlock, toBlock)
            console.log('QUERY (PledgeReclaimed):', query)

            /* Handle event entries. */
            query.forEach(entry => {
                /* Set contributor. */
                const contributor = entry.args.contributor

                /* Set funds raised. */
                const fundsRaised = entry.args.fundsRaised

                /* Set reclaim amount. */
                const reclaimAmount = entry.args.reclaimAmount

                console.log('CONTRIBUTOR', contributor, fundsRaised.toString(), reclaimAmount.toString())
            })

            /* Request event data. */
            query = await campaign
                .queryFilter('CreatorPaid', fromBlock, toBlock)
            console.log('QUERY (CreatorPaid):', query)

            /* Handle event entries. */
            query.forEach(entry => {
                /* Set recipient. */
                const recipient = entry.args.recipient

                console.log('RECEIPIENT', recipient)
            })

        },

        /**
         * Toggle Menu
         *
         * Controls the information display menus.
         */
        toggleMenu(_selected) {
            // console.log('TOGGLE MENU (selected):', _selected)

            /* Set all menu displays to false. */
            this.showContributors = false
            this.showDescription = true
            this.showFeedback = false
            this.showReportCards = false

            /* Handle user selection. */
            switch(_selected) {
            case 'contributors':
                return this.showContributors = true
            case 'description':
                return this.showDescription = true
            case 'feedback':
                return this.showFeedback = true
            case 'report-cards':
                return this.showReportCards = true
            default:
                return this.showDescription = true
            }

        },

        /**
         * Make Pledge
         *
         * Begins the pledge process by launching a UI modal.
         */
        async makePledge() {
            console.log('START PLEDGE');

            /* Validate embedded Web3 objects. */
            if (!window.ethereum && !window.bitcoin) {
                /* Validate embedded ethereum object. */
                if (window.bitcoin) {
                    console.info('Found Bitcoin provider.')
                } else if (window.ethereum) {
                    console.info('Found Ethereum provider.')
                } else {
                    return console.error('No Web3 provider found.')
                }
            }

            /* Initialize provider. */
            const provider = new ethers
                .providers
                .Web3Provider(window.ethereum, 'any')

            /* Prompt user for account connections. */
            // await provider.send('eth_requestAccounts', [])

            /* Set signer. */
            const signer = provider.getSigner()

            /* Request account. */
            // this.account = await signer.getAddress()
            // console.log('Account:', this.account)

            // FOR DEVELOPMENT PURPOSES ONLY
            // The first campaign contract is hardcoded.
            const cAddr = CAMPAIGN_CONTRACT

            /* Set Campaign ABI. */
            const cAbi = require('../../contracts/Campaign.json')

            /* Initialize campaign instance. */
            const campaign = new ethers.Contract(cAddr, cAbi, signer)
            console.log('CONTRACT (campaign):', campaign)

            // console.log('CAMPAIGN (info):', await campaign.getDetails())

            /* Set gas price. */
            // NOTE: Current minimum is 1 gWei (1,000,000,000)
            const gasPrice = BigInt(1000000000)

            // const sats = BigInt(150000) // 0.015 BCH

            /* Set value. */
            // const value = (BigInt(1000000000000000000) * sats) / ONE_BITCOIN // 1 BCH
            const value = BigInt(1750000000)

            /* Make pledge. */
            await campaign
                .makePledge('Codie', 'bits and bytes', 'http://code.fun', {
                    gasPrice,
                    value,
                })
        },

        /**
         * Reclaim Pledge
         *
         * Allows a contributor to reclaim their pledged funds.
         *
         * NOTE: This is ONLY available after the campaign has expired.
         */
        async reclaim() {
            console.log('RECLAIM PLEDGE');

            /* Validate embedded Web3 objects. */
            if (!window.ethereum && !window.bitcoin) {
                /* Validate embedded ethereum object. */
                if (window.bitcoin) {
                    console.info('Found Bitcoin provider.')
                } else if (window.ethereum) {
                    console.info('Found Ethereum provider.')
                } else {
                    return console.error('No Web3 provider found.')
                }
            }

            /* Initialize provider. */
            const provider = new ethers
                .providers
                .Web3Provider(window.ethereum, 'any')

            /* Prompt user for account connections. */
            // await provider.send('eth_requestAccounts', [])

            /* Set signer. */
            const signer = provider.getSigner()

            /* Request account. */
            // this.account = await signer.getAddress()
            // console.log('Account:', this.account)

            // FOR DEVELOPMENT PURPOSES ONLY
            // The first campaign contract is hardcoded.
            const cAddr = CAMPAIGN_CONTRACT

            /* Set Campaign ABI. */
            const cAbi = require('../../contracts/Campaign.json')

            /* Initialize campaign instance. */
            const campaign = new ethers.Contract(cAddr, cAbi, signer)
            console.log('CONTRACT (campaign):', campaign)

            // console.log('CAMPAIGN (info):', await campaign.getDetails())

            /* Set gas price. */
            // NOTE: Current minimum is 1 gWei (1,000,000,000)
            const gasPrice = BigInt(1000000000)

            /* Reclaim pledge. */
            await campaign.reclaim({ gasPrice })
        },

    },
    created: function () {

        /* Set all menu displays to false. */
        this.showContributors = false
        this.showFeedback = false
        this.showReportCards = false

        /* Set description (default) display to true. */
        this.showDescription = true

        /* Initialize campaign. */
        this.init()

        /* Initialize blockchain. */
        this.blockNum = 0
        this.initBlockchain()

    },
    mounted: function () {
        //
    },
}
</script>

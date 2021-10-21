<template>
    <main class="bg-white">
        <!-- <MobileMenu /> -->

        <!-- <Header /> -->

        <section class="mx-auto pt-14 pb-10 px-4 sm:pt-16 sm:pb-20 sm:px-6 lg:max-w-7xl lg:px-8">
            <!-- Product -->
            <div class="lg:grid lg:grid-rows-1 lg:grid-cols-7 lg:gap-x-8 lg:gap-y-10 xl:gap-x-16">
                <!-- Product image -->
                <div class="lg:row-end-1 lg:col-span-4">
                    <div class="aspect-w-4 aspect-h-2 bg-gray-100 overflow-hidden rounded-lg lg:rounded-3xl">
                        <img
                            src="@/assets/poster.jpg"
                            alt="Introducing the next era in peer-to-peer crowdfunding."
                            class="object-center object-cover"
                        />
                    </div>
                </div>

                <!-- Product details -->
                <div class="max-w-2xl mx-auto mt-14 sm:mt-16 lg:max-w-none lg:mt-0 lg:row-end-2 lg:row-span-2 lg:col-span-3">

                    <div class="flex flex-col-reverse">
                        <Title />

                        <Rating />
                    </div>

                    <p class="text-gray-500 mt-6 text-lg">
                        {{summary}}
                    </p>

                    <Status :usd="usd" />

                    <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-2">
                        <button
                            @click="makePledge"
                            type="button"
                            class="w-full bg-indigo-600 border border-transparent rounded-md py-3 px-8 flex items-center justify-center text-medium font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-indigo-500"
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
                            class="w-full bg-indigo-50 border border-transparent rounded-md py-3 px-8 flex items-center justify-center text-medium font-medium text-indigo-700 hover:bg-indigo-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-indigo-500"
                        >
                            Reclaim My Pledge
                        </button>
                    </div>

                    <Monitor class="hidden" />

                    <Highlights />

                    <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-2">
                        <button
                            @click="sendFeedback"
                            type="button"
                            class="w-full bg-green-600 border border-transparent rounded-md py-3 px-8 flex items-center justify-center text-medium font-medium text-white hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-green-500"
                        >
                            Send Feedback
                        </button>

                        <button
                            @click="addReportCard"
                            type="button"
                            class="w-full bg-red-50 border border-transparent rounded-md py-3 px-8 flex items-center justify-center text-medium font-medium text-red-700 hover:bg-red-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-red-500"
                        >
                            Add a Report Card
                        </button>
                    </div>

                    <Sponsors />

                    <Share />

                    <Disclaimer />

                </div>

                <div class="w-full max-w-2xl mx-auto mt-16 lg:max-w-none lg:mt-0 lg:col-span-4">
                    <div>
                        <Menu class="" @tabbed="toggleMenu" :contributors="contributors" :supporters="supporters" />

                        <Contributors v-if="showContributors" :contributors="contributors" :usd="usd" />
                        <Description v-if="showDescription" />
                        <Feedback v-if="showFeedback" :supporters="supporters" />
                        <ReportCards v-if="showReportCards" />

                    </div>
                </div>
            </div>

            <Policy class="hidden" />

            <Related />

            <CTA class="mt-20 rounded-3xl overflow-hidden" />

        </section>

        <FeedbackWin :hasFeedback="hasFeedback" @close="closeFeedback" />
        <PledgeWin :isPledging="isPledging" :usd="usd" @close="closePledge" />
    </main>
</template>

<script>
/* global BigInt */

/* Import modules. */
import { ethers } from 'ethers'
import superagent from 'superagent'
import { v4 as uuidv4 } from 'uuid'

/* Import (global) components. */
import CTA from '@/components/CTA.vue'

/* Import (local) components. */
import Contributors from './Campaign/Contributors.vue'
import Description from './Campaign/Description.vue'
import Disclaimer from './Campaign/Disclaimer.vue'
import Feedback from './Campaign/Feedback.vue'
import FeedbackWin from './Campaign/FeedbackWin.vue'
import Highlights from './Campaign/Highlights.vue'
import PledgeWin from './Campaign/PledgeWin.vue'
import Policy from './Campaign/Policy.vue'
import Menu from './Campaign/Menu.vue'
import Monitor from './Campaign/Monitor.vue'
import Rating from './Campaign/Rating.vue'
import Related from './Campaign/Related.vue'
import ReportCards from './Campaign/ReportCards.vue'
import Share from './Campaign/Share.vue'
import Sponsors from './Campaign/Sponsors.vue'
import Status from './Campaign/Status.vue'
import Title from './Campaign/Title.vue'

/* Set ticker endpoint. */
const TICKER_ENDPOINT = 'https://api.telr.io/v1/ticker/quote/BCH'

export default {
    components: {
        CTA,

        Contributors,
        Description,
        Disclaimer,
        Feedback,
        FeedbackWin,
        Highlights,
        PledgeWin,
        Policy,
        Menu,
        Monitor,
        Rating,
        Related,
        ReportCards,
        Share,
        Sponsors,
        Status,
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

            contributors: null,
            supporters: null,

            isPledging: null,
            hasFeedback: null,
        }
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
            // this.amountFunded = 1.337

            // FOR DEVELOPMENT PURPOSES ONLY
            // this.amountRequested = 30

        },

        async initBlockchain() {
            /* Initialize provider. */
            const provider = new ethers.providers
                .JsonRpcProvider(this.$store.state.testnetProvider)
            // console.log('PROVIDER', provider)

            this.blockNum = await provider.getBlockNumber()
            console.log('BLOCK NUM', this.blockNum)

            /* Set Smartstarter contract address. */
            // const sAddr = this.$store.state.smartstarterContractAddr

            /* Set Smartstarter ABI. */
            // const sAbi = this.$store.state.smartstarterAbi

            // FOR DEVELOPMENT PURPOSES ONLY
            // The first campaign contract is hardcoded.
            const cAddr = this.$store.state.campaignContractAddr

            /* Set Campaign ABI. */
            const cAbi = this.$store.state.campaignAbi

            /* Initialize Smartstarter instance. */
            // const smartstarter = new ethers.Contract(sAddr, sAbi, provider)
            // console.log('CONTRACT (smartstarter):', smartstarter)

            // console.log('ALL CAMPAIGNS', await smartstarter.getCampaigns());

            /* Initialize campaign instance. */
            const campaign = new ethers.Contract(cAddr, cAbi, provider)
            // console.log('CONTRACT (campaign):', campaign)

            /* Request campaign info. */
            const campaignInfo = await campaign.getCampaign()
            // console.log('CAMPAIGN (info):', campaignInfo)

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

            /* Initialize contributors. */
            this.contributors = []

            /* Handle event entries. */
            query.forEach(entry => {
                /* Set (contributor) address. */
                const address = entry.args.contributor

                /* Set funds raised. */
                const fundsRaised = entry.args.fundsRaised

                /* Set pledge amount. */
                const pledgeAmount = entry.args.pledgeAmount

                /* Set label. */
                const label = entry.args.label

                /* Set comment. */
                const comment = entry.args.comment

                /* Set url. */
                const url = entry.args.url

                /* Set BCH/USD. */
                const bchUsd = entry.args.bchUsd

                // console.log('CONTRIBUTOR (received):', address, fundsRaised.toString(), pledgeAmount.toString())

                /* Generate a new UUID. */
                const id = uuidv4()

                /* Add contributor. */
                this.contributors.push({
                    id,
                    address,
                    pledgeAmount,
                    fundsRaised,
                    label,
                    comment,
                    url,
                    bchUsd,
                })

            })

            /* Request event data. */
            query = await campaign
                .queryFilter('PledgeReclaimed', fromBlock, toBlock)
            // console.log('QUERY (PledgeReclaimed):', query)

            /* Handle event entries. */
            query.forEach(entry => {
                /* Set contributor. */
                const contributor = entry.args.contributor

                /* Set funds raised. */
                const fundsRaised = entry.args.fundsRaised

                /* Set reclaim amount. */
                const reclaimAmount = entry.args.reclaimAmount

                console.log('CONTRIBUTOR (reclaimed):', contributor, fundsRaised.toString(), reclaimAmount.toString())
            })

            /* Request event data. */
            query = await campaign
                .queryFilter('CreatorPaid', fromBlock, toBlock)
            // console.log('QUERY (CreatorPaid):', query)

            /* Handle event entries. */
            query.forEach(entry => {
                /* Set recipient. */
                const recipient = entry.args.recipient

                console.log('RECEIPIENT', recipient)
            })

            this.supporters = []

            /* Request event data. */
            query = await campaign
                .queryFilter('FeedbackSent', fromBlock, toBlock)
            console.log('QUERY (FeedbackSent):', query)

            /* Handle event entries. */
            query.forEach(entry => {
                /* Set (supporter) address. */
                const address = entry.args.supporter

                /* Set comment. */
                const comment = entry.args.comment

                /* Set timestamp. */
                const timestamp = entry.args.timestamp

                console.log('SUPPORTER', address, comment)

                /* Generate a new UUID. */
                const id = uuidv4()

                this.supporters.push({
                    id,
                    address,
                    comment,
                    timestamp,
                })
            })

            /* Request event data. */
            query = await campaign
                .queryFilter('ReportCardAdded', fromBlock, toBlock)
            console.log('QUERY (ReportCardAdded):', query)

            /* Handle event entries. */
            query.forEach(entry => {
                /* Set publisher. */
                const publisher = entry.args.publisher

                /* Set title. */
                const title = entry.args.title

                /* Set URL. */
                const url = entry.args.url

                console.log('PUBLISHER', publisher, title, url)
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
            this.showDescription = false
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

        makePledge() {
            this.isPledging = true
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
            const cAddr = this.$store.state.campaignContractAddr

            /* Set Campaign ABI. */
            const cAbi = this.$store.state.campaignAbi

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

        sendFeedback() {
            this.hasFeedback = true
        },

        /**
         * Add Report Card
         *
         * Allow authorized users to add a new Report Card.
         */
        addReportCard() {
            this.$store.dispatch('showNotif', {
                icon: 'error',
                title: 'Authorization Error!',
                message: `You don't have permission to do that`,
            })
        },

        closeFeedback() {
            this.hasFeedback = false
        },

        closePledge() {
            this.isPledging = false
        },

    },
    created: function () {

        /* Set all menu displays to false. */
        this.showContributors = false
        this.showFeedback = false
        this.showReportCards = false

        /* Set description (default) display to true. */
        this.showDescription = true

        this.hasFeedback = false
        this.isPledging = false

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

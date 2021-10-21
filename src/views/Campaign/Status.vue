<template>
    <main class="mt-5">
        <h4 class="sr-only">Status</h4>

        <p class="text-3xl text-center font-medium text-gray-700">
            {{fundedDisplay}} of {{requestedDisplay}} sBCH
        </p>

        <p class="text-center text-base text-gray-500 font-medium">
            {{fundedDisplayUsd}} of {{requestedDisplayUsd}} USD
        </p>

        <div class="mt-6" aria-hidden="true">
            <div class="bg-gray-200 rounded-full overflow-hidden">
                <div class="h-2 bg-green-600 rounded-full" :style="{ width: pctCompleted + '%' }"></div>
            </div>

            <div class="text-sm text-center font-medium text-gray-600 mt-1 pl-5">
                <div class="text-green-600">
                    <span class="text-xl">{{pctCompleted}}%</span> complete with <span class="text-xl">10</span> days to go
                </div>
            </div>

        </div>
    </main>
</template>

<script>
/* global BigInt */

/* Import modules. */
import { ethers } from 'ethers'
import numeral from 'numeral'

/* Set constants. */
const RETRY_DELAY = 500 // 0.5 seconds
const RETRY_ATTEMPTS = 10 // approx. 5 seconds

export default {
    props: {
        provider: String,
        usd: Number,
    },
    components: {
        // HelloWorld
    },
    data: () => {
        return {
            // amountFunded: null,
            blockNum: null,

            fundingGoal: null,
            pledgeBalance: null,
        }
    },
    watch: {
        provider: function (_provider) {
            console.log('(STATUS) PROVIDER HAS CHANGED', _provider);

            if (_provider) {
                /* Initialize blockchain. */
                setTimeout(() => {
                    this.initBlockchain()
                }, RETRY_DELAY)
            }
        },
    },
    computed: {
        fundedDisplay() {
            if (!this.pledgeBalance) return '0.0'

            const weiValue = this.pledgeBalance

            const bchValue = Number(weiValue / BigInt(10000000000))

            return numeral(bchValue / 100000000).format('0,0.00[00]')
        },

        fundedDisplayUsd() {
            if (!this.pledgeBalance || !this.usd) return '$0.00'

            const cents = BigInt(parseInt(this.usd * 100))

            const weiValue = this.pledgeBalance * cents

            const usdValue = Number(weiValue / BigInt(1000000000000000000))

            return numeral(usdValue / 100).format('$0,0.00')
        },

        requestedDisplay() {
            if (!this.fundingGoal || !this.usd) return '0.00'

            const weiValue = this.fundingGoal

            const bchValue = Number(weiValue / BigInt(10000000000))

            return numeral(bchValue / 100000000).format('0,0.00[00]')
        },

        requestedDisplayUsd() {
            if (!this.fundingGoal || !this.usd) return '$0.00'

            const cents = BigInt(parseInt(this.usd * 100))

            const weiValue = this.fundingGoal * cents

            const usdValue = Number(weiValue / BigInt(1000000000000000000))

            return numeral(usdValue / 100).format('$0,0.00')
        },

        pctCompleted() {
            if (!this.fundingGoal || !this.pledgeBalance) return 0

            const cents = this.pledgeBalance * BigInt(100)

            const pct = parseInt((cents / this.fundingGoal))

            return pct
        },

    },
    methods: {
        async initBlockchain() {
            /* Validate Web3 provider. */
            if (this.$store.getters.getProvider) {
                console.error('(Status) Blockchain init failed!')

                /* Validate retry attempts. */
                if (this.retries++ < RETRY_ATTEMPTS) {
                    /* Pause and try again. */
                    setTimeout(() => {
                        /* Initialize blockchain. */
                        this.initBlockchain()
                    }, RETRY_DELAY)
                }
            }

            /* Initialize provider. */
            const provider = new ethers.providers
                .JsonRpcProvider(this.$store.getters.getProvider)
            console.log('PROVIDER', provider)

            this.blockNum = await provider
                .getBlockNumber()
                .catch(err => console.error(err))
            // console.log('BLOCK NUM', this.blockNum)

            /* Set Campaign ABI. */
            const cAbi = this.$store.getters.getCampaignAbi

            // FOR DEVELOPMENT PURPOSES ONLY
            // The first campaign contract is hardcoded.
            const cAddr = this.$store.getters.getCampaignAddr

            /* Initialize campaign instance. */
            const campaign = new ethers.Contract(cAddr, cAbi, provider)
            console.log('CONTRACT (campaign):', campaign)

            /* Request campaign info. */
            const campaignInfo = await campaign
                .getCampaign()
                .catch(err => console.error(err))
            console.log('STATUS (info):', campaignInfo)

            this.fundingGoal = BigInt(campaignInfo.fundingGoal)
            // console.log('FUNDING GOAL', this.fundingGoal)

            this.pledgeBalance = BigInt(campaignInfo.pledgeBalance)
            // console.log('PLEDGE BALANCE', this.pledgeBalance)

        },

    },
    created: function () {
        this.blockNum = 0

        this.fundingGoal = BigInt(0)

        this.pledgeBalance = BigInt(0)

        // this.initBlockchain()
    },
    mounted: function () {
        // 
    },
}
</script>

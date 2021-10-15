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

            <div class="text-sm font-medium text-gray-600 mt-1 pl-5">
                <div class="text-green-600">Campaign is <span class="text-xl">{{pctCompleted}}%</span> complete...</div>
            </div>

        </div>
    </main>
</template>

<script>
/* global BigInt */

/* Import modules. */
import { ethers } from 'ethers'
import numeral from 'numeral'

/* Import components. */
// import HelloWorld from '@/components/HelloWorld.vue'

export default {
    props: {
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
    computed: {
        fundedDisplay() {
            if (!this.pledgeBalance) return 'n/a'

            const weiValue = this.pledgeBalance

            const bchValue = Number(weiValue / BigInt(10000000000))

            return numeral(bchValue / 100000000).format('0,0.00[00]')
        },

        fundedDisplayUsd() {
            if (!this.pledgeBalance || !this.usd) return 'n/a'

            const cents = BigInt(parseInt(this.usd * 100))

            const weiValue = this.pledgeBalance * cents

            const usdValue = Number(weiValue / BigInt(1000000000000000000))

            return numeral(usdValue / 100).format('$0,0.00')
        },

        requestedDisplay() {
            if (!this.fundingGoal || !this.usd) return 'n/a'

            const weiValue = this.fundingGoal

            const bchValue = Number(weiValue / BigInt(10000000000))

            return numeral(bchValue / 100000000).format('0,0.00[00]')
        },

        requestedDisplayUsd() {
            if (!this.fundingGoal || !this.usd) return 'n/a'

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
            /* Initialize provider. */
            const provider = new ethers.providers
                .JsonRpcProvider(this.$store.state.testnetProvider)
            // console.log('PROVIDER', provider)

            this.blockNum = await provider.getBlockNumber()
            // console.log('BLOCK NUM', this.blockNum)

            // FOR DEVELOPMENT PURPOSES ONLY
            // The first campaign contract is hardcoded.
            const cAddr = this.$store.state.campaignContractAddr

            /* Set Campaign ABI. */
            const cAbi = this.$store.state.campaignAbi

            /* Initialize campaign instance. */
            const campaign = new ethers.Contract(cAddr, cAbi, provider)
            // console.log('CONTRACT (campaign):', campaign)

            /* Request campaign info. */
            const campaignInfo = await campaign.getCampaign()
            console.log('STATUS (info):', campaignInfo)

            this.fundingGoal = BigInt(campaignInfo.fundingGoal)
            // console.log('FUNDING GOAL', this.fundingGoal)

            this.pledgeBalance = BigInt(campaignInfo.pledgeBalance)
            // console.log('PLEDGE BALANCE', this.pledgeBalance)

            /* Set starting block. */
            // const startingBlock = campaignInfo.startingBlock.toNumber()

            // const eventFilter = campaign.filters.PledgeReceived()
            // console.log('CAMPAIGN (events):', eventFilter)

            /* Set from block. */
            // FIXME: How should we determine this number??
            // const fromBlock = startingBlock

            /* Set to block. */
            // FIXME: How should we determine this number??
            // const toBlock = this.blockNum

        },

    },
    created: function () {
        this.blockNum = 0

        this.fundingGoal = BigInt(0)

        this.pledgeBalance = BigInt(0)

        this.initBlockchain()
    },
    mounted: function () {
        //
    },
}
</script>

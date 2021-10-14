<template>
    <main class="bg-white">
        <MobileMenu />

        <Header />

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

                        <button
                            @click="follow"
                            type="button"
                            class="w-full bg-indigo-50 border border-transparent rounded-md py-3 px-8 flex items-center justify-center text-base font-medium text-indigo-700 hover:bg-indigo-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-indigo-500"
                        >
                            Subscribe for Updates
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
/* Import modules. */
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

    },
    mounted: function () {
        //
    },
}
</script>

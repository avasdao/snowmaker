<template>
    <router-view
        :network="$store.state.network"
        :provider="$store.getters.getProvider"
    />

    <Footer />

    <Profile class="hidden" />

    <Modal class="hidden" />

    <Notif :notif="$store.state.notif" />
</template>

<script>
/* Import components. */
import Footer from '@/components/Footer.vue'
import Modal from '@/components/Modal.vue'
import Notif from '@/components/Notif.vue'
import Profile from '@/components/Profile.vue'

/* Set constants. */
const RETRY_DELAY = 500 // 0.5 seconds
const RETRY_ATTEMPTS = 10 // approx. 5 seconds

export default {
    components: {
        Footer,
        Profile,
        Modal,
        Notif,
    },
    data: () => {
        return {
            // network: null,
            retries: null,
        }
    },
    methods: {
        /**
         * Initialize Web3
         *
         * Attempt to connect to the "injected" Web3 provider.
         */
        initWeb3() {
            if (window.ethereum && window.ethereum.chainId) {
                /* Set chain id. */
                // FIXME: This is DEPRECATED
                // https://docs.metamask.io/guide/provider-migration.html#handling-eth-chainid-return-values
                const chainId = window.ethereum.chainId
                console.log('CHAIN ID', chainId)

                /* Handle chain id. */
                if (chainId) {
                    if (chainId === '0x2710') { // SmartBCH Mainnet
                        /* Request network update. */
                        this.$store.dispatch('setNetwork', 'mainnet')
                    } else if (chainId === '0x2711') { // SmartBCH Testnet
                        /* Request network update. */
                        this.$store.dispatch('setNetwork', 'testnet')
                    }
                } else {
                    throw new Error('Oops! No CHAIN ID is available from the Web3 provider.')
                }

                console.info('Web3 has been loaded and the blockchain is ready to use.')
            } else {
                console.error('Web3 provider could NOT be found. Re-trying in 3, 2, 1..')

                /* Validate retry attempts. */
                if (this.retries++ < RETRY_ATTEMPTS) {
                    /* Pause and try again. */
                    setTimeout(() => {
                        /* Initialize Web3. */
                        this.initWeb3()
                    }, RETRY_DELAY)
                }
            }
        },

    },
    created: function () {
        /* Initialize retries. */
        this.retries = 0
    },
    mounted: function () {
        /* Initialize Web3. */
        // NOTE: It's best to wait until we're mounted to allow time for the
        //       Web3 provider to complete its script injection.
        setTimeout(() => {
            this.initWeb3()
        }, RETRY_DELAY)
    },
}
</script>

<style>
/*  */
</style>

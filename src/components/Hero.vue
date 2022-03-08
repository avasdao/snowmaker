<template>
    <main class="relative">
        <div class="absolute inset-x-0 bottom-0 h-1/2 bg-gray-100"></div>
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="relative shadow-xl sm:rounded-2xl sm:overflow-hidden">
                <div class="absolute inset-0">
                    <img
                        class="h-full w-full object-cover"
                        :src="banner"
                        alt="People working on laptops"
                    />
                    <div class="absolute inset-0 bg-gradient-to-r from-purple-800 to-indigo-700 mix-blend-multiply"></div>
                </div>

                <div class="relative px-4 py-16 sm:px-6 sm:py-24 lg:py-32 lg:px-8">
                    <h1 class="text-center font-extrabold tracking-tight text-4xl">
                        <span class="block text-white text-5xl sm:text-6xl lg:text-8xl">SNOWMAKER</span>
                        <span class="block text-indigo-100">Peer-to-Peer Crowdfunding</span>
                    </h1>

                    <p class="mt-6 max-w-lg mx-auto text-center text-2xl text-indigo-100 sm:max-w-4xl">
                        The MOST effective way to <span class="font-bold">Build</span>, <span class="font-bold">Collect</span> and <span class="font-bold">Manage </span>
                        <br class="hidden sm:block" />support for your project's next campaign.
                    </p>

                    <div class="mt-10 max-w-sm mx-auto sm:max-w-none sm:flex sm:justify-center">
                        <div class="space-y-4 sm:space-y-0 sm:mx-auto sm:inline-grid sm:grid-cols-2 sm:gap-5">
                            <a href="javasript://" @click="launchpad" class="flex items-center justify-center px-4 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-indigo-700 bg-white hover:bg-indigo-50 sm:px-8">
                                Start a Campaign
                            </a>
                            <!-- <router-link to="/launchpad" class="flex items-center justify-center px-4 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-indigo-700 bg-white hover:bg-indigo-50 sm:px-8">
                                Start a Campaign
                            </router-link> -->

                            <router-link to="/help" class="flex items-center justify-center px-4 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-500 bg-opacity-60 hover:bg-opacity-70 sm:px-8">
                                How-To Pledge
                            </router-link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</template>

<script>
/* Import components. */
// import HelloWorld from '@/components/HelloWorld.vue'

export default {
    components: {
        // HelloWorld
    },
    data: () => {
        return {
            //
        }
    },
    computed: {
        banner() {
            /* Set banners. */
            const banners = [
                'ambreen-hasan-E9ANYNkN4Sc-unsplash.jpg',
                'jordon-conner-tIr-PWgSYB4-unsplash.jpg',
            ]

            /* Select banenr. */
            const banner = banners[Math.floor(Math.random() * banners.length)]

            /* Return banner. */
            return require('../assets/' + banner)
        },

    },
    methods: {
        launchpad() {
            console.log('this is the launchpad');
        }
    },
    created: function () {
        //
    },
    mounted: function () {
        //
    },
}
</script>

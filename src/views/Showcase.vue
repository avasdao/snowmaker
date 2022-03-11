<template>
    <main class="relative bg-gray-50 py-20 px-4 sm:px-6 lg:pb-28 lg:px-8">
        <div class="absolute inset-0">
            <div class="bg-white h-1/3 sm:h-2/3"></div>
        </div>

        <div class="relative max-w-7xl mx-auto">
            <div class="text-center">
                <h2 class="text-5xl tracking-tight font-extrabold text-gray-900 sm:text-6xl uppercase">
                    Showcase
                </h2>

                <p class="mt-3 max-w-2xl mx-auto text-xl text-gray-500 sm:mt-4">
                    The campaigns shown below are part of our <a class="text-red-500 font-medium" href="https://pif.cash" target="_blank">Pay It Forward (PIF) community outreach program</a>.
                    Showcased on the homepage are the TOP3 performers from this group.
                </p>
            </div>

            <div class="mt-12 max-w-lg mx-auto grid gap-5 lg:grid-cols-3 lg:max-w-none">

                <router-link
                    v-for="campaign of campaigns"
                    :key="campaign.id" to="/campaign"
                    class="flex flex-col rounded-lg shadow-lg overflow-hidden border-2 border-gray-300"
                >
                    <div class="flex-shrink-0">
                        <img class="h-48 w-full object-cover" :src="campaign.imgBanner" alt="" />
                    </div>

                    <div class="flex-1 bg-white p-6 flex flex-col justify-between">
                        <div class="flex-1">
                            <p class="text-sm font-medium text-indigo-600">
                                <a href="javascript://" class="hover:underline">
                                    {{campaign.category}}
                                </a>
                            </p>

                            <a href="javascript://" class="block mt-2">
                                <p class="text-xl font-semibold text-gray-900">
                                    {{campaign.title}}
                                </p>

                                <p class="mt-3 text-base text-gray-500">
                                    {{campaign.description}}
                                </p>
                            </a>
                        </div>

                        <div class="mt-6 flex items-center">
                            <div class="flex-shrink-0">
                                <a href="javascript://">
                                    <span class="sr-only">{{campaign.title}}</span>
                                    <img class="h-10 w-10 rounded-full" :src="campaign.imgIcon" alt="" />
                                </a>
                            </div>

                            <div class="ml-3">
                                <p class="text-sm font-medium text-gray-900">
                                    <a href="javascript://" class="hover:underline">
                                        {{campaign.title}}
                                    </a>
                                </p>

                                <div class="flex space-x-1 text-sm text-gray-500">
                                    <span>
                                        <a :href="campaign.url" target="_blank" class="text-blue-500 font-medium hover:underline">Website</a>
                                    </span>

                                    <span aria-hidden="true">
                                        |
                                    </span>

                                    <span>
                                        <a :href="campaign.github" target="_blank" class="text-blue-500 font-medium hover:underline">Github</a>
                                    </span>

                                    <span aria-hidden="true">
                                        |
                                    </span>

                                    <span>
                                        <a :href="campaign.video" class="text-gray-500 font-medium">Video</a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </router-link>

            </div>

            <div class="mt-20 flex justify-center">
                <a href="javascript://" class="rounded-xl py-5 px-10 border-4 text-2xl font-bold text-pink-700 bg-pink-200 border-pink-400 hover:text-pink-50 hover:bg-pink-300 hover:border-pink-200">
                    Show Next 20
                </a>
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
            campaigns: null,
        }
    },
    created: function () {
        this.campaigns = []

        this.campaigns.push({
            id: '7c139af6-8a2e-42cd-ba8d-9753712d8e1c',
            title: `Motoverse`,
            category: 'Hackathon Afterparty',
            description: `Motoverse is a different take on DeFi investment with uniquely minted collectible motorbikes utilizing ERC721 non-fungible tokens (NFTs).`,
            url: 'https://motoverse.games/',
            github: 'https://github.com/motoverse',
            video: '',
            imgBanner: 'https://i.imgur.com/gkRwHzE.png',
            imgIcon: 'https://i.imgur.com/gkRwHzE.png',
        })

        this.campaigns.push({
            id: 'c0d6ab26-728a-40fb-8433-4f99f47550fe',
            title: `Yak Spirit`,
            category: 'Hackathon Afterparty',
            description: `Yak Spirit is built on top of Yield Yak to give users a better UX of token swap on Avalanche.`,
            url: 'https://yakspirit.com/',
            github: 'https://github.com/dragoonzx/yak-spirit',
            video: '',
            imgBanner: 'https://i.imgur.com/IsgLgyF.png',
            imgIcon: 'https://i.imgur.com/IsgLgyF.png',
        })

        this.campaigns.push({
            id: '14b18fa4-36e7-4d94-b118-a64868e8fa25',
            title: `CryptoNotify`,
            category: 'Hackathon Afterparty',
            description: `Personalized, proactive alerts for the Web3 world.`,
            url: 'https://www.cryptonotifi.xyz/login',
            github: 'https://github.com/bsileo/crypto-notifi',
            video: '',
            imgBanner: 'https://i.imgur.com/bEEDIN6.png',
            imgIcon: 'https://i.imgur.com/bEEDIN6.png',
        })

    },
    mounted: function () {
        //
    },
}
</script>

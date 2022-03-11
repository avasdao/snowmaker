<template>
    <main class="relative bg-gray-50 pb-20 px-4 sm:px-6 lg:pb-28 lg:px-8">
        <div class="absolute inset-0">
            <div class="bg-white h-1/3 sm:h-2/3"></div>
        </div>

        <div class="relative max-w-7xl mx-auto">
            <div class="text-center">
                <h2 class="text-5xl tracking-tight font-extrabold text-gray-900 sm:text-6xl">
                    SPOTLIGHT
                </h2>

                <p class="hidden mt-3 max-w-2xl mx-auto text-xl text-gray-500 sm:mt-4">
                    We are proud to feature the 3 campaigns that have received the most love from our generous <a class="text-red-500 font-medium" href="https://pif.cash" target="_blank">Pay It Forward (PIF) community</a>.
                </p>
            </div>

            <div class="mt-12 max-w-lg mx-auto grid gap-5 lg:grid-cols-3 lg:max-w-none">

                <router-link
                    v-for="spotlight of spotlights"
                    :key="spotlight.id"
                    :to="'/campaign/' + spotlight.id"
                    class="flex flex-col rounded-lg shadow-lg overflow-hidden border-2 border-gray-300"
                >
                    <div class="flex-shrink-0">
                        <img class="h-48 w-full object-cover" :src="spotlight.imgBanner" alt="" />
                    </div>

                    <div class="flex-1 bg-white p-6 flex flex-col justify-between">
                        <div class="flex-1">
                            <p class="text-sm font-medium text-indigo-600">
                                <a href="javascript://" class="hover:underline">
                                    {{spotlight.category}}
                                </a>
                            </p>

                            <a href="javascript://" class="block mt-2">
                                <p class="text-xl font-semibold text-gray-900">
                                    {{spotlight.title}}
                                </p>

                                <p class="mt-3 text-base text-gray-500">
                                    {{spotlight.description}}
                                </p>
                            </a>
                        </div>

                        <div class="mt-6 flex items-center">
                            <div class="flex-shrink-0">
                                <a href="javascript://">
                                    <span class="sr-only">{{spotlight.title}}</span>
                                    <img class="h-10 w-10 rounded-full" :src="spotlight.imgIcon" alt="" />
                                </a>
                            </div>

                            <div class="ml-3">
                                <p class="text-sm font-medium text-gray-900">
                                    <a href="javascript://" class="hover:underline">
                                        {{spotlight.title}}
                                    </a>
                                </p>

                                <div class="flex space-x-1 text-sm text-gray-500">
                                    <span>
                                        <a :href="spotlight.url" target="_blank" class="text-blue-500 font-medium hover:underline">Website</a>
                                    </span>

                                    <span aria-hidden="true">
                                        |
                                    </span>

                                    <span>
                                        <a :href="spotlight.github" target="_blank" class="text-blue-500 font-medium hover:underline">Github</a>
                                    </span>

                                    <span aria-hidden="true">
                                        |
                                    </span>

                                    <span>
                                        <a :href="spotlight.video" class="text-gray-500 font-medium">Video</a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </router-link>

            </div>

            <div class="mt-20 flex justify-center">
                <router-link to="/showcase" class="rounded-xl py-5 px-10 border-4 text-xl sm:text-2xl font-bold text-pink-700 bg-pink-200 border-pink-400 hover:text-pink-50 hover:bg-pink-300 hover:border-pink-200">
                    Show All Campaigns
                </router-link>
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
            spotlights: null,
        }
    },
    created: function () {
        this.spotlights = []

        this.spotlights.push({
            id: '8d9bf054-afe4-4f8e-8f33-85f0aaec2015',
            title: `Musing`,
            category: 'Hackathon Afterparty',
            description: `Musing is a decentralized Q&amp;A protocol where you can mine tokens by creating great questions and answers. We give users ownership over the content they create.`,
            url: 'https://musing.io/',
            github: 'https://github.com/Musing-io/musing-protocol',
            video: '',
            imgBanner: 'https://i.imgur.com/KohV11V.png',
            imgIcon: 'https://i.imgur.com/KohV11V.png',
        })

        this.spotlights.push({
            id: 'd81484a6-6528-473a-909c-e04b0b30040a',
            title: `Snowflakes.network`,
            category: 'Hackathon Afterparty',
            description: `Web3 push notifications you control.`,
            url: 'https://snowflakes.network/',
            github: 'https://github.com/snowflakes-network/platform',
            video: '',
            imgBanner: 'https://i.imgur.com/iKtVmQ5.png',
            imgIcon: 'https://i.imgur.com/iKtVmQ5.png',
        })

        this.spotlights.push({
            id: '41d4a8a6-baf8-4527-aec4-9b5723067775',
            title: `Astrocave Academy`,
            category: 'Hackathon Afterparty',
            description: `A Gamified Education Platform and portfolio tracker that follows your Decentralized Finance learning journey, tracks your progress and provides guidance along the process.`,
            url: 'https://astrocave.vercel.app/',
            github: 'https://github.com/Astrocavemen/app',
            video: '',
            imgBanner: 'https://i.imgur.com/h31BVO4.png',
            imgIcon: 'https://i.imgur.com/h31BVO4.png',
        })

    },
    mounted: function () {
        //
    },
}
</script>

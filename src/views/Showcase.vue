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
                    :key="campaign.id"
                    :to="'/campaign/' + campaign.id"
                    class="flex flex-col rounded-xl shadow-lg overflow-hidden border-2 border-gray-300"
                >
                    <div class="flex-shrink-0">
                        <img class="h-48 w-full object-cover border-b-2 border-gray-300" :src="campaign.imgBanner" alt="" />
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
                                        <a v-if="campaign.url" @click.prevent="openUrl(campaign.url)" class="text-blue-500 font-medium hover:underline">Website</a>
                                        <a v-else @click.prevent class="text-gray-500 font-medium">Website</a>
                                    </span>

                                    <span aria-hidden="true">
                                        |
                                    </span>

                                    <span>
                                        <a v-if="campaign.github" @click.prevent="openUrl(campaign.github)" class="text-blue-500 font-medium hover:underline">Github</a>
                                        <a v-else @click.prevent class="text-gray-500 font-medium">Github</a>
                                    </span>

                                    <span aria-hidden="true">
                                        |
                                    </span>

                                    <span>
                                        <a v-if="campaign.video" @click.prevent="openUrl(campaign.video)" class="text-blue-500 font-medium hover:underline">Video</a>
                                        <a v-else @click.prevent class="text-gray-500 font-medium">Video</a>
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
    methods: {
        openUrl(_url) {
            window.open(_url)
        },

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

        this.campaigns.push({
            id: '8dba75c7-bdfd-4c54-8a6e-5cbc66f9c89e',
            title: `Cratch`,
            category: 'Hackathon Afterparty',
            description: `Cratch is a fully decentralized MetaStreaming platform that allows users to create or watch live streams in a Metaverse world, while rewarding users from every minute spent in the platform.`,
            url: 'https://cratch.io/',
            github: 'https://github.com/skidrow8852/CratchRepo',
            video: '',
            imgBanner: 'https://i.imgur.com/YSuIDdv.png',
            imgIcon: 'https://i.imgur.com/YSuIDdv.png',
        })

        this.campaigns.push({
            id: 'db76d018-e8d5-4b3c-8c0e-7113773e7b17',
            title: `Your Meta World`,
            category: 'Hackathon Afterparty',
            description: `Your Meta World is a brand new Metaverse created as an entry into the Moralis Avalanche 2022 Hackathon. YourMeta.World is a proof of concept for what is possible when the Metaverse is truly decentralized.`,
            url: 'https://yourmetaworld.org/',
            github: 'https://github.com/xx014939/metaworld-landing',
            video: '',
            imgBanner: 'https://i.imgur.com/ZQfYy4p.png',
            imgIcon: 'https://i.imgur.com/ZQfYy4p.png',
        })

        this.campaigns.push({
            id: 'fde05817-a771-4f25-be74-ccee73ba4ff2',
            title: `AvaDoma`,
            category: 'Hackathon Afterparty',
            description: `Domain name registration for IPFS decentralized applications on Avalanche.`,
            url: 'https://avadoma.com/',
            github: 'https://github.com/AVADoma',
            video: '',
            imgBanner: 'https://i.imgur.com/0AaKzsG.png',
            imgIcon: 'https://i.imgur.com/0AaKzsG.png',
        })

        this.campaigns.push({
            id: '78266a85-9e9d-4b9e-a1f9-adf08aad7942',
            title: `Physical Web3`,
            category: 'Hackathon Afterparty',
            description: `“Walk Up and Use Anything”: The Physical Web 3 is a decentralized approach to enabling quick and seamless interactions with physical objects and locations powered by smart contracts.`,
            url: 'https://physicalweb3.com/',
            github: 'https://github.com/gianksp/physicalweb3-builder/tree/main/public/contracts',
            video: '',
            imgBanner: 'https://i.imgur.com/fqDr0SZ.png',
            imgIcon: 'https://i.imgur.com/fqDr0SZ.png',
        })

        this.campaigns.push({
            id: 'd59ddd8e-1732-4b3c-aeac-66f62488514b',
            title: `Whoosh Finance`,
            category: 'Hackathon Afterparty',
            description: `Crypto portfolio tracker: easily track your crypto, all in one place.`,
            url: 'https://whoosh.fi/',
            github: 'https://github.com/secondfloorlabs/whoosh',
            video: '',
            imgBanner: 'https://i.imgur.com/sG1Luym.png',
            imgIcon: 'https://i.imgur.com/sG1Luym.png',
        })

        this.campaigns.push({
            id: '4ea5b8e4-e715-497b-bf06-0d1722a92896',
            title: `xDAO`,
            category: 'Hackathon Afterparty',
            description: `A multi-chain DAO constructor for collective crypto management.`,
            url: 'https://www.xdao.app/',
            github: 'https://github.com/XDAO-App',
            video: '',
            imgBanner: 'https://i.imgur.com/tHMItJI.png',
            imgIcon: 'https://i.imgur.com/tHMItJI.png',
        })

        this.campaigns.push({
            id: '4d1158d3-a4c3-40b8-85e0-465a3c33dc67',
            title: `PRISMA Finance`,
            category: 'Hackathon Afterparty',
            description: `Agnostic Yield Aggregator Platform and Metaverse Bridge.`,
            url: 'https://prisma.farm/',
            github: 'https://github.com/Prisma-Finance',
            video: '',
            imgBanner: 'https://i.imgur.com/As87gd0.png',
            imgIcon: 'https://i.imgur.com/As87gd0.png',
        })

        this.campaigns.push({
            id: '9b260567-567e-4a63-8a3c-26947ad5d5a4',
            title: `Rugzy`,
            category: 'Hackathon Afterparty',
            description: `Simplified data visualization ecosystem that highlights relevant smart wallet activity.`,
            url: 'https://rugzy.io/',
            github: 'https://rugzy.io/',
            video: '',
            imgBanner: 'https://i.imgur.com/AFLsIB9.png',
            imgIcon: 'https://i.imgur.com/AFLsIB9.png',
        })

        this.campaigns.push({
            id: '9bb751d8-26a8-4a2d-af03-e843962a8713',
            title: `DeFi Dash`,
            category: 'Hackathon Afterparty',
            description: `Say goodbye to spreadsheets and manual portfolio trackers. DeFi Dash is here to provide an automated portfolio management solution for tracking the overall health of your Defi wallet.`,
            url: 'https://defidash.carrd.co/',
            github: 'https://github.com/nzee/delta/',
            video: '',
            imgBanner: 'https://i.imgur.com/Dhyvu36.png',
            imgIcon: 'https://i.imgur.com/Dhyvu36.png',
        })

        this.campaigns.push({
            id: '40e32298-aaaa-4ea1-b5ea-97230f9e0816',
            title: `SuperFun.Social`,
            category: 'Hackathon Afterparty',
            description: `Created Focused Gamified Community Platform.`,
            url: 'https://mvp.superfun.social/login',
            github: 'https://github.com/jaydippatel83/SuperFunSocial-Moralis-Avalanch',
            video: '',
            imgBanner: 'https://i.imgur.com/7fRiUwr.png',
            imgIcon: 'https://i.imgur.com/7fRiUwr.png',
        })

        this.campaigns.push({
            id: '0a1a8aac-f1c1-4c8f-b1ef-55d8556d4187',
            title: `GiftCards NFT`,
            category: 'Hackathon Afterparty',
            description: `Turn your birthday cards into NFTs, digitize your memories forever.`,
            url: 'https://giftcards-nfts.netlify.app/',
            github: 'https://github.com/electrone901/Gift-Cards-NFT-Moralis-avax',
            video: '',
            imgBanner: 'https://i.imgur.com/bBWgqel.png',
            imgIcon: 'https://i.imgur.com/bBWgqel.png',
        })

        this.campaigns.push({
            id: '321faa66-0f32-4cff-a76f-fe26ab53f2a2',
            title: `Factor XUSD`,
            category: 'Hackathon Afterparty',
            description: `Factor XUSD is a stable yieldcoin (yield bearing stablecoin) on Avalanche.`,
            url: 'https://app.xusd.fi/swap',
            github: 'https://github.com/factor-finance/xusd-dapp',
            video: '',
            imgBanner: 'https://i.imgur.com/QHGQ0zP.png',
            imgIcon: 'https://i.imgur.com/QHGQ0zP.png',
        })

        this.campaigns.push({
            id: 'aa98fc6e-40d9-4a20-817a-afd2f8574e16',
            title: `TubeCasts`,
            category: 'Hackathon Afterparty',
            description: `TubeCasts is a service that brings podcast functionality to youtube videos using Web3 technologies.`,
            url: '',
            github: 'https://github.com/iangriggs/TubeCasts',
            video: '',
            imgBanner: 'https://i.imgur.com/mabMZ7A.png',
            imgIcon: 'https://i.imgur.com/mabMZ7A.png',
        })

        this.campaigns.push({
            id: '50a94a9a-ac98-42c6-aa64-762378b04615',
            title: `COCODA Finance`,
            category: 'Hackathon Afterparty',
            description: `Composite. Collateralised. Digital Assets. Own a single crypto asset which behavles exactly like the portfolio of tokens and funds that fit your preferences and risk appetite. Your very own CTF (Chain Traded Fund).`,
            url: 'https://www.cocoda.finance/',
            github: '',
            video: '',
            imgBanner: 'https://i.imgur.com/dG6gcRx.png',
            imgIcon: 'https://i.imgur.com/dG6gcRx.png',
        })

        this.campaigns.push({
            id: '0622d6b9-ae39-45c5-9444-6d8c7e3dedc2',
            title: `EverRise: EverStats`,
            category: 'Hackathon Afterparty',
            description: `EverStats makes real-time insights about all aspects of EverRise easily accessible to the community and team in their preferred medium. EverChart: YouTube live chart feed, EverWatch: Twitter price bot, and on website stats.`,
            url: 'https://data.everrise.com/stats.html',
            github: 'https://github.com/everrise-ecosystem/EverStats',
            video: '',
            imgBanner: 'https://i.imgur.com/aRQ3vds.png',
            imgIcon: 'https://i.imgur.com/aRQ3vds.png',
        })

        this.campaigns.push({
            id: 'a9bfc823-1cdf-428d-b9eb-6ee6e2b4cecf',
            title: `World of Hackathon Wingbirds`,
            category: 'Hackathon Afterparty',
            description: `Hackathon RPGTeam Building For Birds. W0HW is a platform, a game and a structure to attack the problem of team building.`,
            url: 'https://twilight-dust-2356.on.fleek.co/',
            github: 'https://github.com/cromewar/World-of-Hackathon-Wingbirds',
            video: '',
            imgBanner: 'https://i.imgur.com/9lwATlJ.png',
            imgIcon: 'https://i.imgur.com/9lwATlJ.png',
        })

        this.campaigns.push({
            id: 'e0a52f56-fec6-45c1-bc01-5d9d52bdf516',
            title: `YouWho`,
            category: 'Hackathon Afterparty',
            description: `Crypto-based on-demand services ecosystem.`,
            url: 'https://servedemo.youwho.io/',
            github: 'https://github.com/youwhoyou/serve-demo-a',
            video: '',
            imgBanner: 'https://i.imgur.com/G2Hn7YX.png',
            imgIcon: 'https://i.imgur.com/G2Hn7YX.png',
        })

        this.campaigns.push({
            id: 'b0f83632-fcb7-4811-a6f5-217809c8ab7e',
            title: `Vista Protocol`,
            category: 'Hackathon Afterparty',
            description: `Vista is a decentralized, fully on-chain exchange for perpetual futures (or perps for short) built on Avalanche.`,
            url: 'https://vista-protocol.github.io/',
            github: 'https://vista-protocol.github.io/',
            video: '',
            imgBanner: 'https://i.imgur.com/cV6FFgU.png',
            imgIcon: 'https://i.imgur.com/cV6FFgU.png',
        })

        this.campaigns.push({
            id: 'e341c06a-c72a-4900-bd47-be9eb4cfb678',
            title: `DefiReturn`,
            category: 'Hackathon Afterparty',
            description: `DefiReturn is building software to help DeFi investors calculate their on-chain profit and loss. This feature unlocks two use cases: portfolio and tax returns.`,
            url: 'https://ui.defireturn.app/',
            github: 'https://github.com/jswift24/defireturn_ui',
            video: '',
            imgBanner: 'https://i.imgur.com/k4VzVJp.png',
            imgIcon: 'https://i.imgur.com/k4VzVJp.png',
        })

        this.campaigns.push({
            id: 'cd280174-1756-4e39-b595-3779ff5e33ba',
            title: `NFTmall`,
            category: 'Hackathon Afterparty',
            description: `NFT Auction House & Physically Redeemable NFT Marketplace.`,
            url: 'https://nftmall.io/',
            github: '',
            video: '',
            imgBanner: 'https://i.imgur.com/eG0hgHg.png',
            imgIcon: 'https://i.imgur.com/eG0hgHg.png',
        })

        // this.campaigns.push({
        //     id: '',
        //     title: ``,
        //     category: 'Hackathon Afterparty',
        //     description: ``,
        //     url: '',
        //     github: '',
        //     video: '',
        //     imgBanner: '',
        //     imgIcon: '',
        // })

    },
    mounted: function () {
        //
    },
}
</script>

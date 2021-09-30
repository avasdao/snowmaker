<template>
    <main class="bg-indigo-600">
        <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8" aria-label="Top">
            <div class="w-full py-6 flex items-center justify-between border-b border-indigo-500 lg:border-none">
                <div class="flex items-center">
                    <router-link to="/">
                        <span class="sr-only">Workflow</span>
                        <img class="h-10 w-auto" src="https://tailwindui.com/img/logos/workflow-mark.svg?color=white" alt="" />
                    </router-link>

                    <div class="hidden ml-10 space-x-8 lg:block">
                        <router-link to="/reporting" class="text-base font-medium text-white hover:text-indigo-50" key="Reporting">
                            Reporting
                        </router-link>

                        <a href="https://pif.cash" target="_blank" class="text-base font-medium text-white hover:text-indigo-50" key="Pay It Forwrad">
                            Pay It Forward
                        </a>

                        <router-link to="/spotlight" class="text-base font-medium text-white hover:text-indigo-50" key="Spotlight">
                            Spotlight
                        </router-link>

                        <router-link to="/support" class="text-base font-medium text-white hover:text-indigo-50" key="Support">
                            Support
                        </router-link>
                    </div>
                </div>

                <div class="ml-10 space-x-4">
                    <a href="javascript://" class="inline-block bg-indigo-500 py-2 px-4 border border-transparent rounded-md text-base font-medium text-white hover:bg-opacity-75">Sign in</a>

                    <a href="javascript://" class="inline-block bg-white py-2 px-4 border border-transparent rounded-md text-base font-medium text-indigo-600 hover:bg-indigo-50">Sign up</a>
                </div>
            </div>

            <div class="py-4 flex flex-wrap justify-center space-x-6 lg:hidden">
                <a href="javascript://" class="text-base font-medium text-white hover:text-indigo-50" key="Solutions">
                    Solutions
                </a>

                <a href="javascript://" class="text-base font-medium text-white hover:text-indigo-50" key="Pricing">
                    Pricing
                </a>

                <a href="javascript://" class="text-base font-medium text-white hover:text-indigo-50" key="Docs">
                    Docs
                </a>

                <a href="javascript://" class="text-base font-medium text-white hover:text-indigo-50" key="Company">
                    Company
                </a>
            </div>
        </nav>
    </main>
</template>

<script>
export default {
    props: {
        msg: String
    },
    data: () => {
        return {
            showSBCHMenu: null,
            hasProfile: null,
            hasWallet: null,
        }
    },
    created: function () {
        this.showSBCHMenu = false

        this.hasProfile = true

        this.hasWallet = false

        this.showCampaign = false
    },
    mounted: function () {
        //
    },
}
</script>

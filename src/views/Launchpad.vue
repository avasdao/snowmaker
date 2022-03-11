<template>
    <main class="max-w-3xl mx-auto pt-10 pb-12 px-4 lg:pb-16">
        <form>
            <div class="space-y-6">
                <div>
                    <h1 class="text-lg leading-6 font-medium text-gray-900">
                        Campaign Launchpad
                    </h1>

                    <p class="mt-1 text-sm text-gray-500">
                        Let’s get started by filling in the information below to create your new campaign.
                    </p>
                </div>

                <div>
                    <label for="project-name" class="block text-sm font-medium text-gray-700">
                        CAMPAIGN NAME
                    </label>

                    <div class="mt-1">
                        <input type="text" class="block w-full shadow-sm focus:ring-sky-500 focus:border-sky-500 sm:text-sm border-gray-300 rounded-md" placeholder="Awesome Avalanche Project" />
                    </div>
                </div>

                <div>
                    <label for="project-name" class="block text-sm font-medium text-gray-700">
                        CAMPAIGN FUNDING AMOUNT <span class="text-xs">(IN BCH)</span>
                    </label>

                    <div class="mt-1">
                        <input type="text" name="project-name" id="project-name" class="block w-full shadow-sm focus:ring-sky-500 focus:border-sky-500 sm:text-sm border-gray-300 rounded-md" placeholder="10" />
                    </div>
                </div>

                <div class="hidden">
                    <label for="description" class="block text-sm font-medium text-gray-700">
                        CAMPAIGN DESCRIPTION
                    </label>

                    <div class="mt-1">
                        <textarea id="description" name="description" rows="3" class="block w-full shadow-sm focus:ring-sky-500 focus:border-sky-500 sm:text-sm border border-gray-300 rounded-md"></textarea>
                    </div>
                </div>

                <Manager />

                <Recipients />

                <fieldset>
                    <legend class="text-sm font-medium text-gray-900">
                        Spotlight Upgrade (optional)
                    </legend>

                    <p class="text-sm p-3">
                        Spotlight campaigns are featured on sites like Snowmaker and Causes Cash.

                        If the campaign is successfully funded, 1% of proceeds will be sent to the
                        <a class="text-red-500 font-medium" href="https://pif.cash" target="_blank">Pay It Forward Treasury</a>.

                        Your campaign's supporters will receive
                        <a class="text-red-500 font-medium" href="https://pif.cash" target="_blank">PIF</a> for staking and voting rights.
                    </p>

                    <div class="mt-1 bg-white rounded-md shadow-sm -space-y-px">
                        <!-- Checked: "bg-sky-50 border-sky-200 z-10", Not Checked: "border-gray-200" -->
                        <label class="rounded-tl-md rounded-tr-md relative border p-4 flex cursor-pointer focus:outline-none">
                            <input
                                type="radio"
                                name="privacy-setting"
                                value="Public access"
                                class="h-4 w-4 mt-0.5 cursor-pointer text-sky-600 border-gray-300 focus:ring-sky-500"
                                aria-labelledby="privacy-setting-0-label"
                                aria-describedby="privacy-setting-0-description"
                            />
                            <div class="ml-3 flex flex-col">
                                <!-- Checked: "text-sky-900", Not Checked: "text-gray-900" -->
                                <span id="privacy-setting-0-label" class="block text-sm font-medium">
                                    FREE CAMPAIGN
                                </span>

                                <!-- Checked: "text-sky-700", Not Checked: "text-gray-500" -->
                                <span id="privacy-setting-0-description" class="block text-sm">
                                    This campaign will be available to anyone who has the direct link.
                                    {{publicDomain}}
                                </span>

                                <span class="block text-sm">
                                    Rich-media (ie. photo, videos, etc) must be hosted on public servers.
                                </span>
                            </div>
                        </label>

                        <!-- Checked: "bg-sky-50 border-sky-200 z-10", Not Checked: "border-gray-200" -->
                        <label class="relative border p-4 flex cursor-pointer focus:outline-none">
                            <input
                                type="radio"
                                name="privacy-setting"
                                value="Private to Project Members"
                                class="h-4 w-4 mt-0.5 cursor-pointer text-sky-600 border-gray-300 focus:ring-sky-500"
                                aria-labelledby="privacy-setting-1-label"
                                aria-describedby="privacy-setting-1-description"
                            />
                            <div class="ml-3 flex flex-col">
                                <!-- Checked: "text-sky-900", Not Checked: "text-gray-900" -->
                                <span id="privacy-setting-1-label" class="block text-sm font-medium">
                                    SPOTLIGHT CAMPAIGN
                                </span>
                                <!-- Checked: "text-sky-700", Not Checked: "text-gray-500" -->
                                <span id="privacy-setting-1-description" class="block text-sm">
                                    This project will be discoverable on ALL supporting crowdfunding platforms.
                                </span>

                                <small class="text-xs text-red-500">1% will be sent to the PIF Treasury</small>

                                <span class="block text-sm">
                                    Rich-media (ie. photo, videos, etc) must be hosted on OUR servers.
                                </span>
                            </div>
                        </label>

                    </div>
                </fieldset>

                <div>
                    <label for="project-name" class="block text-sm font-medium text-gray-700">
                        CAMPAIGN (PUBLIC) URL
                    </label>

                    <div class="mt-1">
                        <input type="text" v-model="publicDomain" class="block w-full shadow-sm focus:ring-sky-500 focus:border-sky-500 sm:text-sm border-gray-300 rounded-md" placeholder="https://awesome-project.org/smartstarter" />
                    </div>

                    <div class="block italic ml-3 mt-1">
                        <p class="font-medium text-xs">
                            Please Note: a "public" URL is REQUIRED for all STANDARD campaigns
                        </p>

                        <div class="text-xs">
                            Set masking to <span class="text-2xl">→</span>
                            <span class="text-red-500">https://snowmaker.io/&lt;your-campaign-id&gt;</span>
                        </div>

                        <div class="text-xs -mt-3">
                            Set CNAME to <span class="text-2xl">→</span>
                            <span class="text-red-500">https://&lt;your-campaign-id&gt;.snowmaker.io</span>
                        </div>
                    </div>
                </div>

                <div class="hidden">
                    <label for="tags" class="block text-sm font-medium text-gray-700">
                        Tags
                    </label>
                    <input type="text" name="tags" id="tags" class="mt-1 block w-full shadow-sm focus:ring-sky-500 focus:border-sky-500 sm:text-sm border-gray-300 rounded-md" />
                </div>

                <div class="flex justify-end">
                    <button type="button" class="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-sky-500">
                        Cancel
                    </button>

                    <button
                        type="submit"
                        class="ml-3 inline-flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-sky-500 hover:bg-sky-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-sky-500"
                    >
                        Create New Campaign
                    </button>
                </div>
            </div>
        </form>
    </main>
</template>

<script>
/* Import components. */
import Manager from './Launchpad/Manager.vue'
import Recipients from './Launchpad/Recipients.vue'

export default {
    components: {
        Manager,
        Recipients,
    },
    data: () => {
        return {
            publicDomain: null,
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

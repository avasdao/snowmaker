<template>
    <main class="max-w-lg mx-auto pt-10 pb-12 px-4 lg:pb-16">
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
                        Campaign Name
                    </label>

                    <div class="mt-1">
                        <input type="text" class="block w-full shadow-sm focus:ring-sky-500 focus:border-sky-500 sm:text-sm border-gray-300 rounded-md" placeholder="Awesome Bitcoin Project" />
                    </div>
                </div>

                <div>
                    <label for="project-name" class="block text-sm font-medium text-gray-700">
                        Campaign Funding Amount <span class="text-xs">(in BCH)</span>
                    </label>

                    <div class="mt-1">
                        <input type="text" name="project-name" id="project-name" class="block w-full shadow-sm focus:ring-sky-500 focus:border-sky-500 sm:text-sm border-gray-300 rounded-md" placeholder="10" />
                    </div>
                </div>

                <div>
                    <label for="project-name" class="block text-sm font-medium text-gray-700">
                        Campaign (Public) URL
                    </label>

                    <div class="mt-1">
                        <input type="text" v-model="publicDomain" class="block w-full shadow-sm focus:ring-sky-500 focus:border-sky-500 sm:text-sm border-gray-300 rounded-md" placeholder="https://awesome-project.org/funding" />
                    </div>

                    <small class="block italic ml-3 -mt-2">
                        <span class="font-bold">NOTE:</span> Masked to <span class="text-2xl">→</span> <span class="text-red-500">https://smartstarter.cash/&lt;your-campaign-id&gt;</span>
                    </small>
                </div>

                <div class="hidden">
                    <label for="description" class="block text-sm font-medium text-gray-700">
                        Campaign Description
                    </label>

                    <div class="mt-1">
                        <textarea id="description" name="description" rows="3" class="block w-full shadow-sm focus:ring-sky-500 focus:border-sky-500 sm:text-sm border border-gray-300 rounded-md"></textarea>
                    </div>
                </div>

                <fieldset>
                    <legend class="text-sm font-medium text-gray-900">
                        Spotlight Upgrade (optional)
                    </legend>

                    <p class="text-sm p-3">
                        Spotlight campaigns are featured on sites like Smartstarter and Causes Cash.

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

                <div class="space-y-2">
                    <div class="space-y-1">
                        <label for="add-team-members" class="block text-sm font-medium text-gray-700">
                            Add Funding Receipients
                        </label>

                        <p id="add-team-members-helper" class="sr-only">Search by contact name</p>

                        <div class="flex">
                            <div class="flex-grow">
                                <input
                                    type="text"
                                    name="add-team-members"
                                    id="add-team-members"
                                    class="block w-full shadow-sm focus:ring-sky-500 focus:border-sky-500 sm:text-sm border-gray-300 rounded-md"
                                    placeholder="Search by contact name"
                                    aria-describedby="add-team-members-helper"
                                />
                            </div>

                            <span class="ml-3">
                                <button
                                    type="button"
                                    class="bg-white inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-sky-500"
                                >
                                    <!-- Heroicon name: solid/plus -->
                                    <svg class="-ml-2 mr-1 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                        <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
                                    </svg>
                                    <span>Add</span>
                                </button>
                            </span>
                        </div>
                    </div>

                    <div class="border-b border-gray-200">
                        <ul role="list" class="divide-y divide-gray-200">
                            <li class="py-4 flex">
                                <img class="h-10 w-10 rounded-full" src="https://images.unsplash.com/photo-1513910367299-bce8d8a0ebf6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="" />
                                <div class="ml-3 flex flex-col">
                                    <span class="text-sm font-medium text-gray-900">PIF Treasury</span>
                                    <span class="text-sm text-gray-500">pif.cash</span>
                                </div>
                            </li>

                            <li class="py-4 flex">
                                <img class="h-10 w-10 rounded-full" src="https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="" />
                                <div class="ml-3 flex flex-col">
                                    <span class="text-sm font-medium text-gray-900">Bessie Richards</span>
                                    <span class="text-sm text-gray-500">bessie.richards@example.com</span>
                                </div>
                            </li>

                            <li class="py-4 flex">
                                <img class="h-10 w-10 rounded-full" src="https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="" />
                                <div class="ml-3 flex flex-col">
                                    <span class="text-sm font-medium text-gray-900">Floyd Black</span>
                                    <span class="text-sm text-gray-500">floyd.black@example.com</span>
                                </div>
                            </li>
                        </ul>
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
// import HelloWorld from '@/components/HelloWorld.vue'

export default {
    components: {
        // HelloWorld
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

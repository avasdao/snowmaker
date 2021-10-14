<template>
    <main class="border-b border-gray-200">
        <div class="-mb-px flex space-x-8" aria-orientation="horizontal" role="tablist">
            <!-- Selected: "border-indigo-600 text-indigo-600", Not Selected: "border-transparent text-gray-700 hover:text-gray-800 hover:border-gray-300" -->
            <button
                class="border-transparent text-gray-700 hover:text-gray-800 hover:border-gray-300 whitespace-nowrap py-6 border-b-2 font-medium text-base"
                aria-controls="tab-panel-reviews"
                role="tab"
                type="button"
                @click="$emit('tabbed', 'description')"
            >
                DESCRIPTION
            </button>

            <button
                class="border-transparent text-gray-700 hover:text-gray-800 hover:border-gray-300 whitespace-nowrap py-6 border-b-2 font-medium text-base"
                aria-controls="tab-panel-reviews"
                role="tab"
                type="button"
                @click="$emit('tabbed', 'contributors')"
            >
                CONTRIBUTORS <small>(8)</small>
            </button>

            <button
                class="border-transparent text-gray-700 hover:text-gray-800 hover:border-gray-300 whitespace-nowrap py-6 border-b-2 font-medium text-base"
                aria-controls="tab-panel-faq"
                role="tab"
                type="button"
                @click="$emit('tabbed', 'feedback')"
            >
                FEEDBACK <small>(3)</small>
            </button>

            <button
                class="border-transparent text-gray-700 hover:text-gray-800 hover:border-gray-300 whitespace-nowrap py-6 border-b-2 font-medium text-base"
                aria-controls="tab-panel-license"
                role="tab"
                type="button"
                @click="$emit('tabbed', 'report-cards')"
            >
                REPORT CARDS <small>(1)</small>
            </button>
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
    created: function () {
        //
    },
    mounted: function () {
        //
    },
}
</script>

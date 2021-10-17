<template>
    <main class="border-t border-gray-200 mt-10 pt-10">
        <h3 class="text-lg font-medium text-gray-900">
            Campaign Highlights
        </h3>

        <div class="mt-4 prose prose-sm text-gray-500 pb-10 border-b-2 border-gray-200">
            <ul role="list">
                <li v-for="highlight of $store.state.highlights" :key="highlight.id">
                    <strong class="mr-2">{{highlight.cat}}</strong>
                    {{highlight.heading}}
                </li>
            </ul>
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

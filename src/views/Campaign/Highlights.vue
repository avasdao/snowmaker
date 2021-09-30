<template>
    <div class="border-t border-gray-200 mt-10 pt-10">
        <h3 class="text-lg font-medium text-gray-900">
            Campaign Highlights
        </h3>

        <div class="mt-4 prose prose-sm text-gray-500">
            <ul role="list">
                <li>
                    <strong class="mr-2">{{$store.state.highlights[0].cat}}</strong>
                    {{$store.state.highlights[0].heading}}
                </li>

                <li>
                    <strong class="mr-2">{{$store.state.highlights[1].cat}}</strong>
                    {{$store.state.highlights[1].heading}}
                </li>

                <li>
                    <strong class="mr-2">{{$store.state.highlights[2].cat}}</strong>
                    {{$store.state.highlights[2].heading}}
                </li>

                <li>
                    <strong class="mr-2">{{$store.state.highlights[3].cat}}</strong>
                    {{$store.state.highlights[3].heading}}
                </li>

            </ul>
        </div>
    </div>
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

<template>
    <main>
        <!-- 'Customer Reviews' panel, show/hide based on tab state -->
        <div id="tab-panel-reviews" class="-mb-10" aria-labelledby="tab-reviews" role="tabpanel" tabindex="0">
            <h3 class="sr-only">Supporter's Feedback</h3>

            <div
                v-for="supporter of supporters" :key="supporter.id"
                class="flex text-sm text-gray-500 space-x-4"
            >
                <div class="flex-none py-10">
                    <img src="https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=256&h=256&q=80" alt="" class="w-10 h-10 bg-gray-100 rounded-full" />
                </div>
                <div class="flex-1 py-10">
                    <h3 class="font-medium text-gray-900">{{supporter.address}}</h3>
                    <p><time datetime="2021-07-16">July 16, 2021</time></p>

                    <div class="mt-4 prose prose-sm max-w-none text-gray-500">
                        <p>
                            {{supporter.comment}}
                        </p>
                    </div>
                </div>
            </div>

        </div>
    </main>
</template>

<script>
/* Import modules. */
// import { ethers } from 'ethers'
// import numeral from 'numeral'

export default {
    props: {
        supporters: Array,
    },
    data: () => {
        return {
            //
        }
    },
    computed: {
        // pledges() {
        //     /* Validate supporters. */
        //     if (!this.supporters) return []
        //
        //     /* Initialize supporters. */
        //     const supporters = []
        //
        //     /* Handle supporters. */
        //     this.supporters.forEach(_supporter => {
        //         // NOTE: We filter out donation under 1 satoshi
        //         if (_supporter.pledgeAmount.gt(10000000000n)) {
        //             supporters.push(_supporter)
        //         }
        //     })
        //
        //     /* Return supporters. */
        //     return supporters
        // }

    },
    methods: {
        //
    },
    created: function () {
        //
    },
    mounted: function () {
        //
    },
}
</script>

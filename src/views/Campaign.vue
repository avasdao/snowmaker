<template>
    <main class="bg-white">
        <MobileMenu />

        <Header />

        <section class="mx-auto pt-14 pb-10 px-4 sm:pt-16 sm:pb-20 sm:px-6 lg:max-w-7xl lg:px-8">
            <!-- Product -->
            <div class="lg:grid lg:grid-rows-1 lg:grid-cols-7 lg:gap-x-8 lg:gap-y-10 xl:gap-x-16">
                <!-- Product image -->
                <div class="lg:row-end-1 lg:col-span-4">
                    <div class="aspect-w-4 aspect-h-3 lg:aspect-h-2 bg-gray-100 overflow-hidden rounded-lg lg:rounded-3xl">
                        <img
                            src="https://tailwindui.com/img/ecommerce-images/product-page-05-product-01.jpg"
                            alt="Sample of 30 icons with friendly and fun details in outline, filled, and brand color styles."
                            class="object-center object-cover"
                        />
                    </div>
                </div>

                <!-- Product details -->
                <div class="max-w-2xl mx-auto mt-14 sm:mt-16 lg:max-w-none lg:mt-0 lg:row-end-2 lg:row-span-2 lg:col-span-3">

                    <div class="flex flex-col-reverse">
                        <Title />

                        <Reviews />
                    </div>

                    <p class="text-gray-500 mt-6 text-lg">
                        {{description}}
                    </p>

                    <div class="mt-5">
                        <h4 class="sr-only">Status</h4>

                        <p class="text-3xl text-center font-medium text-gray-700">
                            {{$store.state.amountFunded}} sBCH of {{$store.state.amountRequested}} sBCH
                        </p>

                        <p class="text-center text-sm text-gray-500 font-medium">
                            {{fundedDisplay}} of {{requestedDisplay}}
                        </p>

                        <div class="mt-6" aria-hidden="true">
                            <div class="bg-gray-200 rounded-full overflow-hidden">
                                <div class="h-2 bg-green-600 rounded-full" style="width: 80%"></div>
                            </div>

                            <div class="text-sm font-medium text-gray-600 mt-1 pl-5">
                                <div class="text-green-600">Campaign is <span class="text-xl">78%</span> complete...</div>
                            </div>

                        </div>
                    </div>

                    <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-2">
                        <button
                            @click="makePledge"
                            type="button"
                            class="w-full bg-indigo-600 border border-transparent rounded-md py-3 px-8 flex items-center justify-center text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-indigo-500"
                        >
                            Make a Pledge
                        </button>

                        <button
                            @click="follow"
                            type="button"
                            class="w-full bg-indigo-50 border border-transparent rounded-md py-3 px-8 flex items-center justify-center text-base font-medium text-indigo-700 hover:bg-indigo-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-indigo-500"
                        >
                            Subscribe for Updates
                        </button>
                    </div>

                    <Monitor class="hidden" />

                    <Highlights />

                    <Share />

                    <Disclaimer />

                </div>

                <div class="w-full max-w-2xl mx-auto mt-16 lg:max-w-none lg:mt-0 lg:col-span-4">
                    <div>
                        <Menu />

                        <!-- 'Customer Reviews' panel, show/hide based on tab state -->
                        <div id="tab-panel-reviews" class="-mb-10" aria-labelledby="tab-reviews" role="tabpanel" tabindex="0">
                            <h3 class="sr-only">Customer Reviews</h3>

                            <div class="flex text-sm text-gray-500 space-x-4">
                                <div class="flex-none py-10">
                                    <img src="https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=256&h=256&q=80" alt="" class="w-10 h-10 bg-gray-100 rounded-full" />
                                </div>
                                <div class="flex-1 py-10">
                                    <h3 class="font-medium text-gray-900">Emily Selman</h3>
                                    <p><time datetime="2021-07-16">July 16, 2021</time></p>

                                    <div class="flex items-center mt-4">
                                        <!--
                        Heroicon name: solid/star

                        Active: "text-yellow-400", Default: "text-gray-300"
                      -->
                                        <svg class="text-yellow-400 h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                            />
                                        </svg>

                                        <!-- Heroicon name: solid/star -->
                                        <svg class="text-yellow-400 h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                            />
                                        </svg>

                                        <!-- Heroicon name: solid/star -->
                                        <svg class="text-yellow-400 h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                            />
                                        </svg>

                                        <!-- Heroicon name: solid/star -->
                                        <svg class="text-yellow-400 h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                            />
                                        </svg>

                                        <!-- Heroicon name: solid/star -->
                                        <svg class="text-yellow-400 h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                            />
                                        </svg>
                                    </div>
                                    <p class="sr-only">5 out of 5 stars</p>

                                    <div class="mt-4 prose prose-sm max-w-none text-gray-500">
                                        <p>This icon pack is just what I need for my latest project. There's an icon for just about anything I could ever need. Love the playful look!</p>
                                    </div>
                                </div>
                            </div>

                            <div class="flex text-sm text-gray-500 space-x-4">
                                <div class="flex-none py-10">
                                    <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=256&h=256&q=80" alt="" class="w-10 h-10 bg-gray-100 rounded-full" />
                                </div>
                                <div class="flex-1 py-10 border-t border-gray-200">
                                    <h3 class="font-medium text-gray-900">Hector Gibbons</h3>
                                    <p><time datetime="2021-07-12">July 12, 2021</time></p>

                                    <div class="flex items-center mt-4">
                                        <!--
                        Heroicon name: solid/star

                        Active: "text-yellow-400", Default: "text-gray-300"
                      -->
                                        <svg class="text-yellow-400 h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                            />
                                        </svg>

                                        <!-- Heroicon name: solid/star -->
                                        <svg class="text-yellow-400 h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                            />
                                        </svg>

                                        <!-- Heroicon name: solid/star -->
                                        <svg class="text-yellow-400 h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                            />
                                        </svg>

                                        <!-- Heroicon name: solid/star -->
                                        <svg class="text-yellow-400 h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                            />
                                        </svg>

                                        <!-- Heroicon name: solid/star -->
                                        <svg class="text-yellow-400 h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path
                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"
                                            />
                                        </svg>
                                    </div>
                                    <p class="sr-only">5 out of 5 stars</p>

                                    <div class="mt-4 prose prose-sm max-w-none text-gray-500">
                                        <p>
                                            Blown away by how polished this icon pack is. Everything looks so consistent and each SVG is optimized out of the box so I can use it directly with confidence. It would take me several hours to create
                                            a single icon this good, so it's a steal at this price.
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <!-- More reviews... -->
                        </div>

                        <!-- 'FAQ' panel, show/hide based on tab state -->
                        <dl id="tab-panel-faq" class="text-sm text-gray-500" aria-labelledby="tab-faq" role="tabpanel" tabindex="0">
                            <h3 class="sr-only">Frequently Asked Questions</h3>

                            <dt class="mt-10 font-medium text-gray-900">What format are these icons?</dt>
                            <dd class="mt-2 prose prose-sm max-w-none text-gray-500">
                                <p>The icons are in SVG (Scalable Vector Graphic) format. They can be imported into your design tool of choice and used directly in code.</p>
                            </dd>

                            <dt class="mt-10 font-medium text-gray-900">Can I use the icons at different sizes?</dt>
                            <dd class="mt-2 prose prose-sm max-w-none text-gray-500">
                                <p>
                                    Yes. The icons are drawn on a 24 x 24 pixel grid, but the icons can be scaled to different sizes as needed. We don&#039;t recommend going smaller than 20 x 20 or larger than 64 x 64 to retain legibility and
                                    visual balance.
                                </p>
                            </dd>

                            <!-- More FAQs... -->
                        </dl>

                        <!-- 'License' panel, show/hide based on tab state -->
                        <div id="tab-panel-license" class="pt-10" aria-labelledby="tab-license" role="tabpanel" tabindex="0">
                            <h3 class="sr-only">License</h3>

                            <div class="prose prose-sm max-w-none text-gray-500">
                                <h4>Overview</h4>

                                <p>For personal and professional use. You cannot resell or redistribute these icons in their original or modified state.</p>

                                <ul role="list">
                                    <li>You're allowed to use the icons in unlimited projects.</li>
                                    <li>Attribution is not required to use the icons.</li>
                                </ul>

                                <h4>What you can do with it</h4>

                                <ul role="list">
                                    <li>Use them freely in your personal and professional work.</li>
                                    <li>Make them your own. Change the colors to suit your project or brand.</li>
                                </ul>

                                <h4>What you can't do with it</h4>

                                <ul role="list">
                                    <li>Don't be greedy. Selling or distributing these icons in their original or modified state is prohibited.</li>
                                    <li>Don't be evil. These icons cannot be used on websites or applications that promote illegal or immoral beliefs or activities.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <Related />

            <CTA class="mt-20 rounded-3xl overflow-hidden" />

        </section>

    </main>
</template>

<script>
/* Import modules. */
import numeral from 'numeral'
import superagent from 'superagent'

/* Import components. */
import CTA from '@/components/CTA.vue'

import Disclaimer from './Campaign/Disclaimer.vue'
import Highlights from './Campaign/Highlights.vue'
import Menu from './Campaign/Menu.vue'
import Monitor from './Campaign/Monitor.vue'
import Related from './Campaign/Related.vue'
import Reviews from './Campaign/Reviews.vue'
import Share from './Campaign/Share.vue'
import Title from './Campaign/Title.vue'

export default {
    components: {
        CTA,

        Disclaimer,
        Highlights,
        Menu,
        Monitor,
        Related,
        Reviews,
        Share,
        Title,
    },
    data: () => {
        return {
            usd: null,
        }
    },
    computed: {
        fundedDisplay() {
            if (!this.$store.state.amountFunded) return 'n/a'

            return numeral(this.$store.state.amountFunded * this.usd).format('$0,0.00')
        },

        requestedDisplay() {
            if (!this.$store.state.amountRequested) return 'n/a'

            return numeral(this.$store.state.amountRequested * this.usd).format('$0,0.00')
        },

    },
    methods: {
        async init() {
            const response = await superagent.get('https://api.telr.io/v1/ticker/quote/BCH')
            const body = response.body
            // console.log('BODY', body)

            this.usd = body.price

            this.description = this.$store.state.description

            this.amountFunded = 1.337
            this.amountRequested = 30

            console.log('STORE', this.$store);
            console.log('request', this.$store.state.amountRequested);

        },

    },
    created: function () {
        this.init()
    },
    mounted: function () {
        //
    },
}
</script>

<template>
    <main class="bg-white">
        <Header />

        <Hero />

        <Sponsors />

        <Spotlight />

        <!-- Alternating Feature Sections -->
        <div class="relative pt-16 pb-32 overflow-hidden">
            <div aria-hidden="true" class="absolute inset-x-0 top-0 h-48 bg-gradient-to-b from-gray-100"></div>

            <Reporting />

            <Contributors class="mt-24" />
        </div>

        <Features class="hidden" />

        <Metrics />

        <Recent />

        <CTA />

    </main>
</template>

<script>
/* Import components. */
import Contributors from '@/components/Contributors.vue'
import CTA from '@/components/CTA.vue'
import Features from '@/components/Features.vue'
import Header from '@/components/Header.vue'
import Hero from '@/components/Hero.vue'
import Metrics from '@/components/Metrics.vue'
import Recent from '@/components/Recent.vue'
import Reporting from '@/components/Reporting.vue'
import Sponsors from '@/components/Sponsors.vue'
import Spotlight from '@/components/Spotlight.vue'

export default {
    components: {
        Contributors,
        CTA,
        Features,
        Header,
        Hero,
        Metrics,
        Recent,
        Reporting,
        Sponsors,
        Spotlight,
    }
}
</script>

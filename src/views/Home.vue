<template>
    <main class="bg-white overflow-x-hidden">
        <Header />

        <Hero class="pt-12 lg:pt-18" />

        <Sponsors />

        <Spotlight class="pt-16 lg:pt-24" />

        <Reporting class="py-16 lg:py-24" />

        <Benefits class="" />

        <Contributors class="py-16 lg:py-24" />

        <Metrics class="" />

        <Recent class="py-16 lg:py-24" />

        <CTA />

    </main>
</template>

<script>
/* Import components. */
import Benefits from '@/components/Benefits.vue'
import Contributors from '@/components/Contributors.vue'
import CTA from '@/components/CTA.vue'
import Header from '@/components/Header.vue'
import Hero from '@/components/Hero.vue'
import Metrics from '@/components/Metrics.vue'
import Recent from '@/components/Recent.vue'
import Reporting from '@/components/Reporting.vue'
import Sponsors from '@/components/Sponsors.vue'
import Spotlight from '@/components/Spotlight.vue'

export default {
    components: {
        Benefits,
        Contributors,
        CTA,
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

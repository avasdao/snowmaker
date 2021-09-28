<template>
    <Header class="hidden" />

    <router-view/>

    <Footer />
</template>

<script>
/* Import components. */
import Footer from '@/components/Footer.vue'
import Header from '@/components/Header.vue'

export default {
    components: {
        Footer,
        Header,
    }
}
</script>

<style>
/*  */
</style>

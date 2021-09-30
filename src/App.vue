<template>
    <router-view />

    <Footer />

    <Profile class="hidden" />

    <Modal class="hidden" />

    <Notif class="hidden" />
</template>

<script>
/* Import components. */
import Footer from '@/components/Footer.vue'
import Profile from '@/components/Profile.vue'
import Modal from '@/components/Modal.vue'
import Notif from '@/components/Notif.vue'

export default {
    components: {
        Footer,
        Profile,
        Modal,
        Notif,
    }
}
</script>

<style>
/*  */
</style>

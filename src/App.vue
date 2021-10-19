<template>
    <router-view />

    <Footer />

    <Profile class="hidden" />

    <Modal class="hidden" />

    <Notif :notif="$store.state.notif" />
</template>

<script>
/* Import components. */
import Footer from '@/components/Footer.vue'
import Modal from '@/components/Modal.vue'
import Notif from '@/components/Notif.vue'
import Profile from '@/components/Profile.vue'

export default {
    components: {
        Footer,
        Profile,
        Modal,
        Notif,
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

<style>
/*  */
</style>

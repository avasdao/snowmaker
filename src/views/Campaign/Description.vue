<template>
    <main>
        <div v-html="description" />
    </main>
</template>

<script>
/* Import modules. */
// import DOMPurify from 'dompurify'
import showdown from 'showdown'

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
        this.description = this.$store.state.description

        // const clean = DOMPurify.sanitize( this.description , {
        //     USE_PROFILES: { html: true }
        // })


        const converter = new showdown.Converter()
        const html = converter.makeHtml(this.description)
        console.log('HTML', html)

        // this.description = clean
        this.description = html
    },
    mounted: function () {
        //
    },
}
</script>

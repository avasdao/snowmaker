import { createStore } from 'vuex'

export default createStore({
    state: {
        /* Set amount funded. */
        amountFunded: 1.337,

        /* Set amount requested. */
        amountRequested: 30,

        /* Set summary. */
        summary: `
Smartstarter introduces a brand new set of smart contract functionality; elevating the existing Flipstarter platform in ways that ONLY SmartBCH can deliver.
Make your pledge now and help our team deliver this 100% Free and Open Source Software (FOSS) platform to our builders ASAP.
        `,

        /* Set description. */
        description: `
# Introducing Smartstarter

### [https://smartstarter.cash](https://smartstarter.cash)

![Badge](https://i.imgur.com/hVN5DVB.png)

Enjoy the peace of mind...

hi there
1. me
2. then
3. you

okat then
- what
- about
- this

## Stretch Goals

I'd like to mention our future plans..
        `,

        /* Set highlights. */
        highlights: [
            {
                id: '658d8cdd-ee9a-4538-90dc-46fe6addb352',
                cat: 'SOFTWARE',
                heading: `Develop a campaign reporting toolkit`,
            },
            {
                id: '9d57daf4-145c-4f0b-a8cc-11ee35190ac1',
                cat: 'SOFTWARE',
                heading: `Develop a system to automagically return expired pledges`,
            },
            {
                id: '96b7e126-1b33-44ab-8fdc-04b522a820f7',
                cat: 'MEDIA',
                heading: `Produce a step-by-step "How-to Pledge" video `,
            },
            {
                id: '746f500c-5cd1-4d33-993a-136944e80374',
                cat: 'DOCUMENT',
                heading: `Write a bi-lingual, step-by-step pledging (PDF) guide`,
            },
            {
                id: 'ad9986b9-fe8a-48c3-808c-51fa914bea49',
                cat: 'SOFTWARE',
                heading: `Build a self-hosted package and deploy to DigitalOcean app marketplace`,
            },
        ],

        /* Set sponsors. */
        sponsors: [
            {
                id: 'ad9986b9-fe8a-48c3-808c-51fa914bea49',
                cat: 'BUILD',
                heading: `Bitcoin.com`,
            },
            {
                id: '658d8cdd-ee9a-4538-90dc-46fe6addb352',
                cat: 'BUILD',
                heading: `Satoshi Nakamoto`,
            },
            {
                id: '9d57daf4-145c-4f0b-a8cc-11ee35190ac1',
                cat: 'BUILD',
                heading: `Bitcoin Jesus`,
            },
            {
                id: '96b7e126-1b33-44ab-8fdc-04b522a820f7',
                cat: 'RECORD',
                heading: `Step-by-step Video Pledging Demo`,
            },
            {
                id: '746f500c-5cd1-4d33-993a-136944e80374',
                cat: 'WRITE',
                heading: `Step-by-step pledging PDF Guide`,
            },
        ],

    },
    mutations: {
        //
    },
    actions: {
        //
    },
    modules: {
        //
    },
})

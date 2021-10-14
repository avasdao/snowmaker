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
Make your pledge now and help our team deliver this 100% open-source platform to you ASAP.
        `,

        /* Set description. */
        description: `
# Introducing Smartstarter

Enjoy the peace of mind...
        `,

        /* Set highlights. */
        highlights: [
            {
                id: 'ad9986b9-fe8a-48c3-808c-51fa914bea49',
                cat: 'BUILD',
                heading: `Self-hosted Package + DigitalOcean App`,
            },
            {
                id: '658d8cdd-ee9a-4538-90dc-46fe6addb352',
                cat: 'BUILD',
                heading: `Crowdfunding Campaign Reporting Toolkit`,
            },
            {
                id: '9d57daf4-145c-4f0b-a8cc-11ee35190ac1',
                cat: 'BUILD',
                heading: `Automatic Returning Pledge`,
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

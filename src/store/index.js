import { createStore } from 'vuex'

export default createStore({
    state: {
        /* Set amount funded. */
        amountFunded: 1.337,

        /* Set amount requested. */
        amountRequested: 30,

        /* Set description. */
        description: `
            Smartstarter introduces a brand new set of smart contract functionality; elevating the existing Flipstarter platform in ways that ONLY SmartBCH can deliver.
            Make your pledge now and help our team deliver this 100% open-source platform to you ASAP.
        `,

        /* Set highlights. */
        highlights: [
            {
                cat: 'CREATE',
                heading: `Self-hosted Package + DigitalOcean App`,
            },
            {
                cat: 'BUILD',
                heading: `Crowdfunding Campaign Reporting Toolkit`,
            },
            {
                cat: 'RECORD',
                heading: `Step-by-step Video Pledging Demo`,
            },
            {
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

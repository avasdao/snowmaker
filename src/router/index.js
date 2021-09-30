import { createRouter, createWebHistory } from 'vue-router'

import Home from '../views/Home.vue'

import About from '../views/About.vue'
import Bounties from '../views/Bounties.vue'
import Campaign from '../views/Campaign.vue'
import Compare from '../views/Compare.vue'
import Edit from '../views/Edit.vue'
import Help from '../views/Help.vue'
import Launchpad from '../views/Launchpad.vue'
import Profile from '../views/Profile.vue'
import Reporting from '../views/Reporting.vue'
import Sponsors from '../views/Sponsors.vue'
import Spotlight from '../views/Spotlight.vue'
import Stats from '../views/Stats.vue'
import Support from '../views/Support.vue'

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home,
    },
    {
        path: '/about',
        name: 'About',
        component: About,
    },
    {
        path: '/bounties',
        name: 'Bounties',
        component: Bounties,
    },
    {
        path: '/campaign',
        name: 'Campaign',
        component: Campaign,
    },
    {
        path: '/flipstarter',     // alias for campaign
        name: 'Campaign',
        component: Campaign,
    },
    {
        path: '/compare',
        name: 'Compare',
        component: Compare,
    },
    {
        path: '/edit',
        name: 'Edit',
        component: Edit,
    },
    {
        path: '/help',
        name: 'Help',
        component: Help,
    },
    {
        path: '/launchpad',
        name: 'Launchpad',
        component: Launchpad,
    },
    {
        path: '/profile',
        name: 'Profile',
        component: Profile,
    },
    {
        path: '/reporting',
        name: 'Reporting',
        component: Reporting,
    },
    {
        path: '/sponsors',
        name: 'Sponsors',
        component: Sponsors,
    },
    {
        path: '/spotlight',
        name: 'Spotlight',
        component: Spotlight,
    },
    {
        path: '/stats',
        name: 'Stats',
        component: Stats,
    },
    {
        path: '/support',
        name: 'Support',
        component: Support,
    },
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes,
})

export default router

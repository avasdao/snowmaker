import { createRouter, createWebHistory } from 'vue-router'

import Home from '../views/Home.vue'

import About from '../views/About.vue'
import Bounties from '../views/Bounties.vue'
import Campaign from '../views/Campaign.vue'
import Compare from '../views/Compare.vue'
import Edit from '../views/Edit.vue'
import Help from '../views/Help.vue'
import How from '../views/How.vue'
import Launchpad from '../views/Launchpad.vue'
import Profile from '../views/Profile.vue'
import Reports from '../views/Reports.vue'
import Sponsors from '../views/Sponsors.vue'
import Showcase from '../views/Showcase.vue'
import Stats from '../views/Stats.vue'

const routes = [
    {
        path: '/',
        component: Home,
    },
    {
        path: '/about',
        component: About,
    },
    {
        path: '/bounties',
        component: Bounties,
    },
    {
        path: '/campaign',
        component: Campaign,
    },
    {
        path: '/campaign/:id',
        component: Campaign,
    },
    {
        path: '/afterparty',     // alias for campaign
        component: Campaign,
    },
    {
        path: '/compare',
        component: Compare,
    },
    {
        path: '/edit',
        component: Edit,
    },
    {
        path: '/help',
        component: Help,
    },
    {
        path: '/how',
        component: How,
    },
    {
        path: '/launchpad',
        component: Launchpad,
    },
    {
        path: '/profile',
        component: Profile,
    },
    {
        path: '/reports',
        component: Reports,
    },
    {
        path: '/sponsors',
        component: Sponsors,
    },
    {
        path: '/showcase',
        component: Showcase,
    },
    {
        path: '/stats',
        component: Stats,
    },
]

const router = createRouter({
    scrollBehavior(to, from, savedPosition) {
        if (savedPosition) {
            return savedPosition
        } else {
            return { top: 0 }
        }
    },
    history: createWebHistory(process.env.BASE_URL),
    // mode: process.env.BASE_URL === '/' ? 'history': 'hash',
    // mode: 'hash',
    mode: 'history',
    base: process.env.BASE_URL,
    routes,
})

export default router

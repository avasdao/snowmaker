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
        path: '/afterparty',     // alias for campaign
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
        path: '/how',
        name: 'How',
        component: How,
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
        path: '/reports',
        name: 'Reports',
        component: Reports,
    },
    {
        path: '/sponsors',
        name: 'Sponsors',
        component: Sponsors,
    },
    {
        path: '/showcase',
        name: 'Showcase',
        component: Showcase,
    },
    {
        path: '/stats',
        name: 'Stats',
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

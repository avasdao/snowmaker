import { createRouter, createWebHistory } from 'vue-router'

import Home from '../views/Home.vue'

import About from '../views/About.vue'
import Bounties from '../views/Bounties.vue'
import Launchpad from '../views/Launchpad.vue'
import Pledge from '../views/Pledge.vue'
import Profile from '../views/Profile.vue'
import Showcase from '../views/Showcase.vue'
import Sponsors from '../views/Sponsors.vue'
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
        path: '/launchpad',
        name: 'Launchpad',
        component: Launchpad,
    },
    {
        path: '/pledge',
        name: 'Pledge',
        component: Pledge,
    },
    {
        path: '/profile',
        name: 'Profile',
        component: Profile,
    },
    {
        path: '/showcase',
        name: 'Showcase',
        component: Showcase,
    },
    {
        path: '/sponsors',
        name: 'Sponsors',
        component: Sponsors,
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

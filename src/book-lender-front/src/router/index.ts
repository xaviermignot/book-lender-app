import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LendBookView from '../views/LendBookView.vue'
import ScanIsbnView from '../views/Lend/ScanIsbnView.vue'
import ManualSearchView from '../views/Lend/ManualSearchView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/lend',
      name: 'lend-book',
      component: LendBookView
    },
    {
      path: '/lend/scan',
      name: 'lend-book-scan',
      component: ScanIsbnView
    },
    {
      path: '/lend/search',
      name: 'lend-book-search',
      component: ManualSearchView
    }
  ],
  linkActiveClass: "btn btn-primary",
  linkExactActiveClass: "btn btn-primary"
})

export default router

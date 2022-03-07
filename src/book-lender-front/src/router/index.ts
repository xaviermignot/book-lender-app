import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LendBookView from '../views/LendBookView.vue'
import LendBookScanView from '../views/Lend/LendBookScanView.vue'
import LendBookSearchView from '../views/Lend/LendBookSearchView.vue'
import ReturnBookView from '../views/ReturnBookView.vue'
import ReturnBookScanView from '../views/Return/ReturnBookScanView.vue'
import ReturnBookListView from '../views/Return/ReturnBookListView.vue'
import ListAllBooksView from '../views/ListAllBooksView.vue'

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
      component: LendBookScanView
    },
    {
      path: '/lend/search',
      name: 'lend-book-search',
      component: LendBookSearchView
    },
    {
      path: '/return',
      name: 'return-book',
      component: ReturnBookView
    },
    {
      path: '/return/scan',
      name: 'return-book-scan',
      component: ReturnBookScanView
    },
    {
      path: '/return/list',
      name: 'return-book-list',
      component: ReturnBookListView
    },
    {
      path: '/list',
      name: 'list-all-books',
      component: ListAllBooksView
    }
  ],
  linkActiveClass: "btn btn-primary",
  linkExactActiveClass: "btn btn-primary"
})

export default router

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import { createI18n } from 'vue-i18n'

import MenuLinkButton from './components/MenuLinkButton.vue'

const i18n = createI18n({
  locale: 'fr'
})

createApp(App)
  .component('MenuLinkButton', MenuLinkButton)
  .use(router)
  .use(i18n)
  .mount('#app')

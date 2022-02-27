import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import MenuLinkButton from './components/MenuLinkButton.vue'
import QrCodeScanner from './components/QrCodeScanner.vue'

createApp(App)
  .component('MenuLinkButton', MenuLinkButton)
  .component('QrCodeScanner', QrCodeScanner)
  .use(router)
  .mount('#app')

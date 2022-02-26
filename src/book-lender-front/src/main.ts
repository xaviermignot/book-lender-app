import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import MenuLinkButton from './components/MenuLinkButton.vue'

createApp(App)
.component('MenuLinkButton', MenuLinkButton)
.use(router)
.mount('#app')

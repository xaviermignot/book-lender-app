<i18n>
{
  "en": {
    "title": "Home page",
    "lend": "Lend a book",
    "list": "List the books"
  },
  "fr": {
    "title": "Accueil",
    "lend": "Prêter un livre",
    "list": "Afficher la liste des livres"
  } 
}
</i18n>

<script setup lang="ts">
import MenuLinkButton from '../components/MenuLinkButton.vue'
import { useI18n } from 'vue-i18n';

const { locale, t } = useI18n({
  inheritLocale: true
})
</script>

<template>
  <h1>{{ t('title') }}</h1>
  <MenuLinkButton to="/lend">{{ t('lend') }}</MenuLinkButton>
  <MenuLinkButton to="/return">{{ t('lend') }}</MenuLinkButton>
  <MenuLinkButton to="/list">{{ t('list') }}</MenuLinkButton>
</template>

<script setup lang="ts">
import MenuLinkButton from '../components/MenuLinkButton.vue'
</script>

<template>
  <h1>Home page</h1>
  <MenuLinkButton to="/lend">Lend a book</MenuLinkButton>
  <MenuLinkButton to="/return">Return a book</MenuLinkButton>
  <MenuLinkButton to="/list">List the books</MenuLinkButton>
</template>

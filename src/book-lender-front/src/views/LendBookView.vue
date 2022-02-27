<script setup lang="ts">
import MenuLinkButton from '../components/MenuLinkButton.vue'
</script>

<template>
  <h1>Lend a book</h1>
  <MenuLinkButton to="/lend/scan">Scan ISBN</MenuLinkButton>
  <MenuLinkButton to="/lend/search">Manual search</MenuLinkButton>
  <MenuLinkButton to="/">Back</MenuLinkButton>
</template>

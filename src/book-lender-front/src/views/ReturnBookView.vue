<script setup lang="ts">
import MenuLinkButton from '../components/MenuLinkButton.vue'
</script>

<template>
  <h1>Return a book</h1>
  <MenuLinkButton to="/return/scan">Scan ISBN</MenuLinkButton>
  <MenuLinkButton to="/return/list">Select from the list</MenuLinkButton>
  <MenuLinkButton to="/">Back</MenuLinkButton>
</template>

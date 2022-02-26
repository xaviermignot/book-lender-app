<script setup>
import MenuLinkButton from '../../components/MenuLinkButton.vue';
</script>

<template>
  <h1>Scan a book</h1>
  <MenuLinkButton :to="{ name: 'lend-book' }">Back</MenuLinkButton>
</template>

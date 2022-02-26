<script setup>
</script>

<template>
    <h1>Lend a book</h1>
    <MenuLinkButton :to="{ name: 'lend-book-scan' }">Scan ISBN</MenuLinkButton>
    <MenuLinkButton :to="{ name: 'lend-book-search' }">Manual search</MenuLinkButton>
    <MenuLinkButton :to="{ name: 'home' }">Back</MenuLinkButton>
</template>

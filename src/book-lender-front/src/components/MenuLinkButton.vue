<script setup lang="ts">
const props = defineProps({
  to: String
})
</script>
<template>
  <router-link class="btn btn-success opacity-75" role="button" :to="to">
    <slot />
  </router-link>
</template>
<script setup lang="ts">
import { defineProps } from 'vue';
import { RouteLocationRaw } from 'vue-router';

const props = defineProps<{
  to: string | RouteLocationRaw;
}>();
</script>

<template>
  <router-link class="btn btn-success opacity-75" role="button" :to="to">
    <slot />
  </router-link>
</template>
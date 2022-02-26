<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <main>
    <div class="container overflow-hidden">
      <div class="d-grid gap-2 col-8 col-md-5 mx-auto mt-2 p-2 rounded bg-warning bg-opacity-25">
        <RouterView />
      </div>
    </div>
  </main>
</template>
<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <main>
    <div class="container">
      <div class="d-grid gap-2 col-8 col-md-5 mx-auto">
        <RouterView />
      </div>
    </div>
  </main>
</template>
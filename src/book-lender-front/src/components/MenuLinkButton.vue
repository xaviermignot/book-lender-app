<script lang="ts">
import { RouterLink } from 'vue-router'

export default {
    props: { ...RouterLink.props }
}
</script>
<template>
    <router-link class="btn btn-primary" role="button" v-bind="$props">
        <slot />
    </router-link>
</template>
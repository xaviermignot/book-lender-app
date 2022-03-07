<script setup lang="ts">
import MenuLinkButton from '../../components/MenuLinkButton.vue'
import { ref } from 'vue'
import { config, bookLenderApiService } from '../../services/bookLenderApiService'

const isbn = ref("");
const data = ref(null);
const error = ref(null);

const searching = ref(false);

let svc = new bookLenderApiService();

function search() {
  searching.value = true

  fetch(
    `${config.apiUrl}/v1/books?isbn=${isbn.value}`,
    {
      headers: {
        'Ocp-Apim-Subscription-Key': config.apiKey
      }
    })
    .then((res) => res.json())
    .then((json) => (data.value = json))
    .catch((err) => (error.value = err))
}
</script>

<template>
  <h1>Search a book</h1>
  <div class="mb-3">
    <label for="isbn" class="form-label">ISBN</label>
    <input type="text" id="isbn" class="form-control" v-model="isbn" />
  </div>
  <div v-if="error">Oops! Error encountered !!!</div>
  <div v-else-if="data">
    Data loaded:
    <pre>{{ data }}</pre>
  </div>
  <div v-else-if="searching">Searching...</div>
  <button type="button" class="btn btn-success opacity-75" @click="search">Search</button>
  <MenuLinkButton to="/lend">Back</MenuLinkButton>
</template>

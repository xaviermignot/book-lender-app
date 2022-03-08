<script setup lang="ts">
import { ref } from 'vue';
import { config } from '../../services/bookLenderApiService';
import QrCodeScanner from '../../components/QrCodeScanner.vue'
import MenuLinkButton from '../../components/MenuLinkButton.vue'

const isbn = ref("");
const data = ref(null);
const error = ref(null);

const searching = ref(false);

function search() {
  searching.value = true

  fetch(
    `${config.apiUrl}/v1/books/${isbn.value}`,
    {
      headers: {
        'Ocp-Apim-Subscription-Key': config.apiKey
      }
    })
    .then((res) => res.json())
    .then((json) => (data.value = json))
    .catch((err) => (error.value = err))
}

function onScan(decodedText: string, decodedResult: String) {
  isbn.value = decodedText
  search()
}
</script>

<template>
  <h1>Scan a book to lend</h1>
  <QrCodeScanner :qrbox="250" :fps="10" @result="onScan"></QrCodeScanner>
  <div v-if="error">Oops! Error encountered !!!</div>
  <div v-else-if="data">
    Data loaded:
    <pre>{{ data }}</pre>
  </div>
  <div v-else-if="searching">Searching...</div>
  <MenuLinkButton to="/lend">Back</MenuLinkButton>
</template>

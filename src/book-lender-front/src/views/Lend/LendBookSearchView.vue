<script setup lang="ts">
import MenuLinkButton from '../../components/MenuLinkButton.vue'
import { ref } from 'vue'
import { bookLenderApiService } from '../../services/bookLenderApiService';

const isbn = ref("");
const data = ref(null);
const error = ref("");

const searching = ref(false);

const service = new bookLenderApiService();

const searchAsync = async () => {
  searching.value = true;
  data.value = null;
  error.value = "";

  const searchResult = await service.searchByIsbnAsync(isbn.value);

  if (searchResult.success) {
    data.value = searchResult.book;
  }
  else {
    error.value = searchResult.message;
  }
};
</script>

<template>
  <h1>Search a book</h1>
  <div class="mb-3">
    <label for="isbn" class="form-label">ISBN</label>
    <input type="text" id="isbn" class="form-control" v-model="isbn" />
  </div>
  <div v-if="error">
    <pre>{{ error }}</pre>
  </div>
  <div v-else-if="data">
    Data loaded:
    <pre>{{ data }}</pre>
  </div>
  <div v-else-if="searching">Searching...</div>
  <button type="button" class="btn btn-success opacity-75" @click="searchAsync">Search</button>
  <MenuLinkButton to="/lend">Back</MenuLinkButton>
</template>

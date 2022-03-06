import { ref, Ref } from 'vue'

export const config = {
  apiUrl: 'https://api.url.com',
  apiKey: 'api-key'
}

export class bookLenderApiService {
  useFetch(url: string, request: RequestInit) {
    const data = ref(null)
    const error = ref(null)

    fetch(url, request)
      .then((res) => res.json())
      .then((json) => (data.value = json))
      .catch((err) => (error.value = err))

    return { data, error }
  }

  searchByIsbn(isbn: string) {
    return this.useFetch(
      `${config.apiUrl}/v1/books?isbn=${isbn}`,
      {
        headers: {
          'Ocp-Apim-Subscription-Key': config.apiKey
        }
      })
  }
}


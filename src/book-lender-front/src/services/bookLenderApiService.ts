import { ref, isRef, unref, watchEffect } from 'vue'

export const config = {
  apiUrl: import.meta.env.VITE_API_BASE_URL,
  apiKey: import.meta.env.VITE_API_KEY
}

export class bookLenderApiService {
  searchByIsbn(isbn: string) {
    return useFetch(
      `${config.apiUrl}/v1/books/${isbn}`,
      {
        headers: {
          'Ocp-Apim-Subscription-Key': config.apiKey
        }
      })
  }

  async searchByIsbnAsync(isbn: string) {
    const response = await fetch(
      `${config.apiUrl}/v1/books/${isbn}`,
      {
        headers: {
          'Ocp-Apim-Subscription-Key': config.apiKey
        }
      });

    switch (response.status) {
      case 200:
        return { success: true, message: "", book: await response.json() };
      case 404:
        return { success: false, message: `Unable to find a book with ISBN '${isbn}'` };
      default:
        return { success: false, message: 'An unexpected error occurred, please retry later' };
    }
  }
}

function useFetch(url: string, request: RequestInit) {
  const data = ref(null)
  const error = ref(null)

  async function doFetch() {
    // reset state before fetching..
    data.value = null
    error.value = null

    // resolve the url value synchronously so it's tracked as a
    // dependency by watchEffect()
    const urlValue = unref(url)

    try {
      // unref() will return the ref value if it's a ref
      // otherwise the value will be returned as-is
      const res = await fetch(urlValue, request)
      data.value = await res.json()
    } catch (e) {
      // error.value = e
    }
  }

  if (isRef(url)) {
    // setup reactive re-fetch if input URL is a ref
    watchEffect(doFetch)
  } else {
    // otherwise, just fetch once
    doFetch()
  }

  return { data, error, retry: doFetch }
}

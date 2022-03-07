import { ref, isRef, unref, watchEffect } from 'vue'

export const config = {
  apiUrl: import.meta.env.VITE_API_BASE_URL,
  apiKey: import.meta.env.VITE_API_KEY
}

export class bookLenderApiService {
  // useFetch(url: string, request: RequestInit) {
  //   const data = ref(null)
  //   const error = ref(null)

  //   fetch(url, request)
  //     .then((res) => res.json())
  //     .then((json) => (data.value = json))
  //     .catch((err) => (error.value = err))

  //   return { data, error }
  // }

  searchByIsbn(isbn: string) {
    return useFetch(
      `${config.apiUrl}/v1/books?isbn=${isbn}`,
      {
        headers: {
          'Ocp-Apim-Subscription-Key': config.apiKey
        }
      })
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

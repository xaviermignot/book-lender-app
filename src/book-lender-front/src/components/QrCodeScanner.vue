<script lang="ts">
import { Html5QrcodeScanner } from 'html5-qrcode'
import { Html5QrcodeError, Html5QrcodeResult } from 'html5-qrcode/esm/core';
import { defineComponent } from 'vue';

export default defineComponent({
  data() {
    return {
      html5QrcodeScanner: <Html5QrcodeScanner>{}
    }
  },
  props: {
    qrbox: {
      type: Number,
      default: 250
    },
    fps: {
      type: Number,
      default: 10
    },
  },
  mounted() {
    const config = {
      fps: this.fps,
      qrbox: this.qrbox,
      experimentalFeatures: {
        useBarCodeDetectorIfSupported: false
      }
    };
    this.html5QrcodeScanner = new Html5QrcodeScanner('qr-code-full-region', config, false);
    this.html5QrcodeScanner.render(this.onScanSuccess, this.onScanError);
  },
  methods: {
    onScanSuccess(decodedText: string, decodedResult: Html5QrcodeResult) {
      this.$emit('result', decodedText, decodedResult)
      this.html5QrcodeScanner.clear()
    },
    onScanError(errorMessage: string, error: Html5QrcodeError) {
      this.$emit('error', errorMessage, error)
    }
  }
})
</script>
<template>
  <div id="qr-code-full-region"></div>
</template>
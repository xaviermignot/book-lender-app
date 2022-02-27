<script setup lang="ts">
import { Html5QrcodeScanner } from 'html5-qrcode'
import {onMounted} from 'vue'

const props = defineProps({
  qrbox: Number,
  fps: Number
})

const emit = defineEmits<{
  (e: 'result', decodedText: String, decodedResult: String): void
}>()

function onScanSuccess(decodedText: String, decodedResult: String) {
  emit('result', decodedText, decodedResult);
}

onMounted(() => {
  var config = {
    fps: props.fps,
    qrbox: props.qrbox
  };

  var html5QrcodeScanner = new Html5QrcodeScanner("qr-code-full-region", config, true);
  html5QrcodeScanner.render(onScanSuccess, null);
})

</script>

<template>
  <div id="qr-code-full-region"></div>
</template>
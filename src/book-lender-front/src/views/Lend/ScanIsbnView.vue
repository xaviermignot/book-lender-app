<script setup lang="ts">
import QrCodeScanner from '../../components/QrCodeScanner.vue'
import MenuLinkButton from '../../components/MenuLinkButton.vue'

function onScan(decodedText: String, decodedResult: String) {
  console.log(`decodedText = ${decodedText}; decodedResult = ${decodedResult}`)
}
</script>

<template>
  <h1>Scan a book</h1>
  <QrCodeScanner :qrbox="250" :fps="10" @result="onScan"></QrCodeScanner>
  <MenuLinkButton to="/lend">Back</MenuLinkButton>
</template>

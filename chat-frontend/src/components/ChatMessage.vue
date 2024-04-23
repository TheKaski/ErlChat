<!--ChatMessage.vue
    This component act as the chat buble containing messgae text in a chatbubbletype of container
    Takes the message content in as prop
-->
<script>
export default {
  props: {
    message: {
        type: String,
        required: true
    }
  }
}
</script>

<template>
  <div class="chat-message">
      <p>{{ message }}</p>
  </div>
</template>


<style scoped>
.chat-message {
display: inline-block;
margin: 5px;
padding: 10px;
border-radius: 10px;
background-color: #cda5e5;
}
</style>
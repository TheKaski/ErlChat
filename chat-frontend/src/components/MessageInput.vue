<!--MessageInput.vue
    This component is responsible for acting as a input field responsible for sending new messages
    New messages can then be sent forward and displayed in the ChatMessages component
-->
<script>
export default {
  data() {
    return {
      message: ''
    }
  },
  methods: {
    sendMessage() {
      this.$emit('send-new-message', this.message);
      this.message = ''; // Clear input after posting
    }
  }
}
</script>

<template>
  <div>
    <input v-model="message" @keyup.enter="sendMessage" class="custom-input" placeholder="Write a new message">
  </div>
</template>

<style>
.custom-input {
  width: 40%; /* Set the width of the input field to cover about 40% of the container width */
  padding: 10px; /* Add padding for better appearance */
  font-size: 16px; /* Increase the font size for better readability */
  border: 1px solid #ccc; /* Add a border to the input field */
  border-radius: 5px; /* Add border radius for rounded corners */
}
</style>
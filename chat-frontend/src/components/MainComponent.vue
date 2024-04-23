<!-- main.vue
    This component contains all the other components used in this application
    Implementing a simple text based chat application
    This component will contain the following child components:
    - ChatMessages
    - ChatInputField
    - ...
-->
<script>
import ChatMessages from './ChatMessages.vue';
import MessageInput from './MessageInput.vue';

export default {
    data() {
        return {
            messages: []
        }
    },
    components: {
       ChatMessages,
       MessageInput
    },
    methods: {
        handleSendingNewMessage(msg) {
            // TODO: Give the message to ChatMessages to render it in the conversation
            this.messages.push(msg);
            // Use MessageHandler.vue to send the message payload
        }
  }
}
</script>

<template>
    <div class="container" >
        <ChatMessages :messages="this.messages"></ChatMessages>
        <div class="fixed-input">
            <MessageInput @send-new-message="handleSendingNewMessage"></MessageInput>
        </div>
    </div>

</template>

<style>
.container {
  height: 100vh; /* Set the height to 100% of the viewport height */
  display: flex;
  flex-direction: column;
}

.fixed-input {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  background-color: #414142;
  padding: 10px;
  box-shadow: 0px -4px 10px rgba(0, 0, 0, 0.1); /* Optional: Add a shadow to the input field */
}
</style>
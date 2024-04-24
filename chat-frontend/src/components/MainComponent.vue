<!-- main.vue
    This component contains all the other components used in this application
    Implementing a simple text based chat application
    This component will contain the following child components:
    - ChatMessages
    - ChatInputField
    - ...
-->
<script>
import MessageHandler from '../utils/MessageHandler.vue';
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
      MessageInput,
      MessageHandler
    },
    methods: {
        handleNewMessage(msg) {
            // Add the message to the messages list
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
            <MessageInput @send-new-message="handleNewMessage"></MessageInput>
        </div>
        <MessageHandler @received-new-message="handleNewMessage"></MessageHandler>
    </div>
</template>

<style>
.container {
  height: 100vh;
  display: flex;
  flex-direction: column;
  overflow: hidden; /* Prevent scrolling on the rest of the site */
}

.chat-messages {
  flex: 1; /* Allow ChatMessages to take up remaining vertical space */
  overflow-y: auto; /* Enable vertical scrolling within ChatMessages */
  padding-bottom: 60px; /* Add padding at the bottom for the input field */
}

.fixed-input {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  background-color: #454548;
  padding: 10px;
  box-shadow: 0px -4px 10px rgba(0, 0, 0, 0.1);
}

.fixed-input input {
  width: 40%;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 5px;
}
</style>
<!--ChatMessages.vue
    This component will be responsible for rendering the incoming messages and posted new messages
    It will use a childcomponent for rendering the messages in a list
-->
<script>
import ChatMessage from './ChatMessage.vue';
export default {
  props: {
    sentMessages: {
      type: Array
    },
    receivedMessages: {
      type: Array
    }
  },
  
  computed: {
    displayedSentMessages() {
      //Return updated copy of the messages prop
      return [...this.sentMessages];
    },
    displayedReceivedMessages() {
      //Return updated copy of the messages prop
      return [...this.receivedMessages];
    }
  },
  components:{
    ChatMessage
  },
  methods: {
  }
}
</script>

<template>
  <div class="chat-messages">
    <div class="messages-container">
      <ul class="messages-list received-messages">
        <li
          v-for="(msg, index) in displayedReceivedMessages" :key="index" class="message-item">
          <ChatMessage :message="msg" />
        </li>
      </ul>
      <ul class="messages-list sent-messages">
        <li
          v-for="(msg, index) in displayedSentMessages" :key="index" class="message-item">
          <ChatMessage :message="msg"/>
        </li>
      </ul>
    </div>
  </div>
</template>

<style>
.chat-messages {
  overflow-y: auto; /* Enable vertical scrolling within ChatMessages */
  flex: 1; /* Allow ChatMessages to take up remaining vertical space */
}

.messages-container {
  display: flex;
}


.messages-list {
  overflow-x: auto;
  list-style-type: none;
  padding-top: 10px;
  margin: 0;
}
.received-messages {
  flex: 1; /* Make the received messages list flexible to take remaining space */
}

.sent-messages {
  flex: 1; /* Make the sent messages list flexible to take remaining space */
}

.message-item {
  margin-bottom: 10px;
}
</style>

<!--ChatMessages.vue
    This component will be responsible for rendering the incoming messages and posted new messages
    It will use a childcomponent for rendering the messages in a list
-->
<script>
import ChatMessage from './ChatMessage.vue';
export default {
  props: {
    messages: {
      type: Array
    }
  },
  computed: {
    displayedMessages() {
      //Return updated copy of the messages prop
      return [...this.messages];
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
    <ul class="messages-list">
      <li
        v-for="(msg, index) in displayedMessages" :key="index" class="message-item">
        <ChatMessage :message="msg"/>
      </li>
    </ul>
  </div>
</template>

<style>
.chat-messages {
  overflow-y: auto; /* Enable vertical scrolling within ChatMessages */
  flex: 1; /* Allow ChatMessages to take up remaining vertical space */
}

.messages-list {
  list-style-type: none;
  padding-top: 10px;
  margin: 0;
}

.message-item {
  margin-bottom: 10px;
}
</style>

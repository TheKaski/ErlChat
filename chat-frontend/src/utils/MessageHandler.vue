<!--MessageHandler.vue
    This component is responsible for communicating with the backend chat server by using Websockets
-->
<script>
export default {
    props: {
    message: String // Define the message prop
    },
    data() {
        return {
            websocket: null
        }
    },
    mounted() {
        this.initWebSocket();
    },
    watch: {
        message(newVal, oldVal) {
            // Check if the message has changed and is not empty
            if (newVal !== oldVal && newVal !== '') {
                this.sendMessage(newVal);
            }
        }
    },
    methods: {
        initWebSocket() {
        // Initialize WebSocket connection
        this.websocket = new WebSocket('ws://localhost:8080/websocket');
            
        // Event listeners for WebSocket connection
        this.websocket.onopen = this.handleOpen;
        this.websocket.onmessage = this.handleMessage;
        this.websocket.onclose = this.handleClose;
        this.websocket.onerror = this.handleError;
        },
        handleOpen() {
            console.log('WebSocket connection established.');
        },
        sendMessage(msg) {
            // Check WebSocket ready state before sending message
            if (this.websocket.readyState === WebSocket.OPEN) {
              this.websocket.send(msg);
            } else {
              console.error('WebSocket is not open.');
            }
        },
        handleMessage(event) {
          this.$emit('received-new-message', event.data);
        },
        handleClose() {
            console.log('WebSocket connection closed.');
            // Reconnect WebSocket when closed
            setTimeout(() => {
                this.initWebSocket();
                }, 3000); // Reconnect after 3 seconds
        },
        handleError() {
          console.error('WebSocket error occurred.');
        }
    }
}
</script>
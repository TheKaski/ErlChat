<!--MessageHandler.vue
    This component is responsible for communicating with the backend chat server by using Websockets
-->
<script>
export default {
    data() {
        return {
            websocket: null
        }
    },
    mounted() {
        this.websocket = new WebSocket('ws://localhost:3000'); // Replace with your websocket server URL
        this.websocket.onmessage = this.handleMessage;
        this.websocket.onclose = this.handleClose;
        this.websocket.onerror = this.handleError;
    },
    
    methods: {
        sendMessage(msg) {
            this.websocket.send(msg);
        },
        handleMessage(event) {
          this.$emit('received-new-message', event.data);
        },
        handleClose() {
          console.log('Connection closed.');
        },
        handleError() {
          console.error('WebSocket error occurred.');
        }
    }
}
</script>
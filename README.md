# ErlChat - Erlang based Chat Application with Vue.js Frontend
This project is a learning oriented project for my portfolio to combine
understanding of frontend technology with communication and distributed systems with Erlang.

This repository contains code for frontend and backend. The Frontend is implemented using Vue.JS and allows clients
to directly talk with the erlang backend server. The backend server is implemented using Erlang and its main purpose is to work as a chat server. The backend server is responsible for routing the messages
between the clients as real time as possible.

## Learning areas of this project
    - Erlang
    - Vue.js
    - WebSockets

### Erlang?
Erlang is a language created originally by Ericsson AB for telecommunication purposes where highly concurrent, but fault tolerant systems were required.
Since then Erlang is known to be used by e.g. WhatsApp and Klarna to develop robust fault-tolerant systems with high availability.

## My implementation
This repository contains code for hosting frontend and backend servers separately. The Frontend is implemented using Vue.js and allows clients to directly talk with the Erlang backend server as a message relay. The backend server is implemented using Erlang and its main purpose is to work as a message relay or broadcaster using websockets as the communication method. The erlang server is responsible for routing the messages
between all the connected clients as real time as possible. As this project is a smaller side project combining my knowledge between different technologies the code will not contain any user registration or loging in meaning that it will only work as open ""anonymous"" chat room.
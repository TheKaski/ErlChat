# Erlang backend server for broadcasting messages
This REAMDE file contains small documentation for the structure of this Erlang based backend server and how to use this.
This implementation uses the Cowboy library to create a websocket server to allow duplex communication between clients and the server.
When clients connect to the server via the websocket a new process is spawned for each client with Erlangs highly concurrent processing model. Statemanager process keeps a record of connected client processes which allows the broadcasting of messages from one client to all the other clients. When connections are terminated clients are removed from the record.

## How to run
You can start the Erlang server using the predefined MakeFile with predefined commands for compiling, running and cleaning the build.
The MAKEFILE uses the predefined rebar3 commands which you can also use once you have installed the rebar3 software. The Makefile makes it easier to run the program with the correct library variables predefined avoiding potential errors when running this code.

To have a clean build you can run:
```Make clean```

To compile the project you can run:
```Make compile```

To run the compiled server:
```Make run```

## Structure
1. backend_app.erl
2. backend_sup.erl
3. handler.erl
4. state_manager.erl

### 1. backend_app.erl
This file contains the application code mainly created by rebar3 when initializing a new application project.
This code is responsible for creating a new websocket server using cowboy library and give the handler.erl module for it to handle the connections. This code is also responsible for starting the  supervision tree handled by backend_sup.erl

### 2. backend_sup.erl
This file contains code for the supervision tree which is responsible for monitoring other worker processes, in this case the application and the State manager processes. The supervisor module allows to use multiple different parameters to handle to worker processes, but for this application the default values were used.

### 3. handler.erl
This code handles the initialization of websocket connection and handles all the messages sent and received. It communicates with the state manager over API endpoints to add or remove the client from connected clients or broadcast messages from the client to other connected clients.

### 4. state_manager.erl
This code keeps a record of connected clients. It uses the gen_server structure to create API endpoints for other processes such as the handler.erl to add or remove their clients based on the status of their connection. This API also allows to directly broadcast messages to other connected clients.





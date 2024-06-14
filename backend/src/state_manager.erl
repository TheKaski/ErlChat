-module(state_manager).
-behaviour(gen_server).
% This module handles a shared state between clientPIDs to broadcast messages between clients

%% Export
-export([start_link/0, add_client/1, remove_client/1, get_clients/0, broadcast_message/2]).

-record(state, {
    clients = []  % List to store connected client PIDs
}).

%% gen_server 
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

%% API 
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

add_client(ClientPid) ->
    gen_server:call(?MODULE, {add_client, ClientPid}).

remove_client(ClientPid) ->
    gen_server:call(?MODULE, {remove_client, ClientPid}).

get_clients() ->
    gen_server:call(?MODULE, get_clients).

broadcast_message(ClientPid, Data) ->
    gen_server:cast(?MODULE, {broadcast_message, ClientPid, Data}).

%% gen_server
init([]) ->
    {ok, #state{clients = []}}.

handle_call({add_client, ClientPid}, _From, State) ->
    NewState = State#state{clients = [ClientPid | State#state.clients]},
    {reply, ok, NewState};

handle_call({remove_client, ClientPid}, _From, State) ->
    NewState = State#state{clients = lists:delete(ClientPid, State#state.clients)},
    {reply, ok, NewState};

handle_call(get_clients, _From, State) ->
    {reply, State#state.clients, State}.

handle_cast({broadcast_message, SenderPid, Data}, #state{clients = Clients} = State) ->
    TargetClients = lists:filter(fun(ClientPid) -> ClientPid =/= SenderPid end, Clients),

    % Broadcast the message to all other currently connected clients:
    lists:foreach(
        fun(ClientPid)->
            ClientPid ! {broadcast, Data}
        end,
        TargetClients
    ),
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.
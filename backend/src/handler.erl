-module(handler).
-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).
-export([terminate/3]).
-export([ws_send/2]).

-record(state, {
    clients = []  % List to store connected client PIDs used for broadcasting messages
}).

init(Req, State) ->
    io:format("websocket connection initiated~n~p~n~nstate: ~p~n", [Req, State]),
    %% Update the state to add the client's PID
    {cowboy_websocket, Req, #state{clients = []}}.

websocket_init(_Opts) ->
    ClientPid = self(),
    State = _Opts,
    io:format("Adding the client pid ~p to the state~n", [ClientPid]),
    NewState = State#state{clients = [ClientPid | State#state.clients]},
    {ok,  NewState}.

%% Handle incoming WebSocket messages and broadcast to other clients
websocket_handle({text, Data}, State) ->
    io:format("WebSocket data from client: ~p with state: ~p~n", [Data, State]),
    broadcast_message(Data, State),
    {ok, State};

websocket_handle(_Data, State) ->
    {ok, State}.

broadcast_message(Data, State) ->
    io:format("BROADCASTING MESSAGE ~p to ~p~n", [Data, State]),
    SenderPid = self(),
    %% Extract connected client PIDs from the state
    Clients = State#state.clients,
    %% Send the message to each connected client
    lists:foreach(
        fun(ClientPid) ->
            if % Broadcast the message to all the other clients listed in the 
                ClientPid =/= SenderPid ->
                    ClientPid ! {broadcast, Data};
                true ->
                    ok
            end
        end,
        Clients
    ).

websocket_info({broadcast,Data}, State ) ->
    {reply, {text, Data}, State};

websocket_info(_Info, State) ->
    {ok, State}.

ws_send(Pid,SInterval) -> 
    Data = memsup:get_system_memory_data(),
    {cowboy, _CowboyD, CowboyV} = lists:keyfind(cowboy, 1, application:which_applications()),
    Data_jsonb = jiffy:encode({Data ++ [{otp_release, list_to_integer(erlang:system_info(otp_release))}] ++ [{cowboy_version, list_to_binary(CowboyV)}] ++ [{system_time, erlang:system_time()}] ++ [{pid, list_to_binary(pid_to_list(self()))}]}),
    erlang:start_timer(SInterval, Pid, Data_jsonb).

terminate(_Reason, Req, _State) ->
    io:format("websocket connection terminated~n~p~n", [maps:get(peer, Req)]),

    ok.
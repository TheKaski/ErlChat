-module(handler).
-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).
-export([terminate/3]).
-export([ws_send/2]).

init(Req, State) ->
    io:format("websocket connection initiated~n~p~n~nstate: ~p~n", [Req, State]),
    %% Update the state to add the client's PID
    {cowboy_websocket, Req, State}.

websocket_init(State) ->
    ClientPid = self(),
    
    % Add this client to the connected client state
    state_manager:add_client(ClientPid),
    {ok,  State}.

%% Handle incoming WebSocket messages and broadcast to other clients
websocket_handle({text, Data}, State) ->
    io:format("WebSocket data from client: ~p with state: ~p~n", [Data, State]),
    broadcast_message(Data, State),
    {ok, State};

websocket_handle(_Data, State) ->
    {ok, State}.

broadcast_message(Data, State) ->
    io:format("BROADCASTING MESSAGE ~p", [Data]),
    SenderPid = self(),
    state_manager:broadcast_message(SenderPid, Data).

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
    % Remove this client from the list of connected clients:
    state_manager:remove_client(self()),
    ok.
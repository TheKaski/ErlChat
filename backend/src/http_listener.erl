-module(http_listener).
-behaviour(cowboy_http_protocol).

-export([init/2]).

init(_Transport, Req) ->
    {ok, Req, undefined}.
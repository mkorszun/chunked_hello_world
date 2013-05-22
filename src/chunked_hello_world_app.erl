%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(chunked_hello_world_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", hello_world_handler, []},
            {"/chunked", chunked_hello_world_handler, []}
        ]}
    ]),
    {ok, _} = cowboy:start_http(http, 100, [{port, list_to_integer(os:getenv("PORT"))}], [
        {env, [{dispatch, Dispatch}]}
    ]),
    chunked_hello_world_sup:start_link().

stop(_State) ->
    ok.

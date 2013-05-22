%% Feel free to use, reuse and abuse the code in this file.

%% @doc Chunked hello world handler.
-module(chunked_hello_world_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {ok, Req2} = cowboy_req:chunked_reply(200, Req),
    ok = cowboy_req:chunk("Hello\r\n", Req2),
    ok = timer:sleep(1000 * env("CHUNKED_TIMEOUT1")),
    ok = cowboy_req:chunk("World\r\n", Req2),
    ok = timer:sleep(1000 * env("CHUNKED_TIMEOUT2")),
    ok = cowboy_req:chunk("Chunked!\r\n", Req2),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.

env(E) ->
    case os:getenv(E) of
        V when is_list(V) ->
            try list_to_integer(V) of
                T -> T
            catch
                _:_ -> default(E)
            end;
        _ ->
            default(E)
    end.

default("CHUNKED_TIMEOUT1") -> 50;
default("CHUNKED_TIMEOUT2") -> 70.

-module(server).
-export([start/0]).

start() ->
    application:start(chumak),
    {ok, Socket} = chumak:socket(rep, "hello world server"),
    {ok, _BindPid} = chumak:bind(Socket, tcp, "localhost", 5555),
    io:format("Server started on port 5555~n"),
    loop(Socket).

loop(Socket) ->
    Reply = chumak:recv(Socket),
    io:format("Received: ~p~n", [Reply]),
    chumak:send(Socket, <<"OK">>),
    loop(Socket).

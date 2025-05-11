-module(todo_app).
-export([start/0, run_demo/0]).

start() ->
    todo_command_handler:start_link(),
    todo_query_handler:start_link().

run_demo() ->
    start(),
    todo_command_handler:add_task(1, "Milch kaufen"),
    todo_command_handler:add_task(2, "Hausaufgaben machen"),
    todo_command_handler:complete_task(1),
    timer:sleep(1000), % simulate async delay
    io:format("~nAbfrage (CQRS - Query):~n"),
    Task1 = todo_query_handler:get_task(1),
    Task2 = todo_query_handler:get_task(2),
    io:format("Task 1: ~p~n", [Task1]),
    io:format("Task 2: ~p~n", [Task2]).

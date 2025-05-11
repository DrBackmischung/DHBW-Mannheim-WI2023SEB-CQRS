-module(todo_command_handler).
-behaviour(gen_server).

%% API
-export([start_link/0, add_task/2, complete_task/1]).
%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-import(todo_query_handler, [update_task/2]).

-record(state, {tasks = #{}}).

%%% API
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

add_task(Id, Desc) ->
    gen_server:cast(?MODULE, {add_task, Id, Desc}).

complete_task(Id) ->
    gen_server:cast(?MODULE, {complete_task, Id}).

%%% Callbacks
init([]) ->
    {ok, #state{}}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast({add_task, Id, Desc}, State = #state{tasks = Tasks}) ->
    Task = #{desc => Desc, done => false},
    NewTasks = maps:put(Id, Task, Tasks),
    update_task(Id, Task),
    io:format("Task ~p added.~n", [Id]),
    {noreply, State#state{tasks = NewTasks}};
    
handle_cast({complete_task, Id}, State = #state{tasks = Tasks}) ->
    case maps:get(Id, Tasks, undefined) of
        undefined ->
            io:format("Task ~p not found.~n", [Id]),
            {noreply, State};
        Task ->
            UpdatedTask = Task#{done => true},
            UpdatedTasks = maps:put(Id, UpdatedTask, Tasks),
            update_task(Id, UpdatedTask),
            io:format("Task ~p marked as complete.~n", [Id]),
            {noreply, State#state{tasks = UpdatedTasks}}
    end.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

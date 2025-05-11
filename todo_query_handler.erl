-module(todo_query_handler).
-behaviour(gen_server).

%% API
-export([start_link/0, get_task/1, update_task/2]).
%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {tasks = #{}}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

get_task(Id) ->
    gen_server:call(?MODULE, {get_task, Id}).

update_task(Id, Task) ->
    gen_server:cast(?MODULE, {update_task, Id, Task}).

init([]) ->
    {ok, #state{}}.

handle_call({get_task, Id}, _From, State = #state{tasks = Tasks}) ->
    Task = maps:get(Id, Tasks, undefined),
    {reply, Task, State}.

handle_cast({update_task, Id, Task}, State = #state{tasks = Tasks}) ->
    NewTasks = maps:put(Id, Task, Tasks),
    {noreply, State#state{tasks = NewTasks}}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

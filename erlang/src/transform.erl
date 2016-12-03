-module(transform).
-export([leet/1, map2php/0, map2ruby/0]).
%-export([printLeet/1, leet/1, map2php/0]). %
printExplode(Word) ->
  {ok, IoDevice} = file:open(Word ++ ".txt", [write]),
  explode(IoDevice,"","",preleet(Word)),
  file:close(IoDevice),
  ok.

explode(IoDevice,Word) ->
  explode(IoDevice,"","",preleet(Word)).

explode(IoDevice,Char,Buffer,[]) ->
  io:format(IoDevice,"~s~n",[lists:reverse(Char ++Buffer)]);
explode(IoDevice,Char,Buffer,[H|T]) ->
  [explode(IoDevice,X,Char ++ Buffer, T) || X <- H].


% no redirectionable output
leet(Word) ->
  leet2("","",preleet(Word)).

leet2(Char,Buffer,[]) ->
  io:format("~s~n",[lists:reverse(Char ++Buffer)]);
leet2(Char,Buffer,[H|T]) ->
  [leet2(X,Char ++ Buffer, T) || X <- H].

% fast but memory hungry
printLeetFoldl(Word) ->
  {ok, IoDevice} = file:open(Word ++ ".txt", [write]),
  file:write(IoDevice, [X ++"\n" || X <-leet(Word)]),
  file:close(IoDevice),
  ok.
  
%
leetFoldl(Word)->
  lists:foldl(
    fun (Elem, List) ->
    [ string:concat(X,E) || X <- List, E <-Elem ] end,
    hd(preleet(Word)), tl(preleet(Word) )).

map() -> [
    {"0",["0","o","O"]},
    {"1",["1","i","I","l","L"]},
    {"2",["2","z","Z"]},
    {"3",["3","e","E"]},
    {"4",["4","a","A"]},
    {"5",["5","s","S","5","$"]},
    {"6",["6","g","G"]},
    {"7",["7","t","T"]},
    {"8",["8","b","B"]},
    {"9",["9","g","G"]},
    {"a",["a","A","4","@"]},
    {"b",["b","B","8"]} ,
    {"c",["c","C","("]},
    {"d",["d","D"]},
    {"e",["e","E","3"]},
    {"f",["f","F"]},
    {"g",["g","G","6","9"]},
    {"h",["h","H"]},
    {"i",["i","I","1","!"]},
    {"j",["j","J"]},
    {"k",["k","K"]},
    {"l",["l","L","1"]},
    {"m",["m","M"]},
    {"n",["n","N"]},
    {"o",["o","O","0"]},
    {"p",["p","P"]},
    {"q",["q","Q"]},
    {"r",["r","R"]},
    {"s",["s","S","5","$"]},
    {"t",["t","T","7","+"]},
    {"u",["u","U"]},
    {"v",["v","V"]},
    {"w",["w","W"]},
    {"x",["x","X"]},
    {"y",["y","Y"]},
    {"z",["z","Z","2"]}
].

map2ruby() ->
  io:format("map = {~n"),
  [ io:format( "~p => ~p,~n",[Char,List]) || {Char, List} <- map() ],
  io:format("}~n").

map2php() ->
  io:format("$map = array(~n"),
  [ printKV(Char,List) || {Char, List} <- map() ],
  io:format(");~n").
 % [ io:format( "~p=> array(~p),~n",[Char,]) || {Char, List} <- map() ].
  


printValues([H|[]]) ->
  "'" ++ H ++ "'";
printValues([H|T]) ->
  "'" ++ H ++ "', " ++ printValues(T).

printKV(Key,Values) ->
  Line = "\"" ++ Key ++ "\" => array("++ printValues(Values) ++ "),",
  io:format("~s~n",[Line]).



%%
preleet([]) -> [];
preleet([Head|Tail]) -> [ find([Head], map()) | preleet(Tail) ].

%% why it does not work?
%preleet2(Word) -> [ [ find(X, map()) ] || X <- Word ].


% Returns the list of combinations if found, else the element
find(What,[{What,Variations}|_]) -> Variations;
find(What,[{_,_}|Tail])  -> find(What,Tail);
find(What,[]) -> [What].


%% Returns complexity for a given preleet
% public
measure([]) -> 0;
measure(What) -> measure(What,1).
% private
measure([],Total) -> Total;
measure([Load|Tail],Total) -> measure(Tail, length(Load) * Total).



  

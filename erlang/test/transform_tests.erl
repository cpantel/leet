-module(transform_tests).
-include_lib("eunit/include/eunit.hrl").

empty_map() -> [].

map() -> [
    {"a",["a","A","4","@"]},
    {"b",["b","B"]} ,
    {"c",["c","C","("]}
  ].


leet_a_test() ->
  ?assertEqual(["a","A","4","@"],transform:leet("a")).
leet_aa_test() ->
  ?assertEqual(["aa","aA","a4","a@","Aa","AA","A4","A@","4a","4A","44","4@","@a","@A","@4","@@"],transform:leet("aa")).
leet_bc_test() ->
  ?assertEqual(["bc","bC","b(","Bc","BC","B(","8c","8C","8("],transform:leet("bc")).


preleet_nothing_test()->
  ?assertEqual([],transform:preleet("")).
 
preleet_one_simple_char_test()->
  ?assertEqual([[";"]],transform:preleet(";")).

preleet_one_complex_char_test()->
  ?assertEqual([["b","B","8"]],transform:preleet("b")).

preleet_many_mixed_char_test()->
  ?assertEqual([["a","A","4","@"],[";"],["b","B","8"]],transform:preleet("a;b")).



measure_empty_test()->
  ?assertEqual(0,transform:measure([])).

measure_one_element_size_one_test()->
  ?assertEqual(1,transform:measure([["1"]])).

measure_one_element_size_two_test()->
  ?assertEqual(2,transform:measure([["b","B"]])).

measure_two_elements_size_one_test()->
  ?assertEqual(1,transform:measure([["b"],["B"]])).

measure_two_elements_size_two_test()->
  ?assertEqual(4,transform:measure([["b","B"], ["a","A"]])).

measure_arbitrary4_test()->
  ?assertEqual(4,transform:measure([["b","B"], ["c"],["a","A"]])).

measure_arbitrary8_test()->
  ?assertEqual(8,transform:measure([["b","B"], ["c"],["a","A","4","@"]])).


find_a_in_empty_map_test()->
  ?assertEqual(["a"],transform:find("a",empty_map())).


find_a_in_map_first_test()->
  Map = [ { "a", [ "a", "A", "4", "@"] }, {"b", ["b","B"]} , {"c",["c","C","("]}],
  ?assertEqual([ "a", "A", "4", "@"],transform:find("a",Map)).

find_a_in_map_last_test()->
  Map = [ {"b", ["b","B"]} , {"c",["c","C","("]}, { "a", [ "a", "A", "4", "@"] } ],
  ?assertEqual([" "],transform:find(" ",Map)).

find_a_in_map_with_only_a_test()->
  Map = [ { "a", [ "a", "A", "4", "@"] }],
  ?assertEqual(["a","A", "4", "@"],transform:find("a", Map)).

find_something_in_map_without_something_test()->
  Map = [ {"b", ["b","B"]} , {"c",["c","C","("]}],
  ?assertEqual([";"],transform:find(";",Map)).



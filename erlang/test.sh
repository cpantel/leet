erlc -o ebin/ src/*.erl test/*.erl

echo " eunit:test(transform,[verbose])."

erl -pa ebin/


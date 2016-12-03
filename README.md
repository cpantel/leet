# leet
Leet generator in several languages

Generates all the leet combinations of a given word.

Adjust the basemap hash to reduce or extend the combinations.

Keep in mind that "myleetpassword" generates 1327104 combinations  and "myprettyleetpassword" 509,607,936 combinations and takes about half an hour on a 2.40GHz core

Well, that's what the ruby metasploit implementation says, it's an old project, 2012, I really don't remember anything.

The ruby version is a lot faster than the php one. Erlang is faster than ruby, but the overhead of loading the vm makes it slower when working with short strings.



## php
It works, just run:
```bash
php generate.php "hello"
```
## ruby
It works, just run:
```bash
./generate.rb "hello"
```
## metasploit

There are three versions. Seems that when I proposed it someone disliked my un-perlish way of programming ruby. I am not sure if it works.


## erlang

The tests are not running but I am sure that they used to run...

### the shell
```bash
cd src
erl
c(transform).
transform:leet("hello").
hello
hellO
hell0
helLo
helLO
helL0
...
```

### the command line
```bash
erlc -o ebin/ src/*.erl
cd ebin
erl -noshell -run transform leet "hello"  -run init stop
```

It has two useful functions, map2php/0 and map2ruby/0 that export the hash to these lenguages.



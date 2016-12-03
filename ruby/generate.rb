#!/usr/bin/ruby

def emit(level, buffer) 
	if level >= @permArray.length
		print buffer + "\n"
		return
	end
	@permArray[level].each do |char|
		emit(level + 1, buffer + char)
	end
end


=begin
TODO
   Add support for an input stream, 

=end

if ARGV.length == 1 then
	words = ARGV[0].downcase
	fix_stdout = false
elsif ARGV.length == 2 then
	words = ARGV[0].downcase
	orig_stdout = $stdout.clone
	fix_stdout = true
	$stdout.reopen(ARGV[1], "w")
else
	warn "Usage: #{$0} word [output file]"
	exit
end


basemap = {
	"0"=> ["0","o","O"],
	"1"=> ["1","i","I","l","L"],
	"2"=> ["2","z","Z"],
	"3"=> ["3","e","E"],
	"4"=> ["4","a","A"],
	"5"=> ["5","s","S","5","$"],
	"6"=> ["6","g","G"],
	"7"=> ["7","t","T"],
	"8"=> ["8","b","B"],
	"9"=> ["9","g","G"],
	"a"=> ["a","A","4","@"],
	"b"=> ["b","B","8"],
	"c"=> ["c","C","("],
	"d"=> ["d","D"],
	"e"=> ["e","E","3"],
	"f"=> ["f","F"],
	"g"=> ["g","G","6","9"],
	"h"=> ["h","H"],
	"i"=> ["i","I","1","!"],
	"j"=> ["j","J"],
	"k"=> ["k","K"],
	"l"=> ["l","L","1"],
	"m"=> ["m","M"],
	"n"=> ["n","N"],
	"o"=> ["o","O","0"],
	"p"=> ["p","P"],
	"q"=> ["q","Q"],
	"r"=> ["r","R"],
	"s"=> ["s","S","5","$"],
	"t"=> ["t","T","7","+"],
	"u"=> ["u","U"],
	"v"=> ["v","V"],
	"w"=> ["w","W"],
	"x"=> ["x","X"],
	"y"=> ["y","Y"],
	"z"=> ["z","Z","2"],
}

words.split(" ").each do |word|
	map = basemap
	word.split("").each do |char|
		if ! map.has_key?(char) then
			map[char]=char
		end 
		if nil == map[char].index(char.upcase ) then
			map[char].insert(char.upcase)
		end
		if nil == map[char].index(char) then
			map[char].insert(char)
		end
	end

	idx = 0
	@permArray = Array.new()
	word.split("").each do |char|
		@permArray[idx] = map[char]
		idx += 1
	end

	emit(0,'');
end

if fix_stdout then
	$stdout.reopen orig_stdout
end

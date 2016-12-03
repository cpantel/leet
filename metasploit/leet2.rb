require 'msf/core'

class Metasploit3 < Msf::Auxiliary
	def initialize
		super(
			'Name'	=> 'Leet generator',
			'Description' => %q{Generates all the leet combinations of a given word worD woRd woRD wOrd wOrD wORd wORD w0rd w0rD w0Rd w0RD Word WorD WoRd WoRD WOrd WOrD WORd WORD W0rd W0rD W0Rd W0RD
						Adjust the basemap hash to reduce or extend the combinations.
						Keep in mind that "myleetpassword" generates 1327104 combinations
						and "myprettyleetpassword" 509,607,936 combinations and takes about half an hour on a 2.40GHz core
				},
			'Author'	=> [ 'Carlos Pantelides <carlos_pantelides[at]yahoo.com>' ],
			'License'	=> MSF_LICENSE,
			'Version'	=> '$Revision: 1 $'
			
		)
		register_options([
			OptString.new('WORDLIST', [ false, "Source list",""]),
			OptString.new('WORDS', [ false, "Word(s) to leet",""]),
			OptString.new('OUTPUTFILE', [ false, "Output file",""])
		], self.class)
	end
	def emit(level, buffer) 
		if level >= @permArray.length
			@output.print buffer + "\n"
			return
		end
		@permArray[level].each do |char|
			emit(level + 1, buffer + char)
		end
	end
	
	def run()
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
		
		words = datastore['WORDS']
		wordlist = datastore['WORDLIST']
		outputfile = datastore['OUTPUTFILE']
		
		if words.length == 0 && wordlist.length == 0 then
			print_error("Define WORDS or WORDLIST")
			return
		end
		
		if words.length != 0 && wordlist.length != 0 then
			print_error("Define only WORDS or WORDLIST")
			return
		end
		
		if wordlist.length == 0 then
			input = Array.new()
			words.split(" ").each do |word|
				input.push(word)
			end
		else 
			if ! File.readable?(wordlist) then
				print_error("#{wordlist} not readable")
				return
			end
			puts "FILE"
			input = open(wordlist,"r")
		end
		
		
		if outputfile.length == 0 then
			@output = $stdout
		else
			begin
				@output = open(outputfile, "w")
			rescue
				print_error("Could not open #{outputfile} for writing")
				return
			end
			
		end
		
		input.each do |word|
			word = word.chomp
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

		if wordlist.length != 0 then
			input.close
		end

		if outputfile.length != 0 then
			@output.close
		end
	end
end
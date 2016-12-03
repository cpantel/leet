require 'msf/core'

class Metasploit3 < Msf::Auxiliary
  def initialize
    super(
      'Name'  => 'Leet generator',
      'Description' => %q{Generates all the leet combinations of a given word
            Adjust the basemap hash to reduce or extend the combinations.
            Keep in mind that "myleetpassword" generates 1327104 combinations
            and "myprettyleetpassword" 509,607,936 combinations and takes about half an hour on a 2.40GHz core
        },
      'Author'  => [ 'Carlos Pantelides <carlos_pantelides[at]yahoo.com>'],
      'License' => MSF_LICENSE,
      'Version' => '$Revision$'
    )
    register_options([
      OptString.new('WORDLIST', [ false, "Source list",""]),
      OptString.new('WORDS', [ false, "Word(s) to leet",""]),
      OptBool.new('PRINT', [ false, "Print generated words",true]),
      OptString.new('OUTPUTFILE', [ false, "Output to file",""])
      
    ], self.class)
  end

  def emit(level, buffer, perm_array)
    return tee_output("#{buffer}") if level >= perm_array.length
    perm_array[level].each { |char| emit(level + 1, buffer + char, perm_array) }
  end

  def tee_output(string, file=nil)
    file = datastore['OUTPUTFILE']
    print = datastore['PRINT']
    
    File.open(file, "wb").puts(string) if (file != "") && File.writable?(file)
    print_status string.to_s if print
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

    # Grab the options
    word_list = datastore['WORDLIST']
    words = datastore['WORDS']

    # Make sure that one of the options is set
    return print_error("Define WORDS or WORDLIST") if words.length == 0 && word_list.length == 0

    # Get the words
    input = []
    if word_list.length != 0
      # Handle the case of both WORDLIST and WORDS being defined
      print_status("Both WORDS and WORDLIST defined, using WORDLIST") unless words.length == 0
      return print_error("#{word_list} not readable") unless File.readable? wordlist
      # But regardless, read the file if it's readable
      File.open(word_list).read.split(" ").each { |word| input << word }
    else # just grab the words
      input = words.split(" ")
    end
    
    # hop through the input words, a'manglin as we go
    input.each do |word|
      word.chomp!
      map = basemap

      word.split("").each do |char| # char by char
        # add a key entry to the map unless we already have it
        map[char] = char unless map.has_key?(char)
        # insert an uppercase, unless we already have it
        map[char].insert(char.upcase) if map[char].index(char.upcase) == nil
        # insert the entry as part of its own key unless we already have it
        map[char].insert(char) if map[char].index(char) == nil
      end

      # Walk through the current word, adding the possible set of chars
      # to the perm_array. this will be used to recursively generate
      # combinations with the emit function.
      index = 0
      perm_array = []
      word.split("").each do |char|
        perm_array[index] = map[char]
        index += 1
      end

    # Recursively generate combinations
    emit(0,"", perm_array)
    end
  end
end

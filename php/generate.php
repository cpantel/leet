<?php

$base = strtolower($argv[1]);

$extendedMap = array(
	'f'=> array('ph'),
	'n'=> array('|\|'),
	'r'=> array('|2'),
	'u'=> array('\_/'),
);

$map = array(
	"0" => array('0', 'o', 'O'),
	"1" => array('1', 'i', 'I', 'l', 'L'),
	"2" => array('2', 'z', 'Z'),
	"3" => array('3', 'e', 'E'),
	"4" => array('4', 'a', 'A'),
	"5" => array('5', 's', 'S', '5', '$'),
	"6" => array('6', 'g', 'G'),
	"7" => array('7', 't', 'T'),
	"8" => array('8', 'b', 'B'),
	"9" => array('9', 'g', 'G'),
	"a" => array('a', 'A', '4', '@'),
	"b" => array('b', 'B', '8'),
	"c" => array('c', 'C', '('),
	"d" => array('d', 'D'),
	"e" => array('e', 'E', '3'),
	"f" => array('f', 'F'),
	"g" => array('g', 'G', '6', '9'),
	"h" => array('h', 'H'),
	"i" => array('i', 'I', '1', '!'),
	"j" => array('j', 'J'),
	"k" => array('k', 'K'),
	"l" => array('l', 'L', '1'),
	"m" => array('m', 'M'),
	"n" => array('n', 'N'),
	"o" => array('o', 'O', '0'),
	"p" => array('p', 'P'),
	"q" => array('q', 'Q'),
	"r" => array('r', 'R'),
	"s" => array('s', 'S', '5', '$'),
	"t" => array('t', 'T', '7', '+'),
	"u" => array('u', 'U'),
	"v" => array('v', 'V'),
	"w" => array('w', 'W'),
	"x" => array('x', 'X'),
	"y" => array('y', 'Y'),
	"z" => array('z', 'Z', '2'),
);

$baseArray = str_split($base,1);

foreach ($baseArray as $char) {
	if (!isset($map[$char])) {
		$map[$char][]=$char;
	}
	if (! in_array(strtoupper($char) ,$map[$char] )) {
		$map[$char][]=strtoupper($char);
	}
	if (! in_array($char ,$map[$char] )) {
		$map[$char][]=$char;
	}

}

foreach ($baseArray as $pos=>$char) {
	$permArray[$pos]=$map[$char];
}

emit($permArray,0,'');

function emit(array $permArray, $level, $buffer) {
	if ($level >= count($permArray)) {
		echo "$buffer\n";
		return;
	}
	
	foreach ($permArray[$level] as $char) {
		emit($permArray, $level + 1, "$buffer$char");
	}
	
}




class Jawna

	def initialize(text)
		@text = text
	end

	def to_s
		@text
	end

	def zaszyfruj(klucz)
		a = ""
		for i in 0..@text.length-1
			a += klucz[@text[i]]
		end
		return Zaszyfrowane.new(a)
	end
end

class Zaszyfrowane

	def initialize(text)
		@text = text
	end

	def to_s
		@text
	end

	def odszyfruj(klucz)
		a = ""
		for i in 0..@text.length-1
			a += klucz[@text[i]]
		end
		return Jawna.new(a)
	end
end

klucz1 = {
'a' => 'b',
'b' => 'r',
'r' => 'y',
'y' => 'u',
'u' => 'a',
}

klucz2 = {
'b' => 'a',
'r' => 'b',
'y' => 'r',
'u' => 'y',
'a' => 'u',
}



x = Jawna.new("ruby")
puts x
y = x.zaszyfruj(klucz1)
puts y
puts y.odszyfruj(klucz2)
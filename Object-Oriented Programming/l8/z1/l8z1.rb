class Fixnum

	def czynniki
		tablicaCzynnikow = Array.new
		for i in 1...self+1
		  if self % i == 0
			tablicaCzynnikow.push(i)
		  end
		end
		tablicaCzynnikow
	end

	def ack(m)
		return m+1 if self == 0
		return (self-1).ack(1) if m == 0
		return (self-1).ack(self.ack(m-1))
	end

	def doskonala
		sum = -self
		for x in self.czynniki
			sum += x
		end
		return sum == self
	end

	def slownie
		tab = ["zero", "jeden", "dwa", "trzy", "cztery", "piec", "szesc", "siedem", "osiem", "dziewiec"]
		return "" if self == 0
		return (self/10).slownie + tab[self%10] + " "
	end

end

puts "czynniki 7: "
puts 7.czynniki
puts "czynniki 6: "
puts 6.czynniki
puts "doskonale dla 6, 28, 32: "
puts 6.doskonala
puts 28.doskonala
puts 32.doskonala
puts "123 i 10 slownie: "
puts 123.slownie
puts 10.slownie
puts "ack(2,1): #{2.ack(1)}"

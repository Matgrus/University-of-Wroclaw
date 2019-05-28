class Proc

	def value(x)
		self.call(x)
	end

	def zerowe(a, b, e)
		x = (a+b)/2.0
		val = value(x)

		if val.abs < e
			return x
		else
			left = value(a)
			right = value(b)

			if left < 0 and val > 0
				return zerowe(a,x,e)
			elsif left > 0 and val < 0
				return zerowe(a,x,e)
			elsif right > 0 and val < 0
				return zerowe(x,b,e)
			elsif right < 0 and val > 0
				return zerowe(x,b,e)
			elsif value == 0 
				return x
			else
				nil
			end
		end
	end

	def poch(x)
		h = 0.00001
		return (0.0+value(x+h)-value(x))/h
	end

	def pole(a, b)
		sn = 0.0
		n = 1000
		h = (b-a)/n
	
		for i in 1..n
			yi = value(a + (i-1)*h)
			yi /= 2 if i == 1 or i == n
			sn += h*yi
		end
		return sn
	end
  
    def rysuj(a, b, nazwa)
      file = File.open(nazwa, "w")        
      for i in a..b
            file.puts i.to_s + " " + value(i).to_s 
        end       
        file.close
    end

end

f = proc { |x| x*x + 3*x - 4 }

puts "f(2) = ", f.value(2)
puts "miejsce zerowe na przedziale [-100,100] : ", f.zerowe(-100, 100, 0.00001)
puts "pochodna w x = 0: ", f.poch(0)
puts "calka na przedziale [-10, 10] : ", f.pole(-10.0, 10.0)

f.rysuj(-100, 100, "plik.dat")
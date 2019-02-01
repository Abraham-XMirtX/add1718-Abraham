if ARGV.size != 1 
  puts "Tienes que poner un argumentos"
  exit
end
  
fichero = ARGV[0]
content = `cat #{fichero}`
lines = content.split("\n")
		
lines.each do |line|
   data = line.split(" ")
   num1 = data[0].to_i
   op = data[1]
   num2 = data[2].to_i 

   if op == "+"
      result = num1 + num2
   elsif op == "-"
      result = num1 - num2
   elsif op == "x"
      result = num1 * num2
   elsif op == "/"
      result = num1 / num2
   end
   puts "El resultado de #{num1} #{op} #{num2} es #{result}"
end

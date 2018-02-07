
if ARGV.size != 1 
  puts "Tienes que poner un argumentos"
elsif ARGV.size > 1
  puts "Tienes muchos argumentos"
  exit
else
  fichero = ARGV[0]
  content = `cat #{fichero}`
  lines = content.split("\n")
		
  lines.each do |line|
    data = line.split(" ")
    num1 = data[0].to_i
	op = data[1]
	num2 = data[2].to_i

	if op == "+"
	  Result_plus = num1 + num2
	  puts "El resultado de #{num1} y #{num2} es #{Result_plus}"
	elsif op == "-"
	  Result_minus = num1 - num2
	  puts "El resultado de #{num1} y #{num2} es #{Result_minus}"
	elsif op == "x"
	  Result_multi = num1 * num2
	  puts "El resultado de #{num1} y #{num2} es #{Result_multi}"
	elsif op == "/"
	  Result_div = num1 / num2
	  puts "El resultado de #{num1} y #{num2} es #{Result_div}"
    end
  end
end
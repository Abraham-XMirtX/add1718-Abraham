#/usr/bin/ruby

num1 = ARGV[0].to_i
op = ARGV[1]
num2 = ARGV[2].to_i

if ARGV.size < 3 
	puts "Tienes que poner dos argumentos"
	exit
end

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
#/usr/bin/ruby                          
if ARGV.size != 1
  puts "--------------Ayuda--------------"
  puts "-Tienes que usar solo un argumento-"
  puts "-----El argumento es userlist----"
  exit
end

userlist = ARGV[0]
content  = `cat #{userlist}`
lines    = content.split("\n")

lines.each do |nameuser|
  if system("id #{nameuser} &> /dev/null") == true
     system("sudo userdel -fr #{nameuser} &> /dev/null")
     puts"Borrando usuario #{nameuser}"
  else
     puts "El usuario #{nameuser} no existe"
  end
end

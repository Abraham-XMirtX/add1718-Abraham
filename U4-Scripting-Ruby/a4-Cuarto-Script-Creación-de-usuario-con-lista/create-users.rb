#/usr/bin/ruby                          
if ARGV.size != 1
  puts "--------------Ayuda--------------"
  puts "-Tienes que usar solo un argumento-"
  puts "-----El argumento es userlist----"
  exit
end

user = `whoami` 
if user.rstrip != "root"
   puts "No tienes permisos de root"
	exit
end

userlist = ARGV[0]
content  = `cat #{userlist}`
lines    = content.split("\n")

lines.each do |nameuser|
	users = nameuser.split(":")
	if split[2] == ""
		next
	end
	userslist = users[0]
 	if users[4] == "add"
  		if system("id #{userslist} &> /dev/null") == false
  	       system("useradd -m #{userslist} &> /dev/null")
   	   	   puts"Creando usuario #{userslist}"
  		else
   	   	   puts "El usuario #{userslist} existe"
   	   	end
   	else
   		if	system("id #{userslist} &> /dev/null") == true
  	       	system("userdel -fr #{userslist} &> /dev/null")
   			puts"Borrando usuario #{userslist}"
   		else
   			puts"El usuario #{userslist} no existe}"
   		end
 	end
end

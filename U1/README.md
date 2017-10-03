# Clientes Ligeros con LSTP/Xubuntu

## Introducción

> Los clientes Ligeros son maquinas con arquitectura de red cliente-servidor que
 se sustenta de un servidor central donde se gestiona y almacena el Usuario.

___

 ## Preparativos:


Usaremos 2 MVs, un servidor LTSP (Xubuntu) y un cliente (Ubuntu).

Configurar el servidor LTSP con dos Tarjetas de red una en "Adaptador Puente" y otra en "Red Interna".

Configurar maquina del cliente con una Tarjeta de Red "Interna"
___
## Servidor LTSP:

##### Instalación del SSOO:

Vamos con la instalación, le damos a Instalar Xubuntu
![image](img/xu1)
Descargamos las actualizaciones
![image](img/xu2.png)
Hacemos click en Instalar ahora
![image](img/xu3.png)
Elegimos la franja horaria donde estasmos
![image](img/xu5.png)
Elegimos el idioma de nuestro teclado
![image](img/xu6.png)
Rellenamos los datos para la instalación
![image](img/xu7.png)
Y esperamos a que termine la instalación
![image](img/xu8.png)

##### Configuración Xubuntu:

Vamos a cambiar la configuración de red, dejando una IP estatica para nuestro servidor.
![image](img/xu9.png)
En la Adaptador Puente le ponemos la siguiente configuración:
![image](img/xu10.png)
En la Interna dejamos la siguiente configuración:
![image](img/xu11.png)
Ejecutamos el siguiente comando para ver que se efectuo el cambio.
> ip a

![image](img/xu12.png)
Vamos a configurar el Nombre de Dominio de nuestra maquina, modificamos el archivo "**etc/hostname**".
![image](img/xu13.png)
Ahora modificamos el archivo "**etc/host**" para que se muestre el nombre de nuestra maquina al introducir el comando hostname -a.
![image](img/xu14.png)

Vamos a poner una contraseña a root para eso usamos el comando "**passwd**"
![image](img/xu16.png)

Ahora abrimos el terminal para instalar el ssh
> sudo apt-get install ssh

![image](img/xu15.png)

Comprobamos desde la maquina real que tiene conexion **ssh** una vez introducido el comando nos pide la contraseña del root creada anteriormente
>ssh root@ip_del_servidor

![image](img/xu17.png)

Metemos los siguientes comando para comprobar los cambios.

~~~
date
uname -a
hostname -a
hostname -d
tail -n 5 /etc/passwd
route -n
~~~
![image](img/xu19.png)

![image](img/xu21.png)
___

##### Creación de Usuario

Creamos varios usuarios para luego acceder de nuestra maquina cliente; usamos el siguinte comando.

>useradd -d /home/nombre_del_usuario-m -s /bin/bash nombre_de_usuario

![image](img/xu22.png)

##### Instalación del servicio LTSP y creación de Imagenes.

Abrimos un terminal y escribimos el siguiente comando:(Instala el servicio)

>sudo apt-get install ltsp-server-standalone

![image](img/xu23.png)

Ahora seguimos en la terminal y copiamos el siguiente comando para crear una imagen que la utilizara la maquina cliente.

>ltsp-build-client

![imagen](img/xu24.png)

Una vez que termine la creacion de la imagen nos aseguramos que esta bien creada con el siguiente comando:

> ltsp-info

![imagen](img/xu25.png)

##### Configuración LTSP

Vamos al archivo "**/etc/ltsp**" y lo modificamos:

> Rango de ip 192.168.67.125 a 192.168.17.225
/opt/ltsp/i386(esta es la imagen)
/ltsp/i386/pxelinux.0

Ahora nos aseguramos que los servicios dhcp y ftp estan activos.
Ya que al instalar el servidor ltsp tambien nos da eso servicios.

>ps -ef|grep dhcp
ps -ef|grepftp

### Maquina cliente

* Ahora vamos a comprobar si la maquina cliente coje, ip del nuestro dhcp y entra con la imagen que creamos anterior mente.

Arrancamos nuestra maquina cliente y se pondra a buscar una ip y la imagen.

![imagen](img/xu33.png)

Vemos que encuentra ip y la imagen , se trendria que mostrar la siguiente pantalla.

![imagen](img/xu32.png)

Ahora vamos a acceder con un usuario para verificar que nuestros clientes ligeros funcionan.

Entramos con el usuario "**cabello1**" en mi caso y comprobamos que estamos dentro del dominio.

![imagen](img/xu34.png)

### Video de demostración

![Clientes Ligeros(LTSP)](img/xu35.png)(https://youtu.be/rt9X8cPsRvU)

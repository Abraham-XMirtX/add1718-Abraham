# Acceso reomto SSH
---
### Preparativos
---
* Servidor SSH:
  * SO GNU/Linux: OpenSuse
  * IP estática
  ![image](img/sshs0.png)
  * Nombre de equipo: ssh-serverXX
  ![image](img/sshs1.png)
  * Añadir en ``/etc/hosts`` los equipos ``ssh-clientXXa`` y ``ssh-clientXXb``
  ![image](img/sshs13.png)

  * Comprobación de comandos

  > ip a

  > route -n

  ![image](img/sshs3.png)

  > ping -c 8.8.4.4

  > host www.google.es

  ![image](img/sshs5.png)

  > ping ssh-clientXXa

  > ping ssh-clientXXb

  ![image](img/sshs6.png)

  > lsblk

  > blkid

  ![image](img/sshs7.png)

  * Crear usuarios en servidor


  ![image](img/sshs8.png)

* Cliente GNU/Linux

  * SO GNU/Linux: OpenSuse
  * IP estática
  * Nombre de equipo: ssh-clientXXa
  * Añadir en ``etc/host`` el equipo ``ssh-serverXX`` y ``ssh-clientXXb``



  ![image](img/sshc4.png)

  * Comprobación comandos

  > ping -c 4 172.18.25.31

  > ping -c 4 172.18.25.31


  ![image](img/sshc5.png)

* Cliente Windows

  * Instalar un software SSH "**PuTTY**"


  ![image](img/sshw5.png)

  * Configuración de Windows 10
    * IP estática

  ![image](img/sshw0.png)
    * Nombre de equipo: ssh-clientXXb

  ![image](img/sshw1.png)

    * Añadir en ``C:\Windows\System32\drivers\etc\hosts`` el equipo ``ssh-serverXX`` y ``ssh-clientXXa``.

  ![image](img/sshw3.png)

  * Comprobamos haciendo ping a los equipos.

  ![image](img/sshw4.png)


## Instalación del servicio SSH

  * Instalamos el servicio en la máquina ssh-serverXX "**El sistema que usamos ya lo tiene instalado**" .

  * Comprobamos que el servicio esta funcionando

  ![image](img/sshs9.png)

  ![image](img/sshs10.png)

  ![image](img/sshs11.png)

  * Comprobamos que el está escuchando el puero 22.

  ![image](img/sshs12.png)


## Conexion SSH cliente SSH-ClientXXa

  * Comprobamos conectividad entre cliente servidor.

  > ping -c 2 ssh-server25

  > nmap -Pn ssh-server25 | grep ssh

  ![image](img/sshc6.png)

  * Comprobamos con cada usuario que creamos en el servidor.

  ![image](img/sshc7.png)
  ![image](img/sshc8.png)
  ![image](img/sshc9.png)
  ![image](img/sshc10.png)

  * Comprobamos el fichero ``more /home/.ssh/known_hosts``

  ![image](img/sshc12.png)

## Conexion SSH cliente SSH-ClientXXb

  Iniciamos PuTTY y nos conectamos el servidor

  ![image](img/sshw6.png)

  ![image](img/sshw7.png)

## ¿Cambiamos las claves del servidor?

  * Vamos a ``/etc/ssh/sshd.config`` y buscamos la linea ``HostKey /ssh_host_rsa_key`` la descomentamos.

  ![image](img/sshs14.png)

  * Generamos nuevas claves rsa para nuestro servidor y reiniciamos el servicio.

  ![image](img/sshs15.png)

  * Comprobamos si podemos conectar con una maquina cliente.

  ![image](img/sshs16.png)

  > Ahora al conectar con algun cliente deberia dar un fallo de claves, ya que no coinciden.

## Personalizar el prompt Bash

  * Vamos al fichero de nuestro usuario cabello1 ``/home/cabello1/.bashrc`` y lo modificamos

  ![image](img/sshs17.png)

  > Esto es para que al acceder por SSH nuestro prompt tenga un color diferente.

  * Ahora creamos un fichero en ``/home/cabello1/.alias`` para crear acortadores de comandos que usemos

  ![image](img/sshs18.png)

## Autenticación mediante claves públicas

* Vamos a la maquina SSH-ClientXXa y ejecutamos el comando ``ssh-keygen -t rsa`` para crear un par de claves

![image](img/sshc13.png)

 * Ahora copiamos la clave rsa y la añadimos a nuestro servidor y nos conectamos al servidor con el usuario cabello4 y no pedira contraseña.


 ![image](img/sshc16.png)

 * Ahora vamos a la maquina ssh-clientXXb y entramos con el mismo usuario y vemos que nos pedira la contraseña ya que esa maquina cliente no tiene un par de claves rsa.

 ![image](img/sshw8.png)

## Usar el SSH como túnel para X

  * Instalamos una aplicación en nuestro servidor para que la puedan utilizar los usuarios

  ![image](img/sshs19.png)

  * Modificamos el fichero ``/etc/ssh/sshd.config`` para que pueda ejecutar aplicaciones con entorno grafico, buscamos la linea ``X11Forwarding yes``

  * Vamos al client SSH-ClientXXa y comprobamos que funciona la APP instalada en el servidor.

    * Utilizamos el comando ssh -x cabello4@172.18.25.31


  ![image](img/sshc19.png)

## Aplicaciones en Windows por SSH

  * Instalamos el emulador Winw en nuestro servidor.

  ![image](img/sshs21.png)

  * Comprobamos la aplicacion en el servidor con wine, por defecto viene con el notepad.

  ![image](img/sshs22.png)

## Restricciones de usu

  * Creamos un usuario "**remoteuser4**"

  ![image](img/sshs23.png)

  * Cremos un grupo "**remoteapps**" y agregamos al usuario creado.

  ![image](img/sshs24.png)

  * Agregamos la aplicacion geany al grupo remoteapps.

  ![image](img/sshs26.png)

  * Cojemos la aplicacion geany y la damos permiso de ejecución 750, para que solo el grupo pueda acceder.

  ![image](img/sshs27.png)

  * Comprobamos en nuestro servidor si funciona correctamente.

  ![image](img/sshs28.png)

  * Con un usuario que no este dentro de ese grupo.

  ![image](img/sshs29.png)

  * Ahora comprobamos desde una maquina cliente.

  ![image](img/sshc20.png)

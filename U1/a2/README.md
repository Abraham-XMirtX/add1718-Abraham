## Configuración OpenSuse

Utilizamos Ip fijas tanto en cliente como servidor

* Configuración del servidor:

Vamos a Yast al apartado de red configuramos Nombre de Host/DNS

![image](img/opensuse/op1.png)

Encaminamiento (Puerta de enlace)

![image](img/opensuse/op04.png)

Tarjeta de red

![image](img/opensuse/op02.png)

* Configuración cliente

Nombre de Host/DNS

![image](img/opensuse/opc1.png)

Encaminamiento

![image](img/opensuse/opc02.png)

Tarjeta de red

![image](img/opensuse/opc03.png)

### Instalación de VNC OpenSuse Leap 42.2

Abrimos el Yast , instalamos y activamos servicio VNC acceso remoto.

![image](img/opensuse/op3.png)

Permintimos la administración

![image](img/opensuse/op5.png)

Y le damos a instalar

![image](img/opensuse/op6.png)

Una vez instalado, abrimos el terminal escribimos "vncserver" creamos una contraseña para la admin y el acceso remoto.

![image](img/opensuse/op07.png)

#### VncViewer

Es la herramineta que vamos usar para acceder remotamente a los equipo , viene por defecto en el sistema OpenSuse, la usaremos en el equipo cliente.

## Configuración de Windows 10

Vamos a usar Ip fijas tanto para la maquina cliente como servidor.

En el servidor usaremos la siguiente configuración:

![image](img/windows/ws1.png)

En la maquina cliente:

![image](img/windows/wc00.png)

### Instalación de VNC_Server Windows 10

Vamos a utilizar el programa "TightVNC server"

![image](img/windows/ws02.png)

Utilizamos la instalación "Custom"

![image](img/windows/ws03.png)

Quitamos el cliente del programa "TightVNC Viewer"

![image](img/windows/ws04.png)

Dejamos las configuraciónes por defecto

![image](img/windows/ws05.png)

Y le damos a instalar

![image](img/windows/ws06.png)

Despues nos piden una contrasseña de admin y otra para acceso remoto

![image](img/windows/ws07.png)

Y le damos a finalizar

![image](img/windows/ws08.png)

### Instalación de Vnc_Viewer Windows 10

Hacemos los mismos pasos que el anterior lo uncio que cambian es la Instalación "Custom", quitamos ahora el server y dejamos el cliente "TightVNC_viewer"

![image](img/windows/wc02.png)

> La contraseña del paso anterior solo es en el servidor

## Conexion remota de Windows a Windows

Vamos acceder con la maquina cliente  al servidor, abrimos el TightVNC_viewer.

>Colocamos la IP del servidor y le damos a conectar.

![image](img/windows/wc04.png)

Nos pide la contraseña del acceso remoto

![image](img/windows/wc05.png)

Y tenemos la conexion terminada

![image](img/windows/wc06.png)

Comprobamos con el comando "netstat -n para ver dicha conexion, utiliza el puerto :5900"

![image](img/windows/wc7.png)

## Conexion remota de linux a linux

Accedemos con la maquina cliente al servidor con la herramineta VncViewer.

![image](img/opensuse/opc04.png)

Nos pide la contraseña del acceso remoto y entremos en el servidor.

![image](img/opensuse/opc05.png)

Abrimos el terminal y comprobamos la conexion con el comando "netstat -ntap | grep y la ip del servidor"

![image](img/opensuse/opc06.png)

## Conexion remota linux a windows

Abrimos el terminal de OpenSuse y accedemos con el comando "VncViewer" a la maquina de windows 10

![image](img/windows/wo05.png)

Nos pide la contrasela del acceso remoto y accedemos a la maquina y comprobamos con el comando "netstat -n"

![image](img/windows/wo06.png)

>La ip es 172.18.25.32:48258

![image](img/windows/wo07.png)

## Conexion remota windows a linux

Abrimos el programa TightVNC y accedemos a maquina OpenSuse entramos con el puerto que nos asigno el porgrama de linux

![image](img/windows/wo01.png)

Nos pide la contraseña de acceso

![image](img/windows/wo2.png)

Y entramos en la maquina

![image](img/windows/wo04.png)

Comprobamos la conexion

![image](img/windows/wo03.png)

# Servidor Samba

  * Preparativos

    * Servidor:
      * S.O: OpenSUse
      * IP Fija:

        ![image](img/imgs1.png)

        ![image](img/imgs3.png)

      * Nombre de equipo y DNS:

        ![image](img/imgs2.png)

      * Añadir los equipos clientes en `/etc/hosts/`

        ![image](img/imgs4.png)

        * Comandos de comprobación.

        ![image](img/imgs5.png)
        ![image](img/imgs6.png)

    * Cliente Linux:
      * S.O: OpenSUse
      * IP Fija:

        ![image](img/imgc1.png)

        ![image](img/imgc3.png)

      * Nombre de equipo y DNS:

        ![image](img/imgc2.png)

    * Cliente Linux:
      * S.O: OpenSUse
      * IP Fija:

        ![image](img/imgw1.png)

      * Añadir los equipos clientes en `/etc/hosts/`

        ![image](img/imgw3.png)

      * Nombre de equipo y Grupo de trabajo:

        ![image](img/imgw2.png)

## Usuarios Locales

  * Crear los grupos piratas, soldados y todos.

    ![image](img/imgs7.png)


  * Crear el usuario smbguest y  supersamba.

    ![image](img/imgs11.png)

    ![image](img/imgs9.png)

  * Para asegurarnos que nadie puede usar smbguest para entrar en nuestra máquina mediante login, vamos a modificar este usuario y le ponemos como shell  ``/bin/false``.

    ![image](img/imgs12.png)

  * Dentro del grupo piratas incluir a los usuarios pirata1, pirata2.

    ![image](img/imgs8.png)

  * Dentro del grupo soldados incluir a los usuarios soldado1 y soldado2.

    ![image](img/img0.png)

  * Dentro del grupo todos, poner a todos los usuarios soldados, pitatas, supersamba y a smbguest.

    ![image](img/imgs11.png)

  * Incluimos a supersamba en todos los grupos.

    ![image](img/imgs10.png)

  * Resumen

    ![image](img/imgs13.png)

## Crear las carpetas para los futuros recursos compartidos

* Vamos a crear las carpetas de los recursos compartidos con los permisos siguientes:

  * ``/srv/sambaXX/public.d``
    *  Usuario propietario supersamba.
    *  Grupo propietario todos.
    *  Poner permisos 775.

      ![image](img/imgs14.png)

  * ``/srv/sambaXX/castillo.d``
    *  Usuario propietario supersamba.
    *  Grupo propietario soldados.
    *  Poner permisos 770.

      ![image](img/imgs15.png)

  * ``/srv/sambaXX/barco.d``
    *  Usuario propietario supersamba.
    *  Grupo propietario piratas.
    *  Poner permisos 770.

      ![image](img/imgs16.png)

## Configurar el servidor Samba

  * Vamos a hacer una copia de seguridad del fichero de configuración existente ``cp /etc/samba/smb.conf /etc/samba/smb.conf.000``.

    ![image](img/imgs17.png)

  * Yast -> Samba Server
    * Workgroup: mar1718
    * Sin controlador de dominio.

      ![image](img/img18.png)

  * En la pestaña de Inicio definimos

   *  Iniciar el servicio durante el arranque de  la máquina.
   * Ajustes del cortafuegos -> Abrir puertos

   > Vamos a la herraminenta Yast, cortafuegos y en zona externa añadimos servidor samba.


## Crear los recursos compartidos de Samba

  * Abrimos terminal y modificamos el archivo ``/etc/samba/smb.conf`` y creamos los recursos ``[cdrom]``, ``[public]``, `[castillo]`, ``[barco]``, y modificamos el Workgroup.

    ![image](img/img18.png)

  * Comprobamos con los comandos:

    * `testparm`

      ![image](img/img19.png)

## Usuarios Samba

* Después de crear los usuarios en el sistema, hay que añadirlos a Samba.

  * smbpasswd -a nombreusuario, para crear clave de Samba para un usuario del sistema.

    ![image](img/imgs20.png)

  * pdbedit -L, para comprobar la lista de usuarios Samba.

    ![image](img/imgs21.png)

## Reinicio y comprobación


*  Ahora que hemos terminado con el servidor, hay que reiniciar el servicio para que se lean los cambios de configuración.

    * Servicio smb
      *  systemctl stop smb
      *  systemctl start smb
      *  systemctl status smb

        ![image](img/imgs22.png)

    * Servicio nmb
        * systemctl stop nmb
        *  systemctl start nmb
        *  systemctl status nmb

          ![image](img/imgs22.png)

    * Comprobamos

        * testparm:

          ![image](img/img19.png)

        * netstat -tap:

          ![image](img/imgs24.png)

        * nmap -Pn

          ![image](img/imgs25.png)

## Cliente Windows

  * Desde un cliente Windows vamos a acceder a los recursos compartidos del servidor Samba con la "**ip-del-servidor-samba**"

  * Comprobar los accesos de todas las formas posibles. Como si fuéramos:

    *  un soldado:

      ![image](img/imgw8.png)

      ![image](img/imgw9.png)

    *  un pirata:

      ![image](img/imgw4.png)

      ![image](img/imgw5.png)

    > Después de cada conexión se quedan guardada la información en el cliente Windows (Ver comando net use).
    net use * /d /y, para cerrar las conexión SMB/CIFS que se ha realizado desde el cliente al servidor.

      ![image](img/imgw7.png)

  * Comprobación

    *  smbstatus, desde el servidor Samba.
    *  netstat -ntap, desde el servidor Samba.

      ![image](img/imgw15.png)

    *  netstat -n, desde el cliente Windows.

      ![image](img/imgw16.png)

## Cliente Windows comandos

  * El comando net use ip-servidor-samba\recurso clave /USER:usuario establece una conexión con el recurso compartido y lo monta en la unidad S. Probemos a montar el recurso barco.

    ![image](img/imgw14.png)



* Capturar imagen de los siguientes comandos para comprobar los resultados:

  *  smbstatus, desde el servidor Samba.
  *  netstat -ntap, desde el servidor Samba.

      ![image](img/imgw15.png)

  *  netstat -n, desde el cliente Windows.

      ![image](img/imgw16.png)

## Cliente GNU/Linux

* Desde en entorno gráfico, podemos comprobar el acceso a recursos compartidos SMB/CIFS.

  ![image](img/imgc4.png)

  * Castillo

    ![image](img/imgc5.png)

    ![image](img/imgc6.png)

  * Barco

    ![image](img/imgc7.png)

    ![image](img/imgc8.png)

  * Public

    ![image](img/imgc9.png)


  * Comprobación

    * netstat -ntap, desde el servidor Samba.

      ![image](img/imgc10.png)

    * netstat -ntap, desde el cliente Linux.

      ![image](img/imgc11.png)

## Cliente GNU/Linux comandos

  * Vamos a un equipo GNU/Linux que será nuestro cliente Samba. Desde este equipo usaremos comandos para acceder a la carpeta compartida.
  * Primero comprobar el uso de las siguientes herramientas:

    * sudo smbtree   : Muestra todos lo equipos/recursos de la red SMB/CIFS.

      ![image](img/imgc13.png)

    * smbclient :Muestra los recursos SMB/CIFS de un equipo concreto

      ![image](img/imgc14.png)

  * Ahora crearemos en local la carpeta ``/mnt/sambaXX-remoto/castillo``

      ![image](img/imgc15.png)

  * MONTAJE: Con el usuario root, usamos el siguiente comando para montar un recurso compartido de Samba Server, como si fuera una carpeta más de nuestro sistema: ``mount -t cifs //172.18.XX.55/castillo/mnt/sambaXX-remoto/castillo -o username=soldado1``

      ![image](img/imgc16.png)

  * COMPROBAR: Ejecutar el comando df -hT. Veremos que el recurso ha sido montado.

    ![image](img/imgc17.png)

  * Comprobación


  *  smbstatus, desde el servidor Samba.
  *  netstat -ntap, desde el servidor Samba.

    ![image](img/imgc18.png)

## Montaje automático

*  Para configurar acciones de montaje automáticos cada vez que se inicie el equipo, debemos configurar el fichero /etc/fstab. Veamos un ejemplo:

``//smb-serverXX/public /mnt/remotoXX/public cifs username=soldado1,password=clave 0 0``

![image](img/imgc19.png)

* Reiniciar el equipo y comprobar que se realiza el montaje automático al inicio.

![image](img/imgc20.png)

## Preguntas para resolver

  *  ¿Las claves de los usuarios en GNU/Linux deben ser las mismas que las que usa Samba?
  Si

  *  ¿Puedo definir un usuario en Samba llamado soldado3, y que no exista como usuario del sistema?
  No
  *  ¿Cómo podemos hacer que los usuarios soldado1 y soldado2 no puedan acceder al sistema pero sí al samba? (Consultar /etc/passwd)
  si , colocando en bin/bash sea false
  *  Añadir el recurso [homes] al fichero smb.conf según los apuntes. ¿Qué efecto tiene?

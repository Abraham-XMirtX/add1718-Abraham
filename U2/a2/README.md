# Servidor LDAP - OpenSUSE

* 1.Servidor LDAP

  * Hay varias herramientas que implementan el protocolo LDAP, por ejemplo: OpenLDAP, 389-DC, Active Directory, etc. En esta guía vamos a instalar y configurar del servidor LDAP con OpenLDAP.

> Usaremos la OpenLDAP

---

* 1.1 Preparar la máquina

    * Servidor LDAP:
      *  Configuración IP:
        ![image](img/img2.png)
      *  Nombre equipo: ldap-serverXX
        ![image](img/img1.png)
      *  Además en /etc/hosts añadiremos:
        ![image](img/img3.png)

---

*  1.2 Instalación del Servidor LDAP

  * Procedemos a la instalación del módulo Yast que sirve para gestionar el servidor LDAP (yast2-auth-server)

    ![image](img/img4.png)

  * Ir a Yast -> Servidor de autenticación. Aparecerá como "**Authentication Server**".

  *  Se requiere, además, instalar los paquetes: openldap2, krb5-server y krb5-client.
    ![image](img/img5.png)
  *  Iniciar servidor LDAP -> Sí
    Registrar dameon SLP -> No
    Puerto abierto en el cortafuegos -> Sí -> Siguiente.
    ![image](img/img6.png)
  *  Tipo de servidor -> autónomo -> Siguiente
    ![image](img/img7.png)
  *  Configuración TLS -> NO habilitar -> Siguiente
    ![image](img/img8.png)
  *  Configuracion:

      >Tipo de BD -> hdb

      >DNbase->dc=nombre-del-alumnoXX,dc=curso1718.

      >DN administrador -> cn=Administrator

      >Añadir DN base -> Sí

      >Contraseña del administrador

      >Directorio de BD -> /var/lib/ldap

      >Usar esta BD predeterminada para clientes

      >LDAP -> Sí -> Siguiente

    ![image](img/img9.png)

      > Habilitar kerberos -> No

    ![image](img/img10.png)

  * Resumen
    ![image](img/img11.png)

* Comprobación


  * slaptest -f /etc/openldap/slapd.conf para comprobar la sintaxis del fichero de configuración.
  * systemctl status slapd, para comprobar el estado del servicio.
  * systemctl enable slapd, para activar el servicio automáticamente al reiniciar la máquina.
  * nmap -Pn localhost | grep -P '389|636', para comprobar que el servidor LDAP es accesible desde la red.

  ![image](img/img12.png)

  * slapcat para comprobar que la base de datos está bien configurada.

  ![image](img/img13.png)
  * Podemos comprobar el contenido de la base de datos LDAP usando la herramienta gq. Esta herramienta es un browser LDAP.

  ![image](img/img14.png)
  * Comprobar que tenemos creadas las unidades organizativas: groups y people.

  ![image](img/img15.png)

* 1.4 Crear usuarios y grupos LDAP

  * Yast -> Usuarios Grupos -> Filtro -> LDAP.

    ![image](img/img16.png)

  > En definir Filtro

  * Crear el grupo piratas2 (Estos se crearán
   dentro de la ou=groups).

  * Crear los usuarios pirata21, pirata22 (Estos se crearán dentro de la ou=people).

   ![image](img/img19.png)

  * Usar gq para consultar/comprobar el contenido de la base de datos LDAP.

    ![image](img/img20.png)

  * ldapsearch -x -L -u -t "(uid=nombre-del-usuario)", comando para consultar en la base de datos LDAP la información del usuario con uid concreto.

    ![image](img/img21.png)
    ![image](img/img22.png)

* 2 Cliente LDAP

  * 2.1 Preparativos

    *   Configuración IP

      ![image](img/img01.png)

    *  Nombre equipo: ldap-clientXX
    *  Dominio: curso1718

      ![image](img/img23.png)

    *  Asegurarse que tenemos definido en el fichero /etc/hosts del cliente, el nombre DNS con su IP correspondiente:

      ![image](img/img24.png)

*  Comprobación

    *  nmap -Pn ldap-serverXX | grep -P '389|636', para comprobar que el servidor LDAP es accesible desde el cliente.

      ![image](img/img25.png)

    *  Usar gq en el cliente para comprobar que se han creado bien los usuarios.

    >  File -> Preferencias -> Servidor -> Nuevo
    >  URI = ldap://ldap-serverXX
    >  Base DN = dc=davidXX,dc=curso1718

      ![image](img/img26.png)

    * Resumen:

      ![image](img/img27.png)

* 2.2 Instalar cliente LDAP

  * Debemos instalar el paquete yast2-auth-client, que nos ayudará a configurar la máquina para autenticación.

    ![image](img/img28.png)

  *  Ir a Yast -> LDAP y cliente Kerberos.

    ![image](img/img29.png)

  *  Configurar del cliente LDAP.

    ![image](img/img30.png)

* 2.3 Comprobamos desde el cliente

  * getent passwd pirata21
  * getent group piratas2
  * id pirata21
  * finger pirata21

    ![image](img/img32.png)

  * cat /etc/passwd | grep pirata21
  * cat /etc/group | grep piratas2

    > No muestra nada en pantalla

 * su pirata21

    ![image](img/img31.png)

* 2.4. Autenticación

  * Vamos al cliente y entramos con el usuario de ldap pirata21.

    ![image](img/img31.png)

# 1. Introducción a Puppet

Existen varias herramientas para realizar instalaciones desde un punto central, como Chef, Ansible, CFEngine, etc. En este ejemplo, vamos a usar Puppet.

Puppet es una herramienta diseñada para administrar la configuración de sistemas Unix-like y de Microsoft Windows de forma declarativa. El usuario describe los recursos del sistema y sus estados, ya sea utilizando el lenguaje declarativo de Puppet o un DSL (lenguaje específico del dominio) de Ruby.


### 1.2 Preparación

>  * ADVERTENCIA

>   * Los nombres de máquinas, dominios, usuarios, etc., deben estar siempre en minúsculas.
>   * No usar tildes, caracteres especiales (ñ, ü, etc.)
>    * En OpenSUSE podemos hacer configurar el equipo a través de Yast

* Vamos a usar 3 Maquinas virtuales:

    * Master: Dará las órdenes de instalación/configuración a los clientes.
      *  S.O: OpenSUSE.
      *  IP estática: 172.AA.XX.100
      *  Nombre del equipo: masterXX
      *  Dominio: curso1718

        ![img](img/img2.png)

    * Cliente 1: recibe órdenes del master.
      *  S.O OpenSUSE.
      *  IP estática 172.AA.XX.101
      *  Nombre del equipo: cli1aluXX
      *  Dominio: curso1718

        ![img](img/img1.png)

    * Client2: recibe órdenes del master.
      *  S.O Windows 7.
      *  IP estática 172.18.XX.102
      *  Nombre Netbios: cli2aluXX
      *  Nombre del equipo: cli2aluXX

        ![img](img/img3.png)

### 1.3 Configurar /etc/hosts

 Cada MV debe tener configurada en su /etc/hosts al resto de hosts, para poder hacer ping entre ellas usando los nombres largos y cortos. Con este fichero obtenemos resolución de nombres para nuestras propias MV's sin tener un servidor DNS.

  * GNU/Linux

    * El fichero /etc/hosts modificamos las líneas siguientes.

    * Master25

      ![img](img/img5.png)
    * Cli1alu25

      ![img](img/img4.png)
  * Windows

    * Localizar el fichero hosts de Windows en la siguiente ruta:

      ``C:\Windows\System32\drivers\etc\hosts``

    * El contenido del fichero hosts de Windows tiene el siguiente aspecto:

      ![img](img/img01.png)

### 1.4 Comprobar las configuraciones

* En GNU/Linux, para comprobar que las configuraciones son correctas hacemos:

  * date
  * ip a

    ![img](img/img12.png)

  * route -n
  * host www.google.es
  * hostname -a
  * hostname -f               # Comprobar que devuelve el valor correcto!!!
  * hostname -d               # Comprobar que devuelve el valor correcto!!!

    ![img](img/img13.png)

  * tail -n 5 /etc/hosts

    ![img](img/img14.png)

  * ping masterXX
  * ping masterXX.curso1718

    ![img](img/img15.png)

  * ping cli1aluXX
  * ping cli1aluXX.curso1718

    ![img](img/img16.png)

  * ping cli2aluXX

    ![img](img/img17.png)

* En Windows comprobamos con:

  * date
  * ipconfig

    ![img](img/img6.png)

  * route PRINT

    ![img](img/img7.png)

  * nslookup www.google.es

    ![img](img/img8.png)

  * ping masterXX
  * ping masterXX.curso1718

    ![img](img/img9.png)

  * ping cli1aluXX
  * ping cli1aluXX.curso1718

    ![img](img/img10.png)

  * ping cli2aluXX

    ![img](img/img11.png)


### 2. Instalando y configuración del servidor

* Instalamos Puppet Master en la MV master25:`zypper install rubygem-puppet-master`

  ![img](img/img18.png)

* systemctl enable puppetmaster: Permitir que el servicio se inicie automáticamente en el inicio de la máquina.

  ![img](img/img20.png)

* systemctl start puppetmaster: Iniciar el servicio.

  ![img](img/img21.png)

* systemctl status puppetmaster: Consultar el estado del servicio.

  ![img](img/img22.png)

* En este momento debería haberse creado el directorio /etc/puppet/manifests.

  ![img](img/img23.png)


### 2.1 Preparamos los ficheros/directorios en el master:

mkdir /etc/puppet/files
touch /etc/puppet/files/readme.txt

  ![img](img/img24.png)

mkdir /etc/puppet/manifests
touch /etc/puppet/manifests/site.pp

  ![img](img/img25.png)

mkdir /etc/puppet/manifests/classes
touch /etc/puppet/manifests/classes/hostlinux1.pp

  ![img](img/img27.png)

### 2.2 Archivo principal de configuración de Nodos "site.pp"

/etc/puppet/manifests/site.pp es el fichero principal de configuración de órdenes para los agentes/nodos puppet.

  * Contenido de nuestro site.pp:

      ![img](img/img26.png)

### 2.3 Primer archivo hostlinux1.pp

Vamos a crear una primera configuración para máquina estándar GNU/Linux.

  *  Contenido para /etc/puppet/manifests/classes/hostlinux1.pp:

    ```  
      class hostlinux1 {
      package { "tree": ensure => installed }
      package { "traceroute": ensure => installed }
      package { "geany": ensure => installed }
    }
    ```


  *  tree /etc/puppet, consultar los ficheros/directorios que tenemos creado.

    ![img](img/img29.png)

  *  Comprobar que el directorio /var/lib/puppet tiene usuario/grupo propietario puppet.

    ![img](img/img30.png)

  *  Reiniciamos el servicio systemctl restart puppetmaster.
  *  Comprobamos que el servicio está en ejecución de forma correcta.
  *  systemctl status puppetmaster

    ![img](img/img31.png)

  *  netstat -ntap |grep ruby

    ![img](img/img32.png)

  *  Consultamos log por si hay errores: `tail /var/log/puppet/*.log`

    ![img](img/img33.png)

  *  Abrir el cortafuegos para el servicio.

    ![img](img/img34.png)

# 3. Instalación y configuración del cliente1

Vamos a instalar y configurar el cliente 1.

  *  Vamos a la MV cliente 1.

    * Instalar el Agente Puppet `zypper install rubygem-puppet`

      ![img](img/img35.png)


### 3.1 Definir el host master puppet
server=masterXX.curso1718
...
[agent]
...
# Desactivar los plugin para este agente
pluginsync=false

Veamos imagen de ejemplo de Raúl García Heredia:

    Comprobar que el directorio /var/lib/puppet tiene como usuario/grupo propietario puppet.
    systemctl enable puppet: Activar el servicio en cada reinicio de la máquina.
    systemctl start puppet: Iniciar el servicio puppet.
    systemctl status puppet: Ver el estado del servicio puppet.
    netstat -ntap |grep ruby: Muestra los servicios conectados a cada puerto.
    Abrir el cortafuegos para el servicio.

4. Certificados

Para que el master acepte a cliente1 como cliente, se deben intercambiar los certificados entre ambas máquinas. Esto sólo hay que hacerlo una vez.
4.1 Aceptar certificado

    Vamos a la MV master.
    Nos aseguramos de que somos el usuario root.
    puppet cert list, consultamos las peticiones pendientes de unión al master:

root@master42# puppet cert list
"cli1alu42.curso1718" (D8:EC:E4:A2:10:55:00:32:30:F2:88:9D:94:E5:41:D6)
root@master42#

    En caso de no aparecer el certificado en espera

        Si no aparece el certificado del cliente en la lista de espera del servidor, quizás el cortafuegos del servidor y/o cliente, está impidiendo el acceso.
        Volver a reiniciar el servicio en el cliente y comprobar su estado.

    puppet cert sign "nombre-máquina-cliente", aceptar al nuevo cliente desde el master:

root@master42# puppet cert sign "cli1alu42.curso1718"
notice: Signed certificate request for cli1alu42.curso1718
notice: Removing file Puppet::SSL::CertificateRequest cli1alu42.curso1718 at '/var/lib/puppet/ssl/ca/requests/cli1alu42.curso1718.pem'

root@master42# puppet cert list

root@master42# puppet cert print cli1alu42.curso1718
Certificate:
Data:
....

    A continuación podemos ver una imagen de ejemplo, los datos no tienen que coincidir con lo que se pide en el ejercicio.

    opensuse-puppet-cert-list.png

4.2 Comprobación

Vamos a comprobar que las órdenes (manifiesto) del master, llega bien al cliente y éste las ejecuta.

    Vamos a cliente1
    Reiniciamos la máquina y/o el servicio Puppet.
    Comprobar que los cambios configurados en Puppet se han realizado.
    Nos aseguramos de que somos el usuario root.
    Ejecutar comando para forzar la ejecución del agente puppet:
        puppet agent --test
        o también puppet agent --server master42.curso1718 --test
    En caso de tener errores:
        Para ver el detalle de los errores, podemos reiniciar el servicio puppet en el cliente, y consultar el archivo de log del cliente: tail /var/log/puppet/puppet.log.
        Puede ser que tengamos algún mensaje de error de configuración del fichero /etc/puppet/manifests/site.pp del master. En tal caso, ir a los ficheros del master y corregir los errores de sintáxis.

4.3 Información: ¿Cómo eliminar certificados?

Esto NO HAY QUE HACERLO. Sólo es informativo

Sólo es información, para el caso que tengamos que eliminar los certificados. Cuando tenemos problemas con los certificados, o los identificadores de las máquinas han cambiado suele ser buena idea eliminar los certificados y volverlos a generar con la nueva información.

Si tenemos problemas con los certificados, y queremos eliminar los certificados actuales, podemos hacer lo siguiente:

    En el servidor:
        puppet cert revoke cli1alu42.curso1617, revocar certificado del cliente.
        puppet cert clean cli1alu42.curso1617, eliminar ficheros del certificado del cliente.
        puppet cert print --all, Muestra todos los certificados del servidor. No debe verse el del cliente que queremos eliminar.
    En el cliente:
        rm -rf /var/lib/puppet/ssl, eliminar los certificados del cliente. Apagamos el cliente.

    Consultar URL https://wiki.tegnix.com/wiki/Puppet, para más información.

5. Segunda versión del fichero pp

Ya hemos probado una configuración sencilla en PuppetMaster. Ahora vamos a pasar a configurar algo más complejo.

    Contenido para /etc/puppet/manifests/classes/hostlinux2.pp:

class hostlinux2 {
  package { "tree": ensure => installed }
  package { "traceroute": ensure => installed }
  package { "geany": ensure => installed }

  group { "piratas": ensure => "present", }
  group { "admin": ensure => "present", }

  user { 'barbaroja':
    home => '/home/barbaroja',
    shell => '/bin/bash',
    password => 'poner-una-clave-encriptada',
    groups => ['piratas','admin','root']
  }

  file { "/home/barbaroja":
    ensure => "directory",
    owner => "barbaroja",
    group => "piratas",
    mode => 750
  }

  file { "/home/barbaroja/share":
    ensure => "directory",
    owner => "barbaroja",
    group => "piratas",
    mode => 750
  }

  file { "/home/barbaroja/share/private":
    ensure => "directory",
    owner => "barbaroja",
    group => "piratas",
    mode => 700
  }

  file { "/home/barbaroja/share/public":
    ensure => "directory",
    owner => "barbaroja",
    group => "piratas",
    mode => 755
  }
}

    Las órdenes anteriores de configuración de recursos puppet, tienen el significado siguiente:

        package: indica paquetes que queremos que estén o no en el sistema.
        group: creación o eliminación de grupos.
        user: Creación o eliminación de usuarios.
        file: directorios o ficheros para crear o descargar desde servidor.
        exec: Para ejecutar comandos/scripts.

    Modificar /etc/puppet/manifests/site.pp para que se use la configuración de hostlinux2 el lugar de la anterior:

import "classes/*"

node default {
  include hostlinux2
}

    node default indica que las órdenes de Puppet se van a aplicar a todos los nodos clientes.

Vamos al servidor:

    Ejecutar tree /etc/puppet para comprobar ficheros y directorios.
    Reiniciar el servicio. Vamos al cliente1;
    Comprobar que se han aplicado los cambios solicitados.

6. Cliente puppet Windows

Vamos a configurar Puppet para atender también a clientes Windows.

IMPORTANTE: Asegurarse de que todas las máquinas tienen la fecha/hora correcta.

    Enlace de interés:

        http://docs.puppetlabs.com/windows/writing.html

6.1 Configuración hostwindows3.pp

    Vamos a la MV master.
    Vamos a crear una configuración puppet para las máquinas windows, dentro del fichero.
    Crear /etc/puppet/manifests/classes/hostwindows3.pp, con el siguiente contenido:

class hostwindows3 {
  file {'C:\warning.txt':
    ensure => 'present',
    content => "Hola Mundo Puppet!",
  }
}

    Recordatorio: NOMBRES DE MÁQUINA

        El master GNU/Linux del ejemplo se llama master42.curso1718
        El cliente1 GNU/Linux del ejemplo se llama cli1alu42.curso1718
        El cliente2 Windows del ejemplo se llama cli2alu42

    Ahora vamos a modificar el fichero site.pp del master, para que tenga en cuenta la configuración de clientes GNU/Linux y clientes Windows, de modo diferenciado:

import "classes/*"

node 'cli1alu42.curso1617' {
  include hostlinux2
}

node 'cli2alu42' {
  include hostwindows3
}

    En el servidor ejecutamos tree /etc/puppet, para confirmar que tenemos los nuevos archivos.
    Reiniciamos el servicio PuppetMaster.
    Ejecutamos el comando facter, para ver la versión de Puppet que está usando el master.

6.2 Instalar el cliente2 Windows

    Enlaces de interés:

        http://docs.puppetlabs.com/windows?/installing.html
        https://downloads.puppetlabs.com/windows/

Ahora vamos a instalar AgentePuppet en Windows. Recordar que debemos instalar la misma versión en ambos equipos. Podemos usar comando facter para ver la versión de puppet del servidor.

    Vamos al cliente Windows.
    Descargamos e instalamos la versión de Agente Puppet para Windows similar al Puppet Master.
    El fichero puppet.conf en Windows está en C:\ProgramData\PuppetLabs\puppet\etc\puppet.conf. (ProgramData es una ruta oculta). Revisar que tenga algo como:

[main]
server=masterXX.curso1718 # Definir el host master
pluginsync=false          # Desactivar los plugin

    Reiniciamos la MV.
    Debemos aceptar el certificado en el master para este nuevo cliente. Consultar apartado anterior y repetir los pasos para este nuevo cliente.

    Si no aparece el cliente Windows en el master

    Si en el master no nos aparece el certificado del cliente windows para ser aceptado, probar lo siguiente:

        Ir a cli2aluXX
        Ejecutar el "Agente Puppet"
        Abrir "Consola Puppet" -> Ejecutar puppet agent --server masterXX.curso1718 --test.
        Ir a masterXX -> puppet cert list
        Capturar pantallas de estos pasos.

    ¿Cómo desintalar Puppet en Windows?

    Si tenemos problemas con el certificado de la máquina windows cliente tenemos que seguir los siguientes pasos para eliminar cualquier rastro de los mismos y poder reintentar la comunicación:

        Borrar en el maestro el certificado correspondiente a esa máquina puppet cert clean nombre-netbios-cliente.
        Desinstalar el agente puppet en windows.
        Borrar las carpetas de datos del puppet, ya que no se borran en la desinstalación. Las carpetas son:
            C:\ProgramData\PuppetLabs y
            C:\Users\usuario\.puppet.
        Reiniciar Windows
        Reinstalar Puppet y volver a probar.

    Si seguimos teniendo problemas para unir/conectar el cliente windows con el puppetmaster, porque no se realice el intercambio de certificados podemos:

        Repetir las recomendaciones anteriores para limpiar los datos, poner un nombre nuevo y diferente a la máquina Windows e intentarlo de nuevo.
        o usar una máquina Windows nueva (limpia de las acciones anteriores).

6.3 Comprobamos los cambios

    Vamos al cliente2.

Con los comandos siguientes podremos hacernos una idea de como terminar de configurar el fichero puppet del master para la máquina Windows.

    Iniciar consola puppet como administrador y probar los comandos:
        puppet agent --configprint server, debe mostrar el nombre del servidor puppet. En nuestro ejemplo debe ser masterXX.curso1718.
        puppet agent --server masterXX.curso1718 --test: Comprobar el estado del agente puppet.
        puppet agent -t --debug --verbose: Comprobar el estado del agente puppet.
        facter: Para consultar datos de la máquina windows, como por ejemplo la versión de puppet del cliente.
        puppet resource user nombre-alumno1: Para ver la configuración puppet del usuario.
        puppet resource file c:\Users: Para var la configuración puppet de la carpeta.

    Veamos imagen de ejemplo:

    puppet-resource-windows

7. Configuración hostwindows4.pp

    Configuramos en el master el fichero /etc/puppet/manifests/classes/hostwindows4.pp para el cliente Windows:

class hostwindows4 {
  user { 'soldado1':
    ensure => 'present',
    groups => ['Administradores'],
  }

  user { 'aldeano1':
    ensure => 'present',
    groups => ['Usuarios'],
  }
}

    Comprobar que funciona.

8. Configuración personalizada: hostalumno5.pp

    Crear un nuevo fichero de configuración para la máquina cliente Windows con el nombre /etc/puppet/manifests/classes/hostalumno5.pp.
    Incluir configuraciones elegidas por el alumno y probarlas.

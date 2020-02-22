# Syslog Server

Configuracion de Ansible para instalar un Syslog Sever en un servidor HP

## Almacenamiento

Para poder gestionar la gestión del RAID que esta configurado en el servidor tenemos que bajarnos el software del siguiente enlace [HPE Smart Storage Administrator (HPE SSA) for Linux 64-bit](https://support.hpe.com/hpesc/public/km/product/1010026819/HPE-ProLiant-DL380-Gen10-Server-Models?ismnp=0&l5oid=1010026818#t=DriversandSoftware&sort=relevancy&layout=table&numberOfResults=25&f:@kmswsoftwaretypekey=[swt8000078]&f:@kmswsoftwaresubtypekey=[swst9000032]&f:@kmswtargetproductbaseenvironmentlatest=[1010026819_Red%20Hat]&f:@kmswtargetproductenvironmentlatest=[1010026819_Red%20Hat%20Enterprise%20Linux%207%20Server])

# Instalación
Tenemos que modificar el fichero */etc/ansible/hosts* para añadir nuesto servidor

```
[CUSTOMER]
SYSLOG ansible_host=1.1.1.1 ansible_connection=ssh ansible_ssh_user=root ansible_ssh_pass=root
```

Verifficamos si tenemos conexión con el servidor

```
csanz@MADCSANZ2:Syslog$ ansible SYSLOG -m ping
SYSLOG | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

Ejecutamos la instalación

```
csanz@MADCSANZ2:Syslog$ ansible-playbook syslog.centos.yml
¿En que servidor se instalara el Syslog? [SYSLOG]: SYSLOG
¿Cual es la direccion IP? [1.1.1.1]: 1.1.1.1
¿Cual es la Mascara? [255.255.255.0]: 
¿Cual es la puerta de enlace predeterminada? [1.1.1.254]: 
¿Cual es la IP para conexion con CGNAT? [169.254.0.1]: 169.254.0.1

PLAY [SYSLOG] *******************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************
ok: [SYSLOG]

TASK [Instalando el repositorio de EPEL] ****************************************************************************************************
changed: [SYSLOG]

TASK [Instalando paquetes genericos] ********************************************************************************************************
changed: [SYSLOG]

TASK [Instalando el repositorio de Syslog-NG para CentOS 7] *********************************************************************************
changed: [SYSLOG]

TASK [Instalando el servidor de Syslog (Syslog-NG)] *****************************************************************************************
changed: [SYSLOG]

TASK [Actualizando el Sistena Operativo (CentOS 7)] *****************************************************************************************
changed: [SYSLOG]

TASK [Creando ENO5 Interfaces] **************************************************************************************************************
changed: [SYSLOG]

TASK [Creando Bonding Interfaces] ***********************************************************************************************************
changed: [SYSLOG]

TASK [Creando ENO interfaces] ***************************************************************************************************************
changed: [SYSLOG] => (item={'dest': '/etc/sysconfig/network-scripts/ifcfg-eno1', 'eth': 'eno1'})
changed: [SYSLOG] => (item={'dest': '/etc/sysconfig/network-scripts/ifcfg-eno2', 'eth': 'eno2'})

TASK [Creando los directorios] **************************************************************************************************************
changed: [SYSLOG] => (item={'path': '/etc/orange'})
changed: [SYSLOG] => (item={'path': '/home/procesados'})
changed: [SYSLOG] => (item={'path': '/home/procesados/enviados'})
changed: [SYSLOG] => (item={'path': '/var/log/nat'})

TASK [Copiamos los ficheros de configuración] ***********************************************************************************************
changed: [SYSLOG] => (item={'src': 'motd', 'dest': '/etc/orange/motd', 'mode': 755})
changed: [SYSLOG] => (item={'src': 'orangemain', 'dest': '/etc/orange/orangemain', 'mode': 755})
changed: [SYSLOG] => (item={'src': 'orangesftp', 'dest': '/etc/orange/orangesftp', 'mode': 755})
changed: [SYSLOG] => (item={'src': 'issue', 'dest': '/etc/issue', 'mode': 644})
changed: [SYSLOG] => (item={'src': 'nat', 'dest': '/etc/logrotate.d/nat', 'mode': 644})
changed: [SYSLOG] => (item={'src': 'vimrc', 'dest': '/root/.vimrc', 'mode': 644})
changed: [SYSLOG] => (item={'src': 'syslog-ng.conf', 'dest': '/etc/syslog-ng/syslog-ng.conf', 'mode': 644})
changed: [SYSLOG] => (item={'src': 'snmpd.conf', 'dest': '/etc/snmp/snmpd.conf', 'mode': 644})
changed: [SYSLOG] => (item={'src': 'ntp.conf', 'dest': '/etc/ntp.conf', 'mode': 644})
changed: [SYSLOG] => (item={'src': 'iptable', 'dest': '/etc/sysconfig/iptables', 'mode': 644})
changed: [SYSLOG] => (item={'src': 'crontab', 'dest': '/etc/crontab', 'mode': 644})
changed: [SYSLOG] => (item={'src': 'sshd_config', 'dest': '/etc/ssh/sshd_config', 'mode': 644})
changed: [SYSLOG] => (item={'src': 'ssacli-3.40-3.0.x86_64.rpm', 'dest': '/root/', 'mode': 644})

TASK [Modificamos /etc/profile] *************************************************************************************************************
changed: [SYSLOG]

TASK [Cambio de configuracion del servicio de Syslog-NG] ************************************************************************************
changed: [SYSLOG]

TASK [Instalamos el package ssacli] *********************************************************************************************************
changed: [SYSLOG]

TASK [Habilitamos y Reiniciamos los siguientes servicios de SYSLOG-NG, SNMPD, NTPD, SSHD] ***************************************************
changed: [SYSLOG] => (item={'service': 'syslog-ng'})
changed: [SYSLOG] => (item={'service': 'snmpd'})
changed: [SYSLOG] => (item={'service': 'ntpd'})
ok: [SYSLOG] => (item={'service': 'sshd'})

PLAY RECAP **********************************************************************************************************************************
SYSLOG                   : ok=15   changed=14   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
# ANSIBLE-PLAYBOOK
Vamos a definir los playbook que necesitamos para poder gestionar nuestros servidores **Debian**
```
[Debian]
SYSLOG ansible_host=<IP_Address> ansible_connection=ssh ansible_ssh_user=<username> ansible_ssh_pass=<password> ansible_python_interpreter=/usr/bin/python
```
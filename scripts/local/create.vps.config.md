# How to manage several VPSes at once

When you manage several VPSes, there is a technique to transform the command:

`ssh user@ip`

into 

`ssh myvps1`.

## Procedure

```sh
cd
cd .ssh
nano config
```

The file "config" will contain the following contents:

```
Host vpsname1
 User user_name_vps1
 HostName ip_vps1
 IdentityFile ~/.ssh/id_rsa
 ServerAliveInterval 120
 ServerAliverCountMax 30
 ```
 
 Then you continue with the following commands:
 
 ```sh
 cd
 ssh vpsname1
 ```

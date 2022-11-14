
# Local krb5

## hostname

```
export NAME=<computer-name>
export DOMAIN=<domain.tld>
export REALM=$NAME.$(echo $DOMAIN | tr '[:lower:]' '[:upper:]')
sudo scutil --set HostName $NAME.$DOMAIN
sudo scutil --set LocalHostName $NAME
sudo scutil --set ComputerName $NAME
dscacheutil -flushcache
reboot
# ...
echo ComputerName LocalHostName HostName | xargs -n1 -t scutil --get
```

### ...in **/etc/hosts**

`127.0.0.1    $(hostname)    $REALM`


## /etc/krb5.conf

```
[libdefaults]
    default_realm = $REALM
    default_keytab_name = file:$HOME/.config/krb5/conf/krb5.keytab
    default_tkt_enctypes = aes256-cts-hmac-sha1-96
    default_tgs_enctypes = aes256-cts-hmac-sha1-96
    allow_weak_crypto = true
    forwardable=true
    dns_lookup_realm = false
    dns_lookup_kdc = false

[logging]
    default = FILE:/usr/local/var/log/krb5/logs/krb5kdc.log
    admin_server = FILE:/usr/local/var/log/krb5/logs/kadmind.log
    kdc = FILE:/usr/local/var/log/krb5/logs/krb5kdc.log
[realms]
    $REALM = {
        kdc = $(hostname) 
        database_name = /Users/rhill/.config/krb5/db/principal
        admin_server = $(hostname)
        admin_keytab = file:/Users/rhill/.config/krb5/conf/kadm5.keytab
    }
    $NAME = {
        kdc = $(hostname)
        database_name = $HOME/.config/krb5/db/principal
        admin_server = $(hostname)
        admin_keytab = file:$HOME/.config/krb5/conf/kadm5.keytab
        default_domain = $(hostname) 
    }
[domain_realm]
    .$DOMAIN = $REALM
    $(hostname) = $REALM
```

## Create database

```
ll $HOME/.config/krb5/db/
ll $HOME/.config/krb5/conf/
ll /usr/local/var/log/krb5/logs/
ll /var/lib/krb5kdc/
ll /etc/krb5kdc/
sudo chmod a+w /etc/krb5kdc/
kdb5_util create -r $REALM -s
sudo chmod a-w /etc/krb5kdc/
```

`export MKEY=<master_key>`

> Enter KDC database master key: $MKEY

```
-bash-3.2$ kdb5_util create -r $REALM -s
Initializing database '/Users/<$USER>/.config/krb5/db/principal' for realm '<$REALM>',
master key name 'K/M@<$REALM>'
You will be prompted for the database Master Password.
It is important that you NOT FORGET this password.
Enter KDC database master key:
Re-enter KDC database master key to verify:
```

```
# delete he contents of /etc/krb5kdc and then use:
krb5kdc
```

```
cd $HOME/.config/krb5/conf/
kadmin.local
```

### create policies

```
kadmin.local: addpol users
kadmin.local: addpol admin
kadmin.local: addpol hosts
```

```
kadmin.local: ktadd -k krb5.keytab host/$REALM
kadmin.local: ktadd -k krb5.keytab HTTP/$REALM
kadmin.local: ktadd -k krb5.keytab $NAME
kadmin.local: 
kadmin.local: ktadd -k kadm5.keytab kadmin/admin kadmin/changepw
```

## Verifying and initializing keytab

`kadmin.local: quit`

`-bash-3.2$ klist -e -k -t krb5.keytab`

## start your kerberos

```
krb5kdc
kadmind
```

### Note:

```
kadmind: Cannot open /var/lib/krb5kdc/kadm5.acl: No such file or directory while initializing ACL file, aborting
```

`kinit $NAME@M$REALM -kt krb5.keytab`



This template lets you create a 3 node Percona XtraDB Cluster 5.6 on Azure.  It's tested on Ubuntu 12.04 LTS and CentOS 6.5.  

To verify the cluster, type in "mysql -h your_public_ip_dns_name -u test -p".  The password is what you set for sstuser in my.cnf. Run MySQL command "show status like 'wsrep%'".  You should see that wsrep_cluster_size is 3 by default and wsrep_ready is "ON". 

To gain root access to MySQL, you must ssh into a node and sudo to run mysql.   


c:\thinking-out-loud\jamespo\ManagedDisks\Deploy>doskey docopy=azcopy /Source:.\mysql-ha-pxc /Dest:https://jamespomd.blob.core.windows.net/mysql-ha-pxc /DestSAS:"?sv=2015-04-05&ss=b&srt=sco&sp=rwdlac&se=2016-11-21T06:29:10Z&st=2016-11-20T22:29:10Z&spr=https&sig=x1WV7ZaGXuv5FjZh0KQDoO65a%2B9Owqp3MrLR0QBB9HE%3D" /S

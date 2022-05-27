# Docker-Oracle10g
Create an Oracle 10g over Docker or Podman

NOTAS Befor install

###Referencias
https://github.com/aelsnz/docker-oracle-db/tree/master/oracle-10g
http://218.94.103.156:8090/download/oracle/linux/10g/

########RUN

###Para correr el docker
podman run -it --rm --ipc=host --privileged ad7b54e2be89 /bin/bash


###Para instalar
podman run -it --rm --ipc=host --privileged --net=host ad7b54e2be89 /bin/bash



#############################Create DB
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=/u01/app/oracle/product/10.2.0/db_1
PATH=/u01/app/oracle/product/10.2.0/db_1/bin:$PATH
NLS_DATE_FORMAT=dd/mm/yyyy:hh24:mi:ss 
DISABLE_HUGETLBFS=1
/home/oracle/bin/create-db.sh -d DEV -a N



#################Before install:
ORACLE_SID=DEV
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=/u01/app/oracle/product/10.2.0/db_1
LD_LIBRARY_PATH=/u01/app/oracle/product/10.2.0/db_1/lib:$LD_LIBRARY_PATH
PATH=/home/oracle/bin:/usr/local/git/bin:/u01/app/oracle/product/10.2.0/db_1/bin:/u01/app/oracle/product/10.2.0/db_1/OPatch:$PATH
NLS_DATE_FORMAT="dd/mm/yyyy:hh24:mi:ss"
SQLPATH=/home/oracle/sql
export ORACLE_SID
export ORACLE_HOME
sqlplus / as sysdba


##start/stop Oracle
sqlplus / as sysdba
shutdown
startup
commit

##crea Tabla
create table students(idn number (5) primary key, first_name varchar2 (20), last_name varchar2 (20));
##Inserta datos en Tabla
insert into students (idn,first_name,last_name) values (311,'Paco','Marzala');
insert into students (idn,first_name,last_name) values (421,'Pedro','Zabala');
insert into students (idn,first_name,last_name) values (522,'Carlos','Costas');
commit

## Muestra datos en Tabla
select * from students;

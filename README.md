# Learning Liquibase

Pretty simple example exercise using liquibase.

## Description
The exercise consists of the following modules:
- **liquibase-springboot:** This module create database data while springboot is starting.
- **liquibase-maven:** This module create database data with maven plugin.


## Getting started

### Start environment

To launch a dev environment:
1. Make sure you have docker and docker-compose installed.
2. Go to project root directory and execute the following commnad:
```
$ docker-compose up -d
```
3. Check docker containers
```
$ docker ps -a
CONTAINER ID   IMAGE                              COMMAND                  CREATED          STATUS                    PORTS                                         NAMES
dc2a151b2517   mysql:5.7                          "docker-entrypoint.s…"   16 seconds ago   Up 14 seconds             0.0.0.0:3306->3306/tcp, 33060/tcp             cmf-liquibase-db-1
```
4. Check database
```
$ docker exec -it cmf-liquibase-db-1 mysql -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.41 MySQL Community Server (GPL)

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| db                 |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.04 sec)

mysql>
```


### Executing liquibase-springboot module

1. Run process:
```
$ mvn compile exec:java -pl liquibase-springboot-demo -Dexec.mainClass="cmf.liquibase.springboot.demo.Main"
```
If you're on Windows, you need to apply quotes for exec.mainClass and exec.args:
```
$ mvn compile exec:java -pl liquibase-springboot-demo -D"exec.mainClass"="cmf.liquibase.springboot.demo.Main"
```
In order to avoid IllegalThreadStateException warning, you can use the following argument: `-Dexec.cleanupDaemonThreads=false`
```
mvn compile exec:java -pl liquibase-springboot-demo -D"exec.mainClass"="cmf.liquibase.springboot.demo.Main" -D"exec.cleanupDaemonThreads"=false
```


3. Check database
````
$ mysql> show tables;
+-----------------------+
| Tables_in_db          |
+-----------------------+
| DATABASECHANGELOG     |
| DATABASECHANGELOGLOCK |
| motorbike             |
+-----------------------+
3 rows in set (0.01 sec)


$ mysql> select * from motorbike;
+------+-------+--------+
| id   | brand | model  |
+------+-------+--------+
|    1 | BMW   | F800GS |
+------+-------+--------+
1 row in set (0.01 sec)


$ mysql> select * from DATABASECHANGELOG;
+----+--------+---------------------------+---------------------+---------------+----------+------------------------------------+-------------+----------+------+-----------+----------+--------+---------------+
| ID | AUTHOR | FILENAME                  | DATEEXECUTED        | ORDEREXECUTED | EXECTYPE | MD5SUM                             | DESCRIPTION | COMMENTS | TAG  | LIQUIBASE | CONTEXTS | LABELS | DEPLOYMENT_ID |
+----+--------+---------------------------+---------------------+---------------+----------+------------------------------------+-------------+----------+------+-----------+----------+--------+---------------+
| 1  | user   | liquibase/db.schema.sql   | 2023-04-14 12:58:04 |             1 | EXECUTED | 8:da5e4fff74af9e68266b7e912f3b035a | sql         |          | NULL | 4.21.0    | NULL     | NULL   | 1477084667    |
| 1  | user   | liquibase/dev/db.data.sql | 2023-04-14 12:58:04 |             2 | EXECUTED | 8:3d9130a11d05bb6bd67b0ee839badedc | sql         |          | NULL | 4.21.0    | NULL     | NULL   | 1477084667    |
+----+--------+---------------------------+---------------------+---------------+----------+------------------------------------+-------------+----------+------+-----------+----------+--------+---------------+
2 rows in set (0.00 sec)

$ mysql> select * from DATABASECHANGELOGLOCK;
+----+--------+-------------+----------+
| ID | LOCKED | LOCKGRANTED | LOCKEDBY |
+----+--------+-------------+----------+
|  1 |        | NULL        | NULL     |
+----+--------+-------------+----------+
1 row in set (0.01 sec)

mysql>
````

### Executing liquibase-springboot-maven module

1. Execute update:
````
$ mvn clean install -pl liquibase-maven-demo -DskipTests liquibase:update
````

2. Execute rollback (rollbackCount, rollbackTag, rollbackDate):
````
$ mvn clean install -pl liquibase-maven-demo -DskipTests liquibase:rollback -Dliquibase.rollbackCount=1
````
You can see the rollback options on the following website --> https://docs.liquibase.com/tools-integrations/maven/commands/maven-rollback.html

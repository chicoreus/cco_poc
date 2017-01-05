# cco_poc
Proof of concept files for an implementation of an information model for complex natural science collections objects.  
Example to illustrate a manuscript by Morris, Macklin, Kelly, and Tocci and for discussion by the [DINA consortium](http://www.dina-project.net).   

## Schemas
DDL for a minimal example (entirely proof of concept) schema is in:  
src/main/resources/edu/harvard/huh/specify/datamodel/cco_poc/db/tables.sql and  
src/main/resources/edu/harvard/huh/specify/datamodel/cco_poc/db/changes.sql

DDL for a much more complete schema suitable for implementation is in:  
src/main/resources/edu/harvard/huh/specify/datamodel/cco_full/db/tables.sql

Example data illustrating intended use of the schema for various sorts of simple and complex collections data is in:  
src/main/resources/edu/harvard/huh/specify/datamodel/cco_full/db/exampledata.sql

The outline of a human readable information model is at:   
src/main/resources/edu/harvard/huh/specify/datamodel/cco_full/model/model.md

# Building CCO_FULL directly
     
    mysql> drop database cco_full;
    mysql> create database cco_full;

    $ cd src/main/resources/edu_harvard/huh/specify/datamodel/cco_full/db/
    $ mysql -p cco_full < tables.sql
    $ mysql -p cco_full < exampledata.sql

# Building CCO_FULL with liquibase

This draft incorporates liquibase markup, **but it should not yet be considered stable - you must drop and create a new database from scratch with each update**.

## Prerequisites 

### Software 

1. java ( tested with OpenJDK ver. 1.7.0_95 )
2. [maven](https://maven.apache.org/) 
3. either MySQL or postgreSQL

### Default database
the default database should be **MySQL** in this repo, defined in  the file liquibase.properties  
You **have to** create the database 'cco_full' before running the project.  

    mysql> drop database cco_full;
    mysql> create database cco_full;

### Liquibase database properties

At this time there is support for 2 DBMSes (MariaDB/MySQL and postgresql).

The basic configuration is in the following 2 template files in the config directory, you must copy one of these to config/liquibase_cco_full.properties, and then provide your user credentials.

1. for MariaDB/MySQL see the liquibase_cco_full.properties.mysqltemplate file
2. for postgreSQL see the liquibase_cco_full.properties.postgrestemplate file

config/liquibase_cco_full.properties is in .gitignore and should not be put under version control (as it contains your credentials).

#### For MariaDB/MySQL

You must copy the config/liquibase_cco_full.properties.mysqltemplate to config/liquibase_cco_full.properties, and then add your credentials to the file.

    $ cp config/liquibase_cco_full.properties.mysqltemplate config/liquibase_cco_full.properties
    $ vim config/liquibase_cco_full.properties

#### For Postgresql

1. be sure that you have postgreSQL installed 
2. create the schema 'cco_full', check the credentials in the liquibase.postgresql.properties-file
3. replace liquibase_cco_full.properties with the liquibase_cco_full.properties.postgrestemplate.

    $ cp config/liquibase_cco_full.properties.postgresqltemplate config/liquibase_cco_full.properties
    $ vim config/liquibase_cco_full.properties

## To build the database with Liquibase

To run the project type '**mvn  clean install**' in the same directory that the pom.xml-file resides

    mvn clean install

## Configuration Files 

### For maven.

- pom.xml
   - db: mysql-connector-java (version  '5.1.37')
   - db: mysql ( version 5.5.49)
   - db: postgresql (version '9.1-901-1.jdbc4')
   - liquibase (version '3.4.2')
   - liquibase-maven-plugin (version '3.0.5')

### For the liquibase-project.

 - **config/liquibase.properties (you must create from one of the templates and set your credentials) ** 
    - contains : driver and url to the database
    - contains : credentials
    - contains : path to the master.xml-file
    - contains : additional such as ;  'verbose = true', '**dropFirst = false**'
  - **master.xml**
    - contains : path to 'db.changelog-x.y.xml' , x.y are version-nr.


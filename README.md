# cco_poc
Proof of concept files for an implementation of an information model for complex natural science collections objects. <br>
This is the first draft using liquibase to illustrate the information model from the manuscript by ; Morris, Macklin, Kelly, and Tocci. <br> this liquibase-project should serve as a basis for a discussion by the Dina consortium.

## The original DDL for the schema is in:
src/main/resources/edu/harvard/huh/specify/datamodel/cco_poc/db/tables.sql

#prereq

## Software 

  1.java ( tested with OpenJDK ver. 1.7.0_95 )
  2.[maven](https://maven.apache.org/) 
  3. either mysql or postgresql , the default database should be mysql ( settings in liquibase.properties )

## Default database
the default database should be **mysql** in this repo, see the liquibase.properties  <br>
You **have to** create the database 'paul' before running the project<br>
mysql> create database paul;<br>
if you would like to change to postgreSQL:
1. be sure that you have postgresql installed 
2. create the database 'paul', check the credentials in the liquibase.postgresql.properties-file
2. replace liquibase.properties with the liquibase.postgresql.properties.

## How to run the Liquibase-project
To run the project<br>
type '**mvn  clean install**' in the same directory that the pom.xml-file resides

#important files for maven.

  - pom.xml
    - db: mysql-connector-java (version  '5.1.37')
    - db: mysql ( version 5.5.49)
    - db: postgresql (version '9.1-901-1.jdbc4')
    - liquibase (version '3.4.2')
    - liquibase-maven-plugin (version '3.0.5')

#Files for the liquibase-project.

## Necessary files

  - **liquibase.properties (defaults to mysql)** 
    - contains : driver and url to the database
    - contains : credentials
    - contains : path to the master.xml-file
    - contains : additional such as ;  'verbose = true', '**dropFirst = false**'
  - **master.xml**
    - contains : path to 'db.changelog-x.y.xml' , x.y are version-nr.




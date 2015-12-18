# cco_poc
Proof of concept files for an implementation of an information model for complex natural science collections objects.
Example to illustrate a manuscript by Morris, Macklin, Kelly, and Tocci and for discussion by the Dina consortium.   

DDL for an example schema is in:
src/main/resources/edu/harvard/huh/specify/datamodel/cco_poc/db/tables.sql

#prereq

**Software:**

  - java
  - [maven](https://maven.apache.org/) 
  - a database-engine of choice 

**Database**


In this example the database is called '**paul**'.<br>
You **have to** create the database before running the project<br>
mysql> create database paul;<br>

  - see the liquibase.properties-file (here the target is a mysql-db)
    - setting: url=jdbc:mysql://localhost/**paul**

#important files for maven.

  - pom.xml
    - db: mysql-connector-java (version  '5.1.37')
    - db: postgresql (version '9.1-901-1.jdbc4')
    - liquibase (version '3.4.2')
    - liquibase-maven-plugin (version '3.0.5')

#Files for the liquibase-project.

### Necessary files

  - **liquibase.properties (defaults to mysql)** 
    - contains : driver and url to the database
    - contains : credentials
    - contains : path to the master.xml-file
    - contains : additional such as ;  'verbose = true', '**dropFirst = false**'
  - **master.xml**
    - contains : path to 'db.changelog-x.y.xml' , x.y are version-nr.

#How to run the Liquibase-project
To run the project<br>
type '**mvn  clean install**' in the same directory that the pom.xml-file resides


# cco_poc
Proof of concept files for an implementation of an information model for complex natural science collections objects.
Example to illustrate a manuscript by Morris, Macklin, Kelly, and Tocci and for discussion by the Dina consortium.   

DDL for an example (entirely proof of concept) schema is in:
src/main/resources/edu/harvard/huh/specify/datamodel/cco_poc/db/tables.sql

DDL for a much more complete schema suitable for implementation is in:
src/main/resources/edu/harvard/huh/specify/datamodel/cco_poc/db/tables.sql

With some additional configuration (driver, credentials) you can build with liquibase.
mvn liquibase:update

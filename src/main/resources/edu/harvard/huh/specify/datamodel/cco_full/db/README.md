These files contain a reasonably complete description of a schema for
handling information about complex natural science collection objects, 
using the core complex collections model of (collecting-event-unit-
identifiableitem-loanablepreparation).  This is intended for 
implementation, as well as a description of the conceptual model.

*tables.sql contains SQL DDL with liquibase markup describing a 
schema for managing natural science collections information.  
*functions.sql contains a set of functions that can support queries 
on the database, particularly queries on trees.
*triggers.sql contains (not yet complete) SQL DDL for triggers to 
support tracking of changes in an audit log table.
*baselinedata.sql contains a set of core data probably needed by any
installation.
*exampledata.sql contains a set of example data illustrating management
of various kinds of complex collections objects.
*optional.sql contains some optional SQL DDL with comments on how
the changes affect the capabilities of the model, you probably do 
not want to use this file.

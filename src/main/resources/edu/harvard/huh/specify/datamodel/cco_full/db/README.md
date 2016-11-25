These files contain a reasonably complete description of a schema for
handling information about complex natural science collection objects, 
using the core complex collections model of (collecting-event-unit-
identifiableitem-loanablepreparation).  This is intended for 
implementation, as well as a description of the conceptual model.

*tables.sql contains SQL DDL with liquibase markup describing a 
schema for managing natural science collections information.  
*optional.sql contains some optional SQL DDL with comments on how
the changes affect the capabilities of the model.
*triggers.sql contains (not yet complete) SQL DDL for triggers to 
support tracking of changes in an audit log table.


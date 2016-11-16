These files contain a minimal proof of concept portion of a schema to 
illustrate a way of handling information about complex natural science 
collection objects.  This is not intended for implementation, but as a
concrete description of the conceptual model.

* tables.sql contains SQL DDL with liqibase markup addded to describe the core
(collectingevent-unit-identifiableitem-preparation) entities in the cco model. 
(changesets 1 to 21)
* agent.sql  contains SQL DDL wioth liquibase markup added to describe a set 
of entities for handling agents (individuals, teams of individuals,
organizations, etc.) in the natural science collections domain.  It draws from
the Specify-6, Specify-6-huh, Arctos/MCZbase, and Symbiota designs for
agents.  
* optional.sql contains SQL DDL with comments for some optional changes that
to the model.

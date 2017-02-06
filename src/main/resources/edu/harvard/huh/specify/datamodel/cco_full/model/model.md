# Information Model for CCO_FULL

Work in progress, entities, their definitions, and cardinality descriptions are present.

# Entities

* scope 
  * Definition: Institutions and departments for which access control limitations may be applicable for some data.  
  * Remarks: Serves to support the functionality provided with virtual private databases in Arctos.  
* principal 
  * Definition: An entity to which some set of access rights may apply, typically a group. 
  * Remarks: For example,  a principal may be "data entry", a group having some set of access rights for data entry, which rights exist and how they are implemented is not specified here.
* systemuser 
  * Definition: A user of the system
* systemuserprincipal 
  * Definition: Participation of a system user in principles (associative entity relating systemusers to principals).
* picklist 
  * Definition: describes the binding of controled vocabularies (picklistitem) to specific database fields.
  * Remarks: picklists and codetables are implementations of controlled vocabularies.  Internationalization is provided for both.  Picklists do not support database level enforcement as foreign keys, codetables do.  The entities picklist and picklist item have built in support for varying the available controlled vocaubulary for an entity by scope (for example, different sets of appropriate values for life stage could be presented for botanical or ornithological material).  It is possible to add such support to a code table, but that would be a special case implementation per code table.
* picklistitem 
  * Definition: code table defining context sensitive controled vocabularies for specific fields in the database.
* picklistitemint 
  * Definition: internationalization for picklist items, allows use of a single language key in picklist items, provides translations of that key and definitions for that key in an arbitrary number of languages.  
  * Remarks: Because picklistitems have scopes and picklists, picklist.title is not expectd to be unique, and thus the same key for different picklists or scopes may have different definitions, thus picklistitem internationalization needs to relate to picklistitem by primary key.  
* codetableint 
  * Definition: internationalization for code tables.
  * Remarks: Allows use of a single language key in code tables, provides translations of that key and definitions for that key in an arbitrary number of languages.  Applies to code tables.
* unit 
  * Definition: logical unit that was collected or observed in a collecting event.
* identifiableitem 
  * Definition: a component of a unit for which a scientific identification can be made (that is, to which a scientific name can be applied).
* part 
  * Definition:  Associative entity between identifiable items and preparations.  Biologically meaningful parts of organisms that comprise preparations.  Parts are biologically logical components of organisms.  Parts may have additional non-taxonomic identifications associated with them, such as sex, lifestage, or caste, and they can have part of the organism attributes such as whole animal or skull or postcranial skeleton.
* preparation 
  * Definition: an existing or previous physical artifact that could participate in a transaction, e.g. be sent in a loan.   Preparations are physically stored sets of parts.
* identification 
  * Definition: the application of a scientific name by some agent at some point in time to an identifiable item.  Includes both non-type and type identifications and metadata about validation of type status.
* taxon 
  * Definition: A scientific name string that may be curated to be linked to a nomeclatural act or to an authoriative record of a name usage.
* taxontreedef 
  * Definition: Definition of a taxonomic tree
* taxontreedefitem 
  * Definition: Definition of ranks within a taxon tree.  NOTE: Because Phylum is used for animals and Division for plants, and it is expected that both are defined in a single tree, the definitions form a map rather than a tree, so parentid and parentage are not used.  A sort on values for rank_id is needed to find the next higher or next lower rank definition.
* journal  
  * Definition: A serial work.
* journaltitle  
  * Definition: Titles of serial works.
* ctjournaltitletype  
  * Definition: controlled vocabulary for journal title types
* journalidentifier  
  * Definition: A unique identifier for a serial work (e.g. ISSN, OCLC, TL2, library call number, etc.).
* ctjournalidentifiertype  
  * Definition: controlled vocabulary for journal identifier types.
* publication  
  * Definition: A published work (e.g. a journal article, monograph, or book).
* ctpublicationtype  
   * Definition: Controled vocabulary for publication types (e.g. books, journal articles, monographs, etc).  
* publicationidentifier  
  * Definition: A unique identifier for a publication.
* ctpublicationidentifiertype  
  * Definition: controlled vocabulary for publication identifier types.
* author  
  * Definition: Names of authors and editors of publications.
* catalogeditem 
  * Definition: the application of a catalog number out of some catalog number series.
* materialsample
  * Definition: see darwincore.
* catalognumberseries 
  * Definition: a sequence of numbers of codes assigned as catalog numbers to material held in a natural science collection.
* ctcatnumseriespolicy 
* catnumseriescollection 
* collectingevent 
  * Definition: an event in which an occurrance was observed in the wild, and typically, for a natural science collection, a voucher was collected, time at which a collector visited a locality and collected one or more collected units using a single sampling method.
* eventdate 
  * Definition: a set of spans of time in which some event occurred.  NOTE: Cardinality is enforced as zero or one to one in each relation with unique indexes, and event dates should not be reused accross relations.
  * Remarks: When in a form that can not be tied to a year (e.g. "April"), populate verbatim_date with the verbatim value, iso_date with an empty string, and use start_date and end_date to set plausible bounds for the interpretation of the date (e.g. 1700-2015 for a record of unknown date entered in 2015).  For wholly unknown values, verbatim_date of [unknown] or [data not provided] might be appropriate with a null iso_date and large plausible ranges for the start and end dates.
* locality 
  * Definition: a location
* othernumber 
  *  Definition: a number or code associated with a specimen that is not known to be its catalog number
* transactionitem 
  * Definition:  the participation of a preparation in a transaction (e.g. a loan).
* transactionc 
  * Definition: a record of the movement of a set of specimens in or out of a collection, e.g. loan, outgoing gift, deaccession, borrow.
* loan 
  * Definition: A record of a returnable movement of a set of specimens out of a collection 
* gift 
  * Definition: A record of a non-returnable movement of a set of specimens out of a collection to another insitution
* borrow 
  * Definition: Loan records kept by this insititution for material borrowed from other insititutions. 
* deaccession 
  * Definition: A record of a non-returnable movement of a set of specimens out of a collection to outside of institutional care
* transactionagent 
  * Definition: the participation of an agent in a transaction in some defined role (e.g. the agent who gave approval for some loan).
* agent 
  * Definition: a person or organization with some role related to natural science collections.
* ctrelationshiptype 
  * Definition: types of relationships between pairs of agents.
* agentteam 
  *  Definition: Composition of agents into teams of individuals, such that both the team and the members can be agents.
* agentnumberpattern 
  * Definition: machine and human redable descriptions of collector number patterns
* agentreference 
  *  Definition: Links to published references the content of which is about collectors/agents (e.g. obituaries, biographies).
* agentlink 
  * Definition: supporting hyperlinks out to external sources of information about collectors/agents.
* agentname 
  *  Definition:  multiple variant forms of names and names for a collector/agent
* ctagentnametype 
  * Definition: controled vocabulary for agent name types.
* agentrelation 
  * Definition: A relationship between one agent and another, serves to represent relationships (family,marrage,mentorship) amongst agents.
* agentgeography 
  * Definition:  relationships of agents with geographies (as collector, author, etc).
* agentspeciality 
  * Definition: Knowledge of particular agents in particular taxa.
* cttextattributetype 
  * Definition: types of text attributes
* textattribute 
  * Definition: a generic typed text attribute that can be added to any table.
* inference 
  * Definition:  metadata description of the basis of an inference made in interpreting a value in any field in any table
* ctnumericattributetype 
  * Definition: types of numeric attributes
* numericattribute 
  * Definition: a generic typed numeric attribute that can be added to any table.
* ctbiologicalattributetype 
  * Definition: types of biological attributes 
* ctlengthunit 
  * Definition: controled vocabulary for units of length.
* ctmassunit 
  * Definition: controled vocabulary for units of mass.
* ctageclass 
  * Definition: controled vocabulary for age classes.
* scopect 
  * Definition: relationship between a key in a code table and a scope, the scope within which a code table applies.
* biologicalattribute 
  * Definition: a generic typed attribute for biological characteristics of organisms, 
* auditlog 
  * Definition: timestamps and users who have inserted, deleted, or updated data in each table.  NOTE: Maintain with triggers on each table.
* ctencumberancetype 
  * Definition: controled vocabulary of encumberance types.
* encumberance 
  *  Definition: a description of the limitations on the visiblity of some data to the public.  All public presentations of data must observe the encumberance associated with that data.  
* catitemencumberance 
  * Definition: relationship between encumberances and cataloged items
* attachmentencumberance 
  * Definition: relationship between encumberances and attachment (metadata records), encumberance of actual media objects needs to be handleed by a digital asset management system.
* localityencumberance 
  * Definition: relationship between encumberances and localities (e.g. for fossil localities where not publicizing the locality was a condition of collecting at that locality).   
* taxonencumberance 
  * Definition: relationship between encumberances and taxa (e.g. for soon-to-be-described species, or for taxa which are controled substances).   
* address 
  * Definition: an address for an agent
* ctelectronicaddresstype 
* electronicaddress 
  * Definition: email, phone, fax, or other electronic contact address for an agent
* addressofrecord 
  * Definition: an address to which something was sent, which must be preserved even as an agent changes their current address.
* accession 
  * Definition: a record of the acceptance of a set of collection objects into the care of an institution.
* repositoryagreement 
  * Definition: an agreement under which one institution agrees to be the repository for material that is owned by another organization.
* accessionagent 
  * Definition: The participation of an agent in an accession in some defined role (e.g. the agent who approved some accession).
* attachment 
  * Definition: Metadata concerning a media object that can be attached to a data object
* attachmentrelation 
  * Definition: relationship between any row in any table and an attached media object.  Means of associating media objects with data records.
* collector 
  * Definition: The relation of an agent, possibly with additional un-named agents, to a collecting event (supports a workflow where collectors are transcribed verbatim and then subsequently parsed into known agent teams.
* ctcoordinatetype 
  * Definition: Controled vocabulary of vocabulary types.
* coordinate 
  * Definition: a two dimensional point description of a location in one of several standard forms, allows splitting a verbatim coordinate into atomic parts, intended for retaining information about original coordinates, separate from subsequent georeferences.
* georeference 
  * Definition: a three dimensional description of a location in standard form of decimal degress with elevation and depth, with metadata about the georeference and how it was determined, interpreted from textual locality and coordinate information.
* geography 
  * Definition: heriarchically nested higher geographical entities 
* geographytreedef 
  * Definition: Definition of a geography tree
* geographytreedefitem 
  * Definition: Definition of a node in a geography tree
* collection 
  * Definition: a managed set of collection objects that corresponds to an entity to which a dwc:collectionId is assigned.  Collection manages metadata about the collection, scope is for access control, and catalognumberseries links to sets of data within a collection.
* storagetreedef 
  * Definition: Definitions for storage trees 
* storagetreedefitem 
  * Definition: definition of ranks within a storage heirarchy 
* storage 
  * Definition: location where zero or more preparations are stored 
* rocktimeunit 
  * Definition: a geological time, rock, or rock/time unit.
* rocktimeunittreedef 
  * Definition: geologic rock/time unit trees
* rocktimeunittreedefitem 
  * Definition: a definition of a rank in a geologic rock/time unit tree
* paleocontext 
  * Definition: a geological context from which some material was collected.

# Entity Relationship Diagrams

## Core (complex object) tables

![E-R Diagram of core tables][erDiagramCore]

# Cardinality Descriptions 

Each scope has zero to one parent scope.  
Each scope is the parent for zero to many scopes.  
Each principal has one and only one scope.  
Each scope is for zero to many principals.  
Each systemuser has zero to many principals.  
Each principal is for zero to many systemusers.  
Each systemuserprincipal is for one and only one principal.  
Each principal has zero to many systemuserprincipals.  
Each systemuserprincipal is for one and only one systemuser.  
Each systemuser has zero to many systemuserprincipals.  
Each picklist applies to one and only one table and field.  
Each table and field may have zero to one picklist.  
Each picklist has zero to many picklistitems.  
Each picklistitem is on one and only one picklist.  
Each ctpiclistitem is in zero to one scope (where zero scopes means the picklistitem applies in any scope).  
Each scope may apply to zero to many picklistitems.  
Each picklistitem has zero to many translations in picklistitemint.  
Each picklistitemint is a translation for one and only one picklistitem.  
Each unit was collected in one and only one collectingevent.  
Each collectingevent had zero to many units collected in it.  
Each unit had zero or one materialsample derived from it.  
Each prepraration has zero or one material sample derived from it.  
Each materialsample is derived from zero or one one unit.  
Each materialsample is derived from zero or one preparation.  
Each unit is composed of zero to many preparations (many to many unit-preparation relation with identifiable item as an associative entity).  
Each preparation is a physical preparation of one to many units.  
Each identifiable item comes from one and only one unit.  
Each unit has zero to many identifiable items.  
Each preparation may be the parent of zero to many child preparations (e.g. a slide prepared from a whole animal).  
Each preparation has zero or one parent preparation from which it was derived.  
Each identifiable item has zero to one parts preserved in a collection.  
Each part is one and only one identifable item.  
Each part is prepared as as one and only one preparation.  
Each preparation is composed of one to many parts.  
Each preparation may be a preparation of zero or one identifiable item.  
Each identifiable item may be prepared into zero to many preparations.  
Each identifiableitem has zero to many identifications.  
Each identification is of one and only one identifiable item.  
Each identification has zero or one determining agent.  
Each agent is the determiner for zero to many identifications.  
Each identification has zero or one verifying agent.  
Each agent is the verifier for zero to many identifications.  
Each identification involves one and only one taxon.  
Each taxon is used in zero to many identifications.  
Each taxon has zero or one accepted taxon.  
Each taxon is accepted for zero to many taxa.  
Each taxon is defined by one and only one taxontreedefitem.  
Each taxontreedefitem defines zero to many taxa.  
Each taxon has zero or one parent taxon (each taxon except the root node has one and only one parent taxon).  
Each taxon is the parent for zero to many child taxa.  
Each taxon has zero or one author agent.  
Each agent is the author for zero to many taxa.  
Each taxon has zero or one parenthetical author agent.  
Each agent is the parenthetical author for zero to many taxa.  
Each taxon has zero or one ex author agent.  
Each agent is the ex author for zero to many taxa.  
Each taxon has zero or one parenthetical ex author agent.  
Each agent is the parenthetical ex author for zero to many taxa.  
Each taxon has zero or one sanctioning author agent.  
Each agent is the sanctioning author for zero to many taxa.  
Each taxon has zero or one parenthetical sanctioning author agent.  
Each agent is the parenthetical sanctioning author for zero to many taxa.  
Each taxon has zero or one cited in author agent.  
Each agent is the cited in author for zero to many taxa.  
Each taxon was created in a nomenclatural act published in zero or one publication.  
Each publication contains zero to many nomenlcatural acts creating taxa.  
Each taxontreedef is the tree for zero to many taxontreedefitem nodes.  
Each taxontreedefitem is a node in one and only one taxontreedef.   
Each journal is preceded by zero or one preceding journal.  
Each journal is the preceding journal for zero to many journals.  
Each journal is succeeded by zero or one succeeding journal.  
Each journal is the succeeding journal for zero to many journals.  
Each journal has zero to many titles.  
Each title is for one and only one journal.  
Each jouurnaltitle has one and only one (ct)journaltitletype.  
Each (ct)journaltitletype is for zero to many journalstitle.  
Each journal has zero to many journalidenitifers.  
Each journalidentifier is for one and only one journal.  
Each journalidentifier has one and only one (ct)journalidentifiertype.  
Each (ct)journalidentifiertype is for zero to many journalsidentifiers.  
Each publication has one and only one publicationtype.  
Each publicationtype is for zero to many publications.  
Each publication has zero to many publicationidenitifers.  
Each publicationidentifier is for one and only one publication.  
Each publicationidentifier has one and only one (ct)publicationidentifiertype.  
Each (ct)publicationidentifiertype is for zero to many publicationsidentifiers.  
Each publication has zero to many authors.  
Each author is for one and only one publication.  
Each catalogeditem is the catalog record for zero or one identifiableitem.  
Each catalogeditem is the catalog record for zero or one preparation.  
Each preparation is cataloged as zero or one catalogeditem.  
Each identifiableitem is cataloged as zero or one catalogeditem.  
Each catalogeditem is cataloged in one and only one catalognumberseries.  
Each catalognumberseries is used for zero to many catalogeditems.  
Each catalognumberseries is used in zero to many collections (a catalog number series can span more than one collection).  
Each collection uses zero to many catalognumberseries.  
Each unit was gathered in one and only one collectingevent.  
Each collectingevent results in the gathering of one to many units.  
Each collectingevent is at one and only one locality.  
Each locality is the site of zero to many collecting events.  
Each eventdate is the date collected for zero or one collectingevent.  
Each collectingevent has a date collected of zero or one eventdate.  
Each eventdate is the date sampled for zero or one materialsample.  
Each materialsample has a date sampled of zero or one eventdate.  
Each eventdate is the date cataloged for zero or one catalogeditem.  
Each catalogeditem has a date cataloged of zero or one eventdate.  
Each eventdate is the date identified for zero or one identification.  
Each identification has a date identified of zero or one eventdate.  
Each eventdate is the date verified for zero or one identification.  
Each identification has a date verified of zero or one eventdate.  
Each [arbitrary table (unit, identifieableitem, part, preparation)] has zero to many othernumbers.  
Each othernumber is for one and ony one [arbitrary table].  
Each transactionitem is zero or one preparation.  
Each preparation is zero to many transactionitems.  
Each transactionitem is in one and only one transaction(c).  
Each transaction(c) consists of zero to many transaction items.  
Each transaction(c) is zero or one loan.  
Each loan is one and only one transaction(c).  
Each transaction(c) is zero or one gift.  
Each gift is one and only one transaction(c).  
Each transaction(c) is zero or one borrow.  
Each borrow is one and only one transaction(c).  
Each transaction(c) is zero or one deaccession.  
Each deacession is one and only one transaction(c).  
Each transactionagent participates in one and only one transaction(c).  
Each transaction(c) has zero to many marticipating transactionagents.  
Each transactionagent is one and only one agent.  
Each agent may be zero to many transactionagents.  
Each catalogeditem has zero or one cataloging agent.  
Each agent cataloged zero to many catalogeditems.  
Each ctrelationshiptype has zero to many internationalization in codetableint (join on relationship-key_name).  
Each codetableint provides zero to one internationalization of ctrelationshiptype (join on relationship-key_name).  
Each agent is a member of zero to many agentteams.  
Each agent is the team for zero to many agentteams.  
Each agentteam links one and only one member agents.  
Each agentteam links one and only one team agent.  
Each agent has zero to many agentnumberpatterns.  
Each agentnumberpattern is for one and only one agent.  
Each agentreference is about one and only one agent.  
Each agent has zero to many agentreferences.  
Each agentreference is in one and only one publication.  
Each publication has zero to many agentreferences.  
Each agent has zero to many agentlinks.  
Each agentlink is for one and only one agent.  
Each agent has zero to many agentnames.  
Each agentname is for one and only one agent.  
Each agentname has one and only one name type (ctnametypes.type).  
Each ctnametype is the type for zero to many agentnames.  
Each cttextattribute type is the key for zero to many textattributes.  
Each textattribute has one and only one cttextattributetype as a key.  
Each textattribute applies to one and only one row in a table (keyed on for_table and primary_key_value).  
Each row in a table has zero to many textattributes (keyed on for_table and primary_key_value).  
Each inference applies to one and only one tuple (keyed on for_table, for_field, and primary_key_value).  
Each tuple has zero or one inference (keyed on for_table, for_field, and primary_key_value).  
Each numericattribute is of one and only one numericattrubutetype (ctnumericattributetype).  
Each ctnumericattributetype is the type of zero to many numeric attribtues.  
Each ctbiologicalattributetype has zero or one length unit in ctlengthunit.  
Each ctlengthunit is the length unit for zero to many ctbiologicalattributetypes.  
Each ctbiologicalattributetype has zero or one mass unit in ctmassunit.  
Each ctmassunit is the mass unit for zero to many ctbiologicalattributetypes.  
Each ctbiologicalattributetype is an age class in ctageclass.  
Each ctageclass is the age class for for zero to many ctbiologicalattributetypes.  
Each _code table_ has zero to many scopes in scopect.  
Each scopect provides the scope for zero to many _code table_.  
Each scopect has one and only one scope.  
Each scope applies to zero to many scope_id.  
Each scopect is for one and only one key name in a code table.  
Each key name in a code table has zero to many scope-codetable relations in codect.  
Each biologicalattribute is of one and only one biologicalattrubutetype (ctbiologicalattributetype).  
Each ctbiologicalattributetype is the type of zero to many biological attribtues.  
Each biologicalattribute applies to zero or one identifiable item.
Each identifiable item has zero to many biological attribtues.
Each biologicalattribute applies to zero or one part.
Each part has zero to many biological attribtues.
Each _arbitrary table_ has zero to many auditlogs.  
Each audit log is for one and only one _arbitrary table_.  
Each auditlog records an action by one and noly one agent.  
Each agent made a change recorded in zero to many auditlogs.  
Each encumberance is of one and only one encumberancetype (ctencumberancetype).  
Each ctencumberancetype is the type of zero to many encumberances.  
Each encumberance was created by one and only one agent.  
Each agent is the creator of zero to many encumberances.  
Each encumberance is visible to one and only one scope.  
Each scope provides the visiblility for zero to many encumberances.  
Each encumberance is zero to many catitemencumberances.  
Each catitemencumberance is one and only one encumberance.  
Each catitemencumberance is for one and only one catalogeditem.  
Each encumberance is zero to many attachmentencumberances.  
Each attachmentencumberance is one and only one encumberance.  
Each attachmentencumberance is for one and only one attachment.  
Each encumberance is zero to many localityencumberances.  
Each localityencumberance is one and only one encumberance.  
Each localityencumberance is for one and only one locality.  
Each encumberance is zero to many taxonencumberances.  
Each taxonencumberance is one and only one encumberance.  
Each taxonencumberance is for one and only one taxon.  
Each address is for one and only one agent.  
Each agent has zero to many addresses.  
Each address starts use at zero or one eventdate.  
Each eventdate is the start for one and only one address.  
Each address ends use at zero or one eventdate.  
Each eventdate is the end for one and only one address.  
Each electronicaddress is of one and only one (ct)electronicaddresstype.  
Each ctelectronicaddresstype provides the type for zero to many electronic addresses.  
Each electronicaddress is for one and only one agent.  
Each agent has zero to many electronicaddresses.  
Each addressofrecord is a preserved address for one and only one agent.  
Each agent has zero to many preserved addressesofrecord.  
Each loan has zero or one recipient addressofrecord.  
Each addressofrecord is the recipient address for zero to many loans.  
Each gift has zero or one recipient addressofrecord.  
Each addressofrecord is the recipient address for zero to many gifts.  
Each borrow has zero or one sender addressofrecord.  
Each addressofrecord is the sender address for zero to many borrows.  
Each accession was received on zero or one eventdate.  
Each accession was accessioned on zero or one eventdate.  
Each accession was acknowleged on zero or one eventdate.  
Each eventdate is the received date for zero or one accession.  
Each eventdate is the accession date for zero or one accession.  
Each eventdate is the acknowleged date for zero or one accession.  
Each accession is visible within one and only one scope.  
Each scope provides visibility for zero to many accessions.  
Each accession is under zero to one repositoryagreement.  
Each repositoryagreement applies to zero to many accessions.  
Each accession has zero to one source addressofrecord.  
Each addressofrecord is the source for zero or one accession.  
Each repositoryagreeement is visible within one and only one scope.  
Each scope provides visibility for zero to many repositoryagreements.  
Each repositoryagreement is an agreement with one and only one agent.  
Each agent has zero to many repositoryagreements.  
Each repositoryagreement has zero to one addressofrecord.  
Each addressofrecord is for for zero or one repositoryagreeement.  
Each accession has zero to many accessionagents.  (Each accession has zero or one accessionagent with a particular agent in a particular role).  
Each accessionagent is for one and only one accession.  
Each accessionagent is one and only one agent.  
Each agent is zero to many accessionagents.  
Each attachmentrelation involves one and only one attachment.  
Each attachment is involved in zero to many attachmentrelations.  
Each attachmentrelation involves one and only one _arbitrary table_.  
Each _aribtrary table_ has zero to many attachmentrelations.  
Each collector is zero to one agent.  
Each agent is one to many collectors.  
Each collector collected in zero to many collectingevents.  
Each collectingevent had one and only one collector (handle teams by verbatim collector and etal, then parse into collectoragent as a group with etal).  
Each coordinate is of one and only one (ct)coordinatetype.  
Each (ct)coordintetype is the type for zero to many coordinates.  
Each locality has zero to many coordinates.  [Each locality has zero to one coordinate of a given type].  
Each coordinate is for one and only one locality.  
Each locality has zero to many georeferences.  
Each georeference is for one and only one locality.  
Each georeference was georeferenced on zero to one eventdate.  
Each eventdate is the date of zero or one georeference.  
Each georeference was by one and only one agent.  
Each agent made zero to many georeferences.  
Each locality is politically contained in zero or one geography.  
Each locality is geographically contained in zero or one geography.  
Each geography is the political container for zero to many localities.  
Each geography is the geographic container for zero to many localities.  
Each geographytreedef is the tree for zero to many geographytreedefitem nodes.  
Each geographytreedefitem is a node in one and only one geographytreedef.  
Each geography is defined by one and only one geographytreedefitem.  
Each geographytreedefitem defines zero to many taxa.  
Each catalogeditem is cataloged in one and only one collection.  
Each collection catalogs zero to many catalogeditems.  
Each collection falls into zero or one scope.  
Each scope convers zero to many collections.  
Each preparation has one and only one storage location.  
Each storage is the location for zero to many preparations.  
Each storagetreedef is the tree for zero to many storagetreedefitem nodes.  
Each storagetreedefitem is a node in one and only one storagetreedef.  
Each storage is defined by one and only one storagetreedefitem.  
Each storagetreedefitem defines zero to many taxa.  
Each storage has one and only one scope.  
Each scope is for zero to many storage.  
Each storage has zero or one parent storage.  
Each storage is the parent for zero to many other storages.  
Each rocktimeunit has zero or one parent rocktimeunit.  
Each rocktimeunit is the parent for zero to many rocktimeunits.  
Each rocktimeunittreedef is the tree for zero to many rocktimeunittreedefitem nodes.  
Each rocktimeunittreedefitem is a node in one and only one rocktimeunittreedef.  
Each rocktimeunit is defined by one and only one rocktimeunittreedefitem.  
Each rocktimeunittreedefitem defines zero to many taxa.  
Each collectingevent has zero or one paleocontext.  
Each locality has zero or one paleocontext.  
Each paleocontext is for zero to many collecting events.  
Each paleocontext is for zero to many localities.  
Each paleocontext includes zero or one lithostratigraphicunit (rock rocktimeunit).  
Each paleocontext has zero or one lower bound earlyest (time/timerock) rocktimeunit.  
Each paleocontext has zero or one upper bound latest (time/timerock) rocktimeunit.  
Each lithostratigraphic unit (rocktimeunit) is exposed in zero to many paleocontexts.  
Each rocktimeunit is the lower bound for zero to many paleocontexts.  
Each rocktimeunit is the upper bound for zero to many paleocontexts.  
Each systemuser is one and only one agent.  
Each agent is also zero or one systemuser.  


[erDiagramCore]: https://raw.githubusercontent.com/chicoreus/cco_poc/master/src/main/resources/edu/harvard/huh/specify/datamodel/cco_full/model/core_er_diagram.png "E-R Diagram of core tables."

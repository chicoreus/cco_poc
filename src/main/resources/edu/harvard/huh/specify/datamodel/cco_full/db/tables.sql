-- liquibase formatted sql

-- Schema for DINA with the CCO model at the core, strong influence from Specify-6 and influence from Arctos.
-- General conventions: table and field names in all lower case, with underscore separators for names composed from multiple words.
-- @author Paul J. Morris

-- Framework for access control.
-- changeset chicoreus:001

CREATE TABLE scope ( 
   -- Definition: Institutions and departments for which access control limitations may be applicable for some data.  NOTE: Serves to support the functionality provided with virtual private databases in Arctos.  
   scope_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   name varchar(255) not null,  -- the name for the scope, that is the name of the 
   parent_scope_id bigint default null,  -- Normally expected that there might be two levels of scope limitations, institutions and departments.
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Force combination of name and parent to be unique.
create unique index idx_scope_u_scopeparname on scope(name, parent_scope_id);
alter table scope add constraint fk_scope_parentscopeid foreign key (parent_scope_id) references scope(scope_id) on update cascade;

-- Each scope has zero to one parent scope
-- Each scope is the parent for zero to many scopes

-- changeset chicoreus:002

CREATE TABLE principal (
   -- Definition: An entity to which some set of access rights may apply, typically a group. (e.g. a principal may be "data entry", a group having some set of access rights for data entry, which rights and how they are implemented is not specified here).
   principal_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   principal_name varchar(255) not null,  -- The name of this principal.
   is_active boolean not null default TRUE, -- does this principal have any currently active rights 
   scope_id bigint not null, -- the scope to which this principal extends (e.g. principal may be data entry, scope limits that to data entry in some collection.
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_principal_u_scopename on principal(principal_name, scope_id);
alter table principal add constraint fk_principal_scopeid foreign key (scope_id) references scope(scope_id) on update cascade;
-- Each principal has one and only one scope
-- Each scope is for zero to many principals

-- changeset chicoreus:003

CREATE TABLE systemuser ( 
   -- Definition: A user of the system.
   systemuser_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   username varchar(255) not null,  -- The login username for this system user.
   password_hash varchar(900) not null default '', -- cryptographic hash of the password for this user
   is_enabled boolean default TRUE, -- Is login enabled for this user, user interfaces must prevent login unless this is true.
   last_login date,  -- Date of last login. 
   user_agent_id bigint not null, -- The agent record for this user.  All users must also have agent records.
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_sysuser_u_username on systemuser (username);

-- changeset chicoreus:004
CREATE TABLE systemuserprincipal (
   -- Definition: Participation of a system user in principals (associative entity relating systemusers to principals).
   systemuserprincipal_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   systemuser_id bigint not null,  -- The system user that is some principal.
   principal_id bigint not null,  -- The principal that is some system user.
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_syuspr_u_sysuserprincipal on systemuserprincipal(systemuser_id, principal_id);

alter table systemuserprincipal add constraint fk_supr_sysuserid foreign key (systemuser_id) references systemuser(systemuser_id) on update cascade;
alter table systemuserprincipal add constraint fk_supr_principalid foreign key (principal_id) references principal(principal_id) on update cascade;
-- Each systemuser has zero to many principals
-- Each principal is for zero to many systemusers
-- Each systemuserprincipal is for one and only one principal 
-- Each principal has zero to many systemuserprincipals
-- Each systemuserprincipal is for one and only one systemuser
-- Each systemuser has zero to many systemuserprincipals

-- changeset chicoreus:005

-- Picklist handling, picklist/picklistitem handle bindings for specific fields, other ct (code tables) handle bindings for more generic attribute types. Includes internationalization - translations for picklist items.  

CREATE TABLE picklist (
  -- Definition: describes the binding of controled vocabularies (picklistitem) to specific database fields.
  picklist_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  name varchar(64) not null,  -- a name for the picklist 
  table_name varchar(64) not null,  -- the table to which this picklist applies
  field_name varchar(64) not null,  -- the field name in table to which this picklist applies
  read_only boolean not null default 0, -- picklist items should not be editable through a picklist editor ui, true for picklists corresponding to enum data types.
  size_limit int(11) default null,   
  picklist_order_hint enum('ordinal','alphabetic','numeric') not null default 'ordinal', -- hint to the UI on what order to apply for the items in the picklist.
  picklist_type_hint enum('select','filtering','radio') not null default 'select', -- hint to the UI of what sort of control to use to render the picklist.
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE INDEX idx_picklist_name ON picklist(name); 
CREATE UNIQUE INDEX idx_picklist_u_tablefield ON picklist (table_name,field_name); -- one picklist for a field in a table, scope is per item.

-- Each picklist applies to one and only one table and field 
-- Each table and field may have zero to one picklist

-- changeset chicoreus:006
CREATE TABLE picklistitem (
  -- Definition: code table defining context sensitive controled vocabularies for specific fields in the database.
  picklistitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  picklist_id bigint not null,  -- the picklist to which this picklist item belongs
  scope_id bigint default null,  -- if not null, only show this picklist item in this context (e.g. limit 'egg' as an age class to ornithology).
  ordinal int(11) default null,  -- sort order for picklist items
  title varchar(64) not null,  -- option to show to users (e.g. 'yes', 'no', 'juvenile')
  value varchar(64) default null, -- value to store in database (e.g. 1, 0, 'juvenile'), should be different from title only if field type is numeric (e.g. yes=1).
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE picklistitem add constraint fk_pklstit_picklist_id foreign key (picklist_id) references picklist(picklist_id) on update cascade on delete cascade;  
ALTER TABLE picklistitem add constraint fk_pklstit_scope_id foreign key (scope_id) references scope(scope_id) on update cascade;  
-- Each picklist has zero to many picklistitems
-- Each picklistitem is on one and only one picklist 
-- Each ctpiclistitem is in zero to one scope (where zero scopes means the picklistitem applies in any scope)
-- Each scope may apply to zero to many picklistitems

-- changeset chicoreus:007
CREATE TABLE picklistitemint (
    -- Definition: internationalization for picklist items, allows use of a single language key in picklist items, provides translations of that key and definitions for that key in an arbitrary number of languages.  Because picklistitems have scopes and picklists, picklist.title is not expectd to be unique, and thus the same key for different picklists or scopes may have different definitions, thus picklistitem internationalization needs to relate to picklistitem by primary key.  
    picklistitemint_id bigint not null primary key auto_increment, -- surrogate numeric primary key
    picklistitem_id bigint not null, -- the picklistitem which for which this is an internationalization
    lang varchar(10) not null default 'en-gb',  -- language for this record
    title_lang varchar(255),  -- translation of value to be shown to users into lang
    definition text,  -- definition of name in lang
    modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

ALTER TABLE picklistitemint add constraint fk_pklstitint_pklstitid foreign key (picklistitem_id) references picklistitem(picklistitem_id) on update cascade;  
-- Each picklistitem has zero to many translations in picklistitemint
-- Each picklistitemint is a translation for one and only one picklistitem 

-- code tables (tables prefixed by ct and keyed on a varchar(255)) have different bindings and are internationalized separately from picklistitems (which key on a surrogate numeric primary key).

-- changeset chicoreus:008
CREATE TABLE codetableint ( 
    -- Definition: internationalization for code tables (where , allows use of a single language key in code tables, provides
    -- translations of that key and definitions for that key in an arbitrary number of languages.  Applies to code tables 
    codetableint_id bigint not null primary key auto_increment, -- surrogate numeric primary key
    key_name varchar(255) not null, -- name/key in code table.  (e.g. miles in a length unit code table.
    codetable varchar(255) not null, -- code table (table name prefixed ct) in which name is found.
    lang varchar(10) not null default 'en-gb',  -- language for this record
    key_name_lang varchar(255),  -- translation of name into lang
    definition_lang text,  -- definition of key_name in lang
    modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- unit, identifiableitem, preparation, part, and catalogeditem are the core tables of the cco model.

-- changeset chicoreus:009
CREATE TABLE unit (
  -- Definition: logical unit that was collected or observed in a collecting event.
  unit_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  unit_field_number varchar(255),  -- number assigned by the collector to this collection at the collecting event, see also collectingevent.event_field_number
  materialsample_id bigint,
  verbatim_collection_description text,
  collectingevent_id bigint not null,
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- Each unit was collected in one and only one collectingevent.
-- Each collectingevent had zero to many units collected in it.

-- Each unit had zero or one materialsample derived from it.
-- Each prepraration has zero or one material sample derived from it.
-- Each materialsample is derived from zero or one one unit.
-- Each materialsample is derived from zero or one preparation.

-- Each unit is composed of zero to many preparations (many to many unit-preparation relation with identifiable item as an associative entity)
-- Each preparation is a physical preparation of one to many units 

-- changeset chicoreus:010
CREATE TABLE identifiableitem (
  -- Definition: a component of a unit for which a scientific identification can be made.
  identifiableitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  occurrence_guid varchar(900),  -- dwc:occurrenceId
  unit_id bigint not null,  -- the unit in which this identifiable item was collected,
  catalogeditem_id bigint,
  individual_count int,
  individual_count_modifier varchar(50),  -- e.g. +
  individual_count_units varchar(50),      -- e.g. valves
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

ALTER TABLE identifiableitem add constraint fk_iditem_unitid foreign key (unit_id) references unit (unit_id) on update cascade;  

-- Each identifiable item comes from one and only one unit
-- Each unit has zero to many identifiable items

-- To apply a pick list to a field, first define a picklist
-- then define the items which comprise that pick list.

-- changeset chicoreus:t_biol_individ

CREATE TABLE biologicalindividual (
  -- Definition: An individual organism that is specifically known and identified and known as that individual to have been observed or sampled.
  biologicalindividual_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  biologicalindividual_guid varchar(900), -- guid for the biological individual darwinsw:{term}
  name varchar(900), -- human readable identifier for the biological individual
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- changeset chicoreus:011
CREATE TABLE part ( 
  -- Definition:  Associative entity between identifiable items and preparations.  Generally parts of organisms that comprise preparations.  Parts are biologically logical components of organisms.
  part_id bigint not null primary key auto_increment,  -- surrogae numeric primary key 
  identifiableitem_id bigint not null,  -- the identification of the organism that this part is of
  preparation_id bigint not null, -- the preparation this part is in/on/is.
  part_name varchar(50) not null, -- the name of this part
  lot_count int(11) default 1,     -- the number of items comprising this part (e.g. number of specimens in a lot)
  lot_count_modifier varchar(50) default '',  -- a modifier for the lot count (fragments, valves, ca., ?).
  biologicalindividual_id bigint, -- biological individual this is a part of
  coordinates varchar(255), -- for parts that require representation of location on a preparation (e.g. an x,y coordinate on a slide).
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;


-- changeset chicoreus:012
CREATE TABLE preparation (
  -- Definition: an existing or previous physical artifact that could participate in a transaction, e.g. be sent in a loan.   Preparations are physically stored sets of parts (to allow for records of observations, allow for preparations that form non-physical vouchers or records of the observation).
  -- note: does not specify preparation history or conservation history, additional entities are needed for these.
  preparation_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  prep_exists boolean not null default TRUE, -- does this preparation still exist as a physical loanable artifact (false if the preparation has been entirely split into child preparations, or if the preparation has otherwise been destroyed, or if the preparation is a digital record of an observation, otherwise true).
  catalogeditem_id bigint,
  materialsample_id bigint,
  preparation_type varchar(50),
  preservation_type varchar(50),
  conservation_status varchar(255),
  parent_preparation_id bigint,   -- the preparation from which this preparation was derived. 
  status varchar(32) default 'in collection',
  description text default null,
  storage_id bigint default null,  -- The current storage location for this preparation, if any.
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- Each preparation may be the parent of zero to many child preparations (e.g. a slide prepared from a whole animal)
-- Each preparation has zero or one parent preparation from which it was derived.

-- Each identifiable item has zero to one parts preserved in a collection.
-- Each part is one and only one identifable item.

-- Each part is prepared as as one and only one preparation.
-- Each preparation is composed of one to many parts

ALTER TABLE preparation add constraint fk_parentprep foreign key (parent_preparation_id) references preparation (preparation_id) on update cascade; 

--  aleternative relations not used:
--  ALTER TABLE preparation add constraint fk_deritentitem foreign key (derived_from_identifiable_item_id) references identifiableitem (identifiableitem_id) on update cascade;
--  ALTER TABLE preparation add constraint fk_prepofitem foreign key (preparation_of_identifiable_item_id references identifiableitem (identifiableitem_id) on update cascade;

ALTER TABLE identifiableitem add constraint fk_item_unitid foreign key (unit_id) references unit(unit_id) on update cascade;  

ALTER TABLE part add constraint fk_item_prepid foreign key (preparation_id) references preparation (preparation_id) on update cascade;
ALTER TABLE part add constraint fk_item_itemid foreign key (identifiableitem_id) references identifiableitem (identifiableitem_id) on update cascade;

-- Each preparation may be a preparation of zero or one identifiable item.
-- Each identifiable item may be prepared into zero to many preparations.

-- changeset chicoreus:013
CREATE TABLE identification (
   -- Definition: the application of a scientific name by some agent at some point in time to an identifiable item.  Includes both non-type and type identifications and metadata about validation of type status.
   identification_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   identifiableitem_id bigint not null,  -- the identifiable item to which this identification applies
   taxon_id bigint not null,  -- the taxon applied to the identifiable item in this identification
   verbatim_scientific_name_string varchar(900), -- the verbatim scientific name string used in the identification (allows, for example, for recording of formulations that embed a qualifier such as 'Aus cf. bus', and cases where generic epithet has been inferred e.g. 'alba' or 'P. alba').
   qualifier varchar(16) default null,  -- determiner's qualification of the application of the taxon name or its scope in the identification
   confidence varchar(50) default null,  -- assertion concerning the confidence in the identification 
   determiner_agent_id bigint,  -- the agent who made the identification
   date_determined_eventdate_id bigint, -- the date on which the identification was made
   type_status varchar(50) not null default '',  -- the type status asserted in this identification
   type_status_qualifier varchar(16) default null,  -- qualification of the type status (e.g. '?')
   verifier_agent_id bigint,  -- the agent who verified the type status of this identification 
   date_verified_eventdate_id bigint,  -- the event date for this type status verification 
   verbatim_annotation_text text,  -- verbatim text of the annotation by the annotator, can include additional information beyond name and type status
   addendum varchar(16) default null,
   basis text default null,  -- characters or other basis for making the identification 
   is_current boolean not null, -- is this considered the current identification for this identifiable item
   is_filed_under boolean not null, -- is this name used to determine the storage location for this identifiable item
   method varchar(50) default null,  -- method for making the identification 
   taxon_concept_identifier varchar(900) default null,  -- a species number or other identifier of the taxon concept used in the identification
   modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
   remarks text  -- remarks concerning the identification 
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_ident_u_dateidentid on identification(date_determined_eventdate_id);  --  Event dates should not be reused.
create unique index idx_ident_u_dateverifid on identification(date_verified_eventdate_id);  --  Event dates should not be reused.

ALTER TABLE identification add constraint fk_ident_itemid foreign key (identifiableitem_id) references identifiableitem (identifiableitem_id) on update cascade;
-- Each identifiableitem has zero to many identifications.
-- Each identification is of one and only one identifiable item. 

-- Each identification has zero or one determining agent.
-- Each agent is the determiner for zero to many identifications.

-- Each identification has zero or one verifying agent.
-- Each agent is the verifier for zero to many identifications.



--  picklist for preparation types

-- scientific name strings and taxonomic placement therof

-- changeset chicoreus:014

CREATE TABLE taxon (
   -- Definition: A scientific name string that may be curated to be linked to a nomeclatural act or to an authoriative record of a name usage.
   taxon_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   scientific_name varchar(900) not null,   -- the complete scientific name for the taxon, without the authorship string
   trivial_epithet varchar(64) not null,    -- the lowest rank epithet of this scientific name (e.g. the subspecific eptithet for a subspecies).
   cultivar_name varchar(32) default null,  
   authorship varchar(900) not null default '',  -- the authorship string for the scientific name
   nomenclatural_code varchar(20) default null,  -- the nomenclatural code that applies to the formulation of this name and its authorship 
   display_name varchar(2000) default null,  -- assembled name, with markup for display in html
   parent_id bigint,   -- pointer to parent node in tree 
   parentage varchar(2000),  -- enumerated path from current node to root of tree, using '/' as a separator, starting with a separator, ending with the parent_id of the current node.  Populated with a trigger.
   taxontreedefitem_id bigint not null, -- what is the definition for this node
   status varchar(50),  -- taxonomic and nomenclatural status for this name
   status_notes text,  -- remarks concerning the taxonomic and nomenclatural status of this name 
   accepted_taxon_id bigint,  -- pointer to another node in tree which is the accepted name to use for this taxon in the opinion of the collection.
   source varchar(64) default null,  -- the source from which this taxon name record was derived 
   nomenclator_guid varchar(2000) default null,  -- A guid in a nomenclator for the nomenclatural act associated with this scientific name string
   usage_guid varchar(2000) default null,  -- A guid in a taxonomic authority source for a scientifc name usage associated with this scientific name string (for linking to authorities that curate usage records in addition to nomenclatural acts (e.g. a WoRMS aphiaid)).
   curated boolean default false,  -- if true, taxon record has been curated, local or system policy may limit changes to curated taxon records
   author_agent_id bigint,    -- zoological and botanical
   parauthor_agent_id bigint, -- zoological and botanical
   exauthor_agent_id bigint,  -- botanical
   parexauthor_agent_id bigint,  -- botanical
   sanctauthor_agent_id bigint,  -- botanical (fungal)
   parsanctauthor_agent_id bigint,  -- botanical (fungal)
   cited_in_agent_id bigint,  -- zoological and botanical, reference to a name usage
   year_published varchar(50),  -- the year this name was published in, per the relevant code (year for the protonym in ICZN, year for the combination in ICNafp).
   publication_id bigint,  -- the publication containing the nomenclatural act that created the protonym/basionym for this scientific name (the publication in which this taxon was originaly described).
   cites_status varchar(32) not null default 'none',  -- CITES listing for this taxon.
   modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
   remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- Each identification involves one and only one taxon.
-- Each taxon is used in zero to many identifications.

-- Each taxon has zero or one accepted taxon 
-- Each taxon is accepted for zero to many taxa.

-- Each taxon is defined by one and only one taxontreedefitem
-- Each taxontreedefitem defines zero to many taxa

-- Each taxon has zero or one parent taxon (each taxon except the root node has one and only one parent taxon)
-- Each taxon is the parent for zero to many child taxa

-- Each taxon has zero or one author agent.
-- Each agent is the author for zero to many taxa.

-- Each taxon has zero or one parenthetical author agent.
-- Each agent is the parenthetical author for zero to many taxa.
-- Each taxon has zero or one ex author agent.
-- Each agent is the ex author for zero to many taxa.
-- Each taxon has zero or one parenthetical ex author agent.
-- Each agent is the parenthetical ex author for zero to many taxa.
-- Each taxon has zero or one sanctioning author agent.
-- Each agent is the sanctioning author for zero to many taxa.
-- Each taxon has zero or one parenthetical sanctioning author agent.
-- Each agent is the parenthetical sanctioning author for zero to many taxa.
-- Each taxon has zero or one cited in author agent.
-- Each agent is the cited in author for zero to many taxa.

-- Each taxon was created in a nomenclatural act published in zero or one publication.
-- Each publication contains zero to many nomenlcatural acts creating taxa.

create index idx_taxon_acceptaxonid on taxon (accepted_taxon_id); 
alter table taxon add constraint fk_taxon_acceptedid foreign key (accepted_taxon_id) references taxon (taxon_id) on update cascade;
alter table taxon add constraint fk_taxon_parentid foreign key (parent_id) references taxon (taxon_id) on update cascade;

-- changeset chicoreus:015
CREATE TABLE taxontreedef (
  -- Definition: Definition of a taxonomic tree
  taxontreedef_id bigint NOT NULL primary key AUTO_INCREMENT,
  full_name_direction int(11) DEFAULT -1,  -- direction of assembly of full name
  name varchar(64) NOT NULL, -- name of the taxon tree
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


-- changeset chicoreus:016
CREATE TABLE taxontreedefitem (
  -- Definition: Definition of ranks within a taxon tree.  NOTE: Because Phylum is used for animals and Division for plants, and it is expected that both are defined in a single tree, the definitions form a map rather than a tree, so parentid and parentage aren't used.  A sort on values for rank_id is needed to find the next higher or next lower rank definition.
  taxontreedefitem_id bigint NOT NULL primary key AUTO_INCREMENT,
  full_name_separator varchar(32) not null default ' ', -- separator to use between this element and any lower rank taxon when assembling full name
  is_enforced boolean not null default FALSE, -- Must be included in tree for any node at this or lower (larger rank_id) rank
  is_in_full_name boolean not null DEFAULT FALSE,  -- Must be included in full name for any node at this 
  name varchar(64) NOT NULL,  -- the name of this rank
  nomenclatural_code varchar(20) not null default 'Any',  -- the nomenclatural code in which this rank is used
  rank_id int(11) NOT NULL,  -- Root of tree is zero.  Numerically higher ranks are lower in the taxonomic tree.  
  text_after varchar(64) DEFAULT NULL, -- text to include before this element when using in full name 
  text_before varchar(64) DEFAULT NULL, -- text to include after this element when using in full name
  taxontreedef_id bigint NOT NULL,  -- The taxon tree to which this rank definition applies
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table taxontreedefitem add constraint fk_ttdefitem_ttreedef foreign key (taxontreedef_id) references taxontreedef (taxontreedef_id) on update cascade;

alter table taxon add constraint fk_taxon_ttdefitem_id foreign key (taxontreedefitem_id)  references taxontreedefitem (taxontreedefitem_id) on update cascade;

-- Each taxontreedef is the tree for zero to many taxontreedefitem nodes.
-- Each taxontreedefitem is a node in one and only one taxontreedef.

ALTER TABLE identification add constraint fk_idtaxon foreign key (taxon_id) references taxon (taxon_id) on update cascade;
ALTER TABLE taxon add constraint fk_idparent foreign key (parent_id) references taxon (taxon_id) on update cascade;
ALTER TABLE taxon add constraint fk_idaccepted foreign key (accepted_taxon_id) references taxon (taxon_id) on update cascade;


-- changeset chicoreus:017
CREATE TABLE journal (
  -- Definition: A serial work.
  journal_id bigint not null primary key auto_increment, -- Surrogate numeric primary key
  bhl_record varchar(244),  -- The url for the bibliographic record for this journal in BHL e.g. http://www.biodiversitylibrary.org/bibliography/62169
  publisher varchar(64) default null,
  place_of_publication varchar(255) default null,
  first_year_published int,  -- The first year in which this serial was published.
  last_year_published int,  -- The last year in which this serial was published.
  remarks text,
  preceding_journal_id bigint default null,
  succeeding_journal_id bigint default null,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table journal add constraint fk_journal_precedingid foreign key (preceding_journal_id) references journal (journal_id) on update cascade;
alter table journal add constraint fk_journal_succeedingid foreign key (succeeding_journal_id) references journal (journal_id) on update cascade;

-- Each journal is preceded by zero or one preceding journal.
-- Each journal is the preceding journal for zero to many journals.

-- Each journal is succeeded by zero or one succeeding journal.
-- Each journal is the succeeding journal for zero to many journals.

-- changeset chicoreus:018
CREATE TABLE journaltitle (
  -- Definition: Titles of serial works.
  journaltitle_id bigint not null primary key auto_increment, -- Surrogate numeric primary key
  journal_id bigint not null,  -- The serial work for which this is a title.
  title text,  --  The title of the work.
  title_type varchar(50) not null,  -- The kind of title.
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=myisam -- to ensure support for fulltext index
DEFAULT CHARSET=utf8;

create fulltext index ft_journaltitle on journaltitle(title);
create unique index ft_journaltitlety on journaltitle(title_type,journal_id);

alter table journaltitle add constraint fk_journaltitle_jourid foreign key (journal_id) references journal (journal_id) on update cascade;

-- Each journal has zero to many titles.
-- Each title is for one and only one journal.

-- changeset chicoreus:019
CREATE TABLE ctjournaltitletype (
  -- Definition: controlled vocabulary for journal title types
  title_type varchar(50) not null primary key,  -- Type of journal title.
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table journaltitle add constraint fk_jtjournaltitletype foreign key (title_type) references ctjournaltitletype (title_type) on update cascade;

-- Each jouurnaltitle has one and only one (ct)journaltitletype.
-- Each (ct)journaltitletype is for zero to many journalstitle.


-- changeset chicoreus:020
CREATE TABLE journalidentifier (
  -- Definition: A unique identifier for a serial work (e.g. ISSN, OCLC, TL2, library call number, etc.).
  journalidentifier_id bigint not null primary key auto_increment, -- Surrogate numeric primary key
  journal_id bigint not null,  -- The serial work to which this identifier applies
  identifier varchar(255),     -- the identifier for this 
  identifier_type varchar(50) not null,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table journalidentifier add constraint fk_journalidentifier_jourid foreign key (journal_id) references journal (journal_id) on update cascade;

-- Each journal has zero to many journalidenitifers.
-- Each journalidentifier is for one and only one journal.

-- changeset chicoreus:021
CREATE TABLE ctjournalidentifiertype (
  -- Definition: controlled vocabulary for journal identifier types.
  identifier_type varchar(50) not null primary key,  -- Type of journal identifier.
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


alter table journalidentifier add constraint fk_journalidentifiertype foreign key (identifier_type) references ctjournalidentifiertype (identifier_type) on update cascade;

-- Each journalidentifier has one and only one (ct)journalidentifiertype.
-- Each (ct)journalidentifiertype is for zero to many journalsidentifiers.

-- changeset chicoreus:022
CREATE TABLE publication (
  -- Definition: A published work (e.g. a journal article, monograph, or book).
  publication_id bigint not null primary key auto_increment, -- Surrogate numeric primary key
  publication_type varchar(50) not null,
  first_page_url_in_bhl varchar(900),  -- The location for the first page of this work in BHL.
  guid varchar(128) default null,    -- The guid for this publication record
  is_published bit(1) default null,  -- Flag to indicate if this is a published work or an unpublished manuscript.
  actual_year_of_publication int default null,  -- The year on which this work was published.
  year_of_publication varchar(25) default null,  -- The year (or range of years, or purported and actual year) on which this work was published.
  edition varchar(50) default null,
  title varchar(900) default null,   -- The title of the work
  place_of_publication varchar(255) default null,
  publisher varchar(255) default null,
  volume varchar(50) default null,
  issue varchar(50) default null,
  number varchar(50) default null,
  series varchar(50) default null,
  section varchar(50) default null,
  start_page int default null,     -- The page number of the first page (for use with page turned objects).
  end_page int default null,       -- The page number of the last page (for use with page turned objects).
  pages varchar(50) default null,  -- Pages, front matter, plates, figures, maps, etc. for inclusion in a citation.
  remarks text,
  journal_id bigint default null,  -- The journal of which this publication is a part
  contained_in_publication_id bigint default null,  -- A publication within which this publication is contained "In".
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table publication add constraint fk_publication_jourid foreign key (journal_id) references journal (journal_id) on update cascade;
alter table publication add constraint fk_publication_containid foreign key (contained_in_publication_id) references publication (publication_id) on update cascade;

-- changeset chicoreus:023
CREATE TABLE ctpublicationtype ( 
   -- Definition: Controled vocabulary for publication types (e.g. books, journal articles, monographs, etc).  
   publication_type varchar(50) not null primary key,
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table publication add constraint fk_publicationtype foreign key (journal_id) references journal (journal_id) on update cascade;

-- Each publication has one and only one publicationtype.
-- Each publicationtype is for zero to many publications.

-- changeset chicoreus:024
CREATE TABLE publicationidentifier (
  -- Definition: A unique identifier for a publication.
  publicationidentifier_id bigint not null primary key auto_increment, -- Surrogate numeric primary key
  publication_id bigint not null,  -- The work to which this identifier applies
  identifier varchar(255),     -- The identifier for this work.
  identifier_type varchar(50) not null,  -- The type of identifier (e.g. ISBN).
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table publicationidentifier add constraint fk_pubidentifier_pubid foreign key (publication_id) references publication (publication_id) on update cascade;

-- Each publication has zero to many publicationidenitifers.
-- Each publicationidentifier is for one and only one publication.

-- changeset chicoreus:025
CREATE TABLE ctpublicationidentifiertype (
  -- Definition: controlled vocabulary for publication identifier types.
  identifier_type varchar(50) not null primary key  -- Type of publication identifier.
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


-- Each publicationidentifier has one and only one (ct)publicationidentifiertype.
-- Each (ct)publicationidentifiertype is for zero to many publicationsidentifiers.

alter table publicationidentifier add constraint fk_pubidentifiertype foreign key (identifier_type) references ctpublicationidentifiertype (identifier_type) on update cascade;

-- changeset chicoreus:026
CREATE TABLE author (
  -- Definition: Names of authors and editors of publications.
  author_id bigint not null primary key auto_increment, -- Surrogate numeric primary key 
  ordinal int not null,  -- The order of the author in a list of authors.
  role enum ('author','editor','in author'),  -- Whether the author's role is as author or editor.
  publication_id bigint not null,  -- The publication for which this is an author.
  agentname_id bigint not null,  -- The name of the author/editor
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table author add constraint fk_authorpub foreign key (publication_id) references publication (publication_id) on update cascade;

create unique index idx_u_author_puborderrole on author(publication_id, ordinal, role);

-- Each publication has zero to many authors.
-- Each author is for one and only one publication.

-- changeset chicoreus:027
CREATE TABLE catalogeditem (
   -- Definition: the application of a catalog number out of some catalog number series.
   catalogeditem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   catalognumberseries_id bigint not null, -- The catalog number series from which the catalog_number comes.
   catalog_number varchar(255) not null,
   date_cataloged_eventdate_id bigint,
   cataloger_agent_id bigint,  -- The agent who cataloged the cataloged item
   accession_id bigint not null,  -- The accession in which ownership of this cataloged item was taken
   collection_id bigint not null,  -- The collection within which this item is cataloged (catalog number series doesn't uniquely idenitify collections).
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_catitem_u_datecatid on catalogeditem(date_cataloged_eventdate_id);  --  Event dates should not be reused.


-- Each catalogeditem is the catalog record for zero or one identifiableitem.
-- Each catalogeditem is the catalog record for zero or one preparation.

-- Each preparation is cataloged as zero or one catalogeditem.
-- Each identifiableitem is cataloged as zero or one catalogeditem.

-- changeset chicoreus:028
CREATE TABLE materialsample(
   -- Definition: see darwincore.
   materialsample_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   materialsample_guid varchar(255) not null,  -- dwc:materialSampleID
   sample_number varchar(255),  
   date_sampled_eventdate_id bigint,  -- the date the material sample was created
   modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
   sampled_by_agent_id bigint -- the agent who created the material sample
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_matsamp_u_datesampid on materialsample(date_sampled_eventdate_id);  --  Event dates should not be reused.

-- changeset chicoreus:029
CREATE TABLE catalognumberseries ( 
   -- Definition: a sequence of numbers of codes assigned as catalog numbers to material held in a natural science collection.
   catalognumberseries_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   name varchar(900),  -- a name for the catalog number series
   catalognumber_prefix varchar(50) not null default '', -- The prefix, if any, to append to the catalognumber to identify numbers from this catalog number series. 
   policy varchar(50) not null default 'active, manual',  -- A policy for assigning catalognumbers 
   nextavailablenumber varchar(255), -- Place where the next number to be assigned from this number series can be managed when automatically assigned.
   dataset varchar(900),  -- dwc:datasetName
   dataset_guid varchar(900), -- dwc:datasetId
   remarks text,
   modified_by_agent_id bigint not null default 1
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- changeset chicoreus:030
CREATE TABLE ctcatnumseriespolicy (
   policy varchar(50) not null primary key
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;


-- changeset chicoreus:031
ALTER TABLE catalognumberseries add constraint fk_cns_policy foreign key (policy) references ctcatnumseriespolicy (policy) on update cascade;

-- Each catalogeditem is cataloged in one and only one catalognumberseries.
-- Each catalognumberseries is used for zero to many catalogeditems.

-- changeset chicoreus:032
CREATE TABLE catnumseriescollection ( 
   catnumseriescollection_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   catalognumberseries_id bigint not null, 
   collection_id bigint not null, -- the collection to which this catalog number series belongs
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_cnsc_u_catnumsercollid on catnumseriescollection(catalognumberseries_id, collection_id); 

alter table catnumseriescollection add constraint fk_cnsc_canumserid foreign key (catalognumberseries_id) references catalognumberseries(catalognumberseries_id) on update cascade;

-- Each catalognumberseries is used in zero to many collections (a catalog number series can span more than one collection).
-- Each collection uses zero to many catalognumberseries.

-- changeset chicoreus:033
CREATE TABLE collectingevent (
   -- Definition: an event in which an occurrance was observed in the wild, and typically, for a natural science collection, a voucher was collected, time at which a collector visited a locality and collected one or more collected units using a single sampling method.
  collectingevent_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  locality_id bigint default null,
  collector_id bigint not null, -- the collector who collected in this collecting event.
  sampling_method varchar(50) default null,  -- the sampling method that was applied in this collecting event
  event_field_number varchar(255) default null,  -- a number assigned by the collector to the collecting event, this might be called a field number or a station number or a collector number, but the semantics for this number must be that it applies to the collecting event.
  date_collected_eventdate_id bigint default null, -- date or date range within which this collecting event occurred
  guid varchar(128) default null,
  paleocontext_id bigint default null,
  expedition varchar(900) default null,  -- named expedition that this collecting event was part of
  vessel varchar(900) default null,  -- RV, ship or other vessel that this collecting event was made from
  platform varchar(900) default null, -- submersible, ROV, or other platform that this collecting event was made from
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- Each unit was gathered in one and only one collectingevent.
-- Each collectingevent results in the gathering of one to many units.
-- Each collectingevent is at one and only one locality.
-- Each locality is the site of zero to many collecting events.

-- changeset chicoreus:034
create unique index idx_colev_u_datecollid on collectingevent(date_collected_eventdate_id);  --  Event dates should not be reused.
-- changeset chicoreus:035
alter table unit add constraint fk_unit_colleventid foreign key (collectingevent_id) references collectingevent(collectingevent_id) on update cascade;
alter table unit add constraint fk_unit_matsampid foreign key (materialsample_id) references materialsample(materialsample_id) on update cascade;

-- changeset chicoreus:036
CREATE TABLE eventdate ( 
   -- Definition: a set of spans of time in which some event occurred.  NOTE: Cardinality is enforced as zero or one to one in each relation with unique indexes, and event dates should not be reused accross relations.
   -- Remarks: When in a form that can't be tied to a year (e.g. "April", populate verbatim_date with the verbatim value, iso_date with an empty string, and use start_date and end_date to set plausible bounds for the interpretation of "April" (e.g. 1700-2015 for a record of unknown date entered in 2015).
   eventdate_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   date_type varchar(50) not null default 'date',
   verbatim_date varchar(255) not null,  -- the event date in its original verbatim form
   iso_date varchar(255) not null default '',  -- The event date in ISO form, including date ranges, use this to provide dwc:eventDate.
   start_date date not null,  -- the first plausible date for the event date in date form, used for sorting, must have a value provided.
   start_date_precision int,  -- precision of the start date (to year, to month, or to day)
   start_datetime datetime default null,  -- if start or end times are known
   end_date date,  -- the last plausible date of the event date in date form
   end_date_precision int, -- the precision of the end date (to year, to month, or to day)
   end_datetime datetime default null, -- if start or end times are known
   start_end_fully_specifies boolean default true, -- true if a single date or a continuous range, false for discontinuous cases that can't be represented as an iso_date such as "april and may of 1960-1963".
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;


-- Each eventdate is the date collected for zero or one collectingevent.
-- Each collectingevent has a date collected of zero or one eventdate.

-- Each eventdate is the date sampled for zero or one materialsample.
-- Each materialsample has a date sampled of zero or one eventdate.
-- Each eventdate is the date cataloged for zero or one catalogeditem.
-- Each catalogeditem has a date cataloged of zero or one eventdate.
-- Each eventdate is the date identified for zero or one identification.
-- Each identification has a date identified of zero or one eventdate.
-- Each eventdate is the date verified for zero or one identification.
-- Each identification has a date verified of zero or one eventdate.

-- changeset chicoreus:037
ALTER TABLE collectingevent add constraint fk_colevent_cdate foreign key (date_collected_eventdate_id) references eventdate (eventdate_id) on update cascade;
-- changeset chicoreus:038
ALTER TABLE materialsample add constraint fk_matsamp_samdate foreign key (date_sampled_eventdate_id) references eventdate (eventdate_id) on update cascade;
-- changeset chicoreus:039
ALTER TABLE catalogeditem add constraint fk_catitem_catdate foreign key (date_cataloged_eventdate_id) references eventdate (eventdate_id) on update cascade;
-- changeset chicoreus:040
ALTER TABLE identification add constraint fk_ident_detdate foreign key (date_determined_eventdate_id) references eventdate (eventdate_id) on update cascade;
ALTER TABLE identification add constraint fk_ident_verdate foreign key (date_verified_eventdate_id) references eventdate (eventdate_id) on update cascade;

-- changeset chicoreus:041
CREATE TABLE locality (
  -- Definition: a location
  locality_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  verbatim_locality text not null, -- the complete verbatim description of the locality
  specificlocality text not null, -- a textual description of the locality
  locality_name varchar(255) not null default '',  -- a name given to this locality
  locality_number varchar(255) not null default '', -- an identifying number assigned to this locality independent of time, applying to any sampling event from this locality.
  short_name varchar(32) default null,  -- a short form of a name given to this locality
  named_place varchar(255) default null,  -- a named place near the locality
  relation_to_named_place varchar(120) default null,  -- description of the offset from the named place to the locality 
  verbatim_coordinate text,  -- a verbatim coordinate for the locality, use coordinate to split into atomic parts, use georeference for standard form.
  verbatim_coordinatesystem varchar(255),  -- the coordinate system used in the verbatim coordinate (osgb, swiss grid, utm/ups, lat/long, etc).
  verbatim_datum varchar(255) default null,
  verbatim_elevation varchar(255) default null, -- elevation of the ground or water surface relative to a horizontal datum
  orginal_elevation_unit varchar(50) default null,  -- units for the verbatim elevation (feet, meters, etc.)
  verbatim_depth varchar(255) default null,  -- verbatim depth below a water surface
  original_depth_unit varchar(50) default null,  -- units (feet, meters, fathoms, etc.) for verbatim depth.
  verbatim_offset_from_surface varchar(255) default null, -- verbatim description of offset from the surface described by the elevation, could describe meters up into the tree canopy, or meters down a core, use for offsets other than into water, value should indicate if above or below surface.  
  original_offset_from_surface_unit varchar(50) default null, -- units for the offset from the surface
  guid varchar(128) default null,
  locality_according_to varchar(900),  -- source(s) for the information about this locality
  remarks text,
  paleocontext_id bigint default null,  -- a geological context for this locality
  geopolitical_geography_id bigint default null,  -- the political context for this locality (country/primary division/secondary division/municipality)
  geographic_geography_id bigint default null, -- the geographic context  for this locality (ocean, ocean region, ocean subregion, sea, continent, etc.),
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create index idx_local_name on locality(locality_name);
create index idx_local_num on locality(locality_number);
create index idx_local_shortname on locality(short_name);
create index idx_local_namedplace on locality(named_place);
create index idx_local_namedplacerel on locality(relation_to_named_place);

-- changeset chicoreus:042
CREATE TABLE othernumber (
   --  Definition: a number or code associated with a specimen that is not known to be its catalog number
   othernumber_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   target_table varchar(255) not null,  -- the table to which pk refers to the primary key.
   pk bigint not null,                 -- the surrogate numeric primary key of a row in target_table.
   number_type varchar(255) not null,  -- the type of other number (which may be unknown)
   number_value varchar(255) not null,  -- the value of the other number
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;
 
-- Each [arbitrary table (unit, identifieableitem, part, preparation)] has zero to many othernumbers.
-- Each othernumber is for one and ony one [arbitrary table].

CREATE UNIQUE INDEX idx_tablepk on othernumber(target_table, pk);

-- tables supporting transactions 

-- changeset chicoreus:043
CREATE TABLE transactionitem (
   -- Definition:  the participation of a preparation in a transaction (e.g. a loan).
   -- note: table is only minimally specified.
   transactionitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   transactionc_id bigint not null, -- transaction this item is a part of.
   trans_preparation_id bigint, -- can be null to allow for transactions of non-cataloged items
   item_count int, -- number of items involved in the transaction.
   item_count_modifier varchar(50),  -- modifier on the item count (about, more than, etc.)
   item_count_units varchar(50),  -- units of item count (truckloads, boxes, lots, specimens, etc).
   description text, -- description of the material involved in the transaction.
   item_conditions text,  -- conditions applied to this item in this transaction, e.g. no destructive sampling
   disposition varchar(50),
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- changeset chicoreus:044
CREATE TABLE transactionc (
   -- Definition: a record of the movement of a set of specimens in or out of a collection, e.g. loan, outgoing gift, deaccession, borrow.
   transactionc_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   trans_number varchar(50) not null, -- The number for the transaction
   trans_number_series varchar(50) not null, -- The number series for the transaction number 
   trans_type enum ('loan','gift','borrow','deaccession'), -- enmerated subtype tables
   started_date date, -- the date on which the process for the transaction was started
   status varchar(50) not null default 'in process', -- processing state of the transaction (loans and borrows: in process -> open -> open partial return -> closed, gifts, deaccessions in-process -> closed)
   scope_id bigint not null,  -- the institutiuonal unit within which this transaction is made and to which visibility should be limited.
   contents text,  -- text description of the content of the transaction  
   conditions text,  -- any conditions upon the transaction 
   remarks text,
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_coltra_u_numserscope on transactionc (trans_number, trans_number_series, scope_id);  

-- Each transactionitem is zero or one preparation.
-- Each preparation is zero to many transactionitems.

-- Each transactionitem is in one and only one transaction(c).
-- Each transaction(c) consists of zero to many transaction items.

ALTER TABLE transactionitem add constraint fk_transid foreign key (transactionc_id) references transactionc (transactionc_id) on update cascade;

-- changeset chicoreus:045
CREATE TABLE loan (
  -- Definition: A record of a returnable movement of a set of specimens out of a collection 
  loan_id bigint NOT NULL primary key AUTO_INCREMENT,
  transactionc_id bigint not null,
  loan_type varchar(50) not null DEFAULT 'returnable',  
  loan_date  date, -- the date on which the loan was made 
  original_due_date date DEFAULT NULL,
  current_due_date date DEFAULT NULL,
  date_received date DEFAULT NULL,  -- date recieved by recipient 
  date_closed date DEFAULT NULL,
  is_closed boolean not null DEFAULT false,
  insurance_value varchar(255) DEFAULT NULL,
  insurance_conditions text default NULL,
  overdue_notice_date date DEFAULT NULL,  -- date of most recent overdue notification 
  overdue_notfication_history text DEFAULT NULL,  -- history of overdue notifications 
  purpose_of_loan varchar(64) DEFAULT NULL, -- Recipient's description of the purpose for the loan
  received_comments varchar(255) DEFAULT NULL,
  conditions text DEFAULT null,  -- conditions for shipment, handling of material, etc imposed upon the borrower.
  source_geography text DEFAULT null,  -- Countries of origin of the material.   
  source_taxonomy text DEFAULT NULL,   -- Taxa included in the material.  
  destination_country_code varchar(3) not null,  -- The country code to which this loan is being sent.
  recipient_addressofrecord_id bigint DEFAULT NULL,  -- address to which this loan was sent 
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each transaction(c) is zero or one loan.
-- Each loan is one and only one transaction(c).

create unique index idx_loan_transid on loan (transactionc_id);  
ALTER TABLE loan add constraint fk_loantransid foreign key (transactionc_id) references transactionc (transactionc_id) on update cascade;

-- changeset chicoreus:046
CREATE TABLE gift (
  -- Definition: A record of a non-returnable movement of a set of specimens out of a collection to another insitution
  gift_id bigint not null primary key AUTO_INCREMENT,
  transactionc_id bigint not null,
  summary_description varchar(255) not null, -- brief description of the material involved in the gift.
  sent_date  date, -- the date on which the loan was made 
  destination_country_code varchar(3) not null,  -- The country code to which this gift is being sent.
  recipient_addressofrecord_id bigint DEFAULT NULL,  -- address to which this gift was sent 
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each transaction(c) is zero or one gift.
-- Each gift is one and only one transaction(c).

create unique index idx_gift_transid on gift (transactionc_id);  
ALTER TABLE gift add constraint fk_gifttransid foreign key (transactionc_id) references transactionc (transactionc_id) on update cascade;

-- changeset chicoreus:047
CREATE TABLE borrow (
  -- Definition: Loan records kept by this insititution for material borrowed from other insititutions. 
  borrow_id bigint not null primary key AUTO_INCREMENT,
  transactionc_id bigint not null,  -- transaction id for this borrow.
  borrow_type varchar(50) not null DEFAULT 'returnable',  
  borrow_date  date, -- the date on which the loan was made by the loaning institution 
  original_due_date date DEFAULT NULL, -- the original date on which the borrow was due to be returned to the loaning institution
  current_due_date date DEFAULT NULL, -- 
  source_inst_loan_number varchar(2000),  -- loan number assigned to this borrow by the source institution 
  date_received date DEFAULT NULL,  -- date borrow was recieved by this institution 
  borrow_period int not null,  -- the original period of the borrow
  borrow_period_units enum ('days','months','years') not null default 'months', 
  return_date date, -- the date on which the borrow was returned 
  purpose_of_borrow varchar(64) DEFAULT NULL, -- Recipient's description of the purpose for the borrow
  conditions text,  -- conditions for shipment, handling of material, etc imposed by the loaning institution.
  overdue_notice_date date DEFAULT NULL,  -- date of most recent overdue notification 
  overdue_notfication_history text DEFAULT NULL,  -- history of overdue notifications 
  insurance_value varchar(255) DEFAULT NULL,
  insurance_conditions text default NULL,
  is_closed boolean not null DEFAULT false,
  date_closed date DEFAULT NULL,
  origin_country_code varchar(3) not null,  -- The country code from which this borrow was sent.
  source_geography text DEFAULT null,  -- Countries of origin of the material.
  source_taxonomy text DEFAULT NULL,   -- Taxa included in the material.
  sender_addressofrecord_id bigint DEFAULT NULL,  -- address to which this borrow was expected to be returned.
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each transaction(c) is zero or one borrow.
-- Each borrow is one and only one transaction(c).

create unique index idx_borrow_transid on borrow (transactionc_id);  
ALTER TABLE borrow add constraint fk_borrowtransid foreign key (transactionc_id) references transactionc (transactionc_id) on update cascade;

-- changeset chicoreus:048
CREATE TABLE deaccession (
  -- Definition: A record of a non-returnable movement of a set of specimens out of a collection to outside of institutional care
  deaccession_id bigint not null primary key AUTO_INCREMENT,
  transactionc_id bigint not null,
  summary_description varchar(255) not null, -- brief description of the material involved in the deaccesison.
  deaccession_date  date, -- the date on which the material was deaccessioned.
  deaccession_reason text, -- reason why this material was deaccessioned
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each transaction(c) is zero or one deaccession.
-- Each deacession is one and only one transaction(c).

create unique index idx_deaccession_transid on deaccession (transactionc_id);  
ALTER TABLE deaccession add constraint fk_deaccesstransid foreign key (transactionc_id) references transactionc (transactionc_id) on update cascade;

-- changeset chicoreus:049
CREATE TABLE transactionagent (
  -- Definition: the participation of an agent in a transaction in some defined role (e.g. the agent who gave approval for some loan).
  transactionagent_id bigint NOT NULL primary key AUTO_INCREMENT,
  agent_id bigint not null,  -- the agent involved in this transaction 
  transactionc_id bigint not null, -- the transaction the agent is involved in
  role varchar(50) not null,  -- the role of the agent in the transaction
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- Each transactionagent participates in one and only one transaction(c).
-- Each transaction(c) has zero to many marticipating transactionagents.

-- Each transactionagent is one and only one agent.
-- Each agent may be zero to many transactionagents.

-- changeset chicoreus:050
create unique index idx_transagent_u_roletransagent on transactionagent(role, agent_id, transactionc_id);


-- changeset chicoreus:051
CREATE TABLE agent (
    -- Definition: a person or organization with some role related to natural science collections.
    agent_id bigint not null primary key auto_increment, -- surrogate numeric primary key
    agent_type enum ('individual','team','organization','software agent') default 'individual',  --  foaf:person,group,organization
    curated boolean not null default false, -- has this agent record been curated 
    preferred_name_string text,     -- foaf:name xml:lang=en, only name for teams, organizations, and software agents combined parts of names for individuals, name for organizations and teams.
    abbreviated_name_string varchar(50) DEFAULT NULL,  -- typically for organizations
    -- semi-atomic parts of names of individuals.
    prefix varchar(32),  -- approximates foaf:title or honorificprefix
    suffix varchar(32),
    first_name varchar(255),   -- name of the individual 
    middle_names varchar(255),  -- middle names of the individual
    family_names varchar(255),  -- matronymic and patronymic familial names 
    sameas_guid varchar(900),  --  owl:sameas  external guid for this record.
    uuid char(43),         --  rdf:about   guid for this record
    biography text,        
    notes text,  -- remarks about this agent 
    taxonomic_groups varchar(900),
    collections_at varchar(900),
    not_otherwise_specified boolean default false,
    mbox_sha1sum char(40), -- foaf:mbox_sha1sum note foaf spec, include mailto: prefix, but no trailing whitespace when computing.
    yearofbirth int,  -- Year of birth of an individual. Note that only birth and death years are recorded, not dates.   
    yearofbirthmodifier varchar(12) default '',
    yearofdeath int,  -- Year of death of an individual.
    yearofdeathmodifier varchar(12) default '',
    startyearactive int,  -- First year for a team, organization, or software agent.  For an individual, may be used for first known collection or publication.
    endyearactive int,    -- Last year for a team, organization, or software agent. 
    living enum('Yes','No','?') not null default '?',
    modified_by_agent_id bigint not null default 1
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- when a picklist applies to a field defined with an enum, specify read_only=1 for the picklist.

-- catching up on agent relations 

-- changeset chicoreus:51fksmodagent
alter table principal add constraint fk_principal_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table systemuser add constraint fk_systemuser_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table systemuserprincipal add constraint fk_systemuserprincipal_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table scope add constraint fk_scope_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table codetableint add constraint fk_codetableint_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table identification add constraint fk_ident_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table preparation add constraint fk_prep_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table part add constraint fk_part_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table identifiableitem add constraint fk_iditem_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table unit add constraint fk_unit_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table biologicalindividual add constraint fk_bioind_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table taxon add constraint fk_taxon_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table taxontreedef add constraint fk_taxontreedef_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table taxontreedefitem add constraint fk_taxontreedefitem_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table materialsample add constraint fk_materialsample_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table catalognumberseries add constraint fk_catalognumberseries_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table catnumseriescollection add constraint fk_catnumseriescollection_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table othernumber add constraint fk_othernumber_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table journal add constraint fk_journal_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table journaltitle add constraint fk_journaltitle_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table ctjournaltitletype add constraint fk_ctjourtitletype_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table journalidentifier add constraint fk_journalidentifier_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table ctjournalidentifiertype add constraint fk_ctjouridenttype_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table publicationidentifier add constraint fk_publident_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table ctpublicationtype add constraint fk_ctpublicationtype_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table transactionc add constraint fk_transactionc_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table transactionitem add constraint fk_transactionitem_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table loan add constraint fk_loan_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table gift add constraint fk_gift_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table borrow add constraint fk_borrow_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table deaccession add constraint fk_deaccession_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table transactionagent add constraint fk_transagent_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table author add constraint fk_author_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table agent add constraint fk_agent_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table picklist add constraint fk_picklist_mpicklistid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table picklistitem add constraint fk_picklistitem_mpicklistitemid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table picklistitemint add constraint fk_picklistitemint_mpicklistitemintid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table collectingevent add constraint fk_collectingevent_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table eventdate add constraint fk_eventdate_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table locality add constraint fk_locality_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;



-- changeset chicoreus:052
ALTER TABLE catalogeditem add constraint foreign key fk_catagent (cataloger_agent_id) references agent (agent_id) on update cascade;
-- changeset chicoreus:053
ALTER TABLE taxon add constraint foreign key fk_authagent (author_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_parauthagent (parauthor_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_exauthagent (exauthor_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_parexauthagent (parexauthor_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_sanctauthagent (sanctauthor_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_parsaauthagent (parsanctauthor_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_citauthagent (cited_in_agent_id) references agent (agent_id) on update cascade;

-- changeset chicoreus:054
alter table transactionagent add constraint fk_ta_agentid foreign key (agent_id) references agent(agent_id) on update cascade;
alter table transactionagent add constraint fk_ta_coltransid foreign key (transactionc_id) references agent(agent_id) on update cascade;

-- Each catalogeditem has zero or one cataloging agent.
-- Each agent cataloged zero to many catalogeditems.

-- add additional tables to support agents

-- changeset chicoreus:055
CREATE TABLE ctrelationshiptype (
   -- Definition: types of relationships between pairs of agents.
   relationship varchar(255) not null primary key,  -- The relationship read in the stored direction (e.g. child of)
   inverse varchar(50),  -- The inverse of the relationship (e.g. parent of).
   collective varchar(50),  -- The collective term for a set of participants in the relationship (e.g. children), suitable for use as a header for a list of relationhsips.
   modified_by_agent_id bigint not null default 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table ctrelationshiptype add constraint fk_ctreltype_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- Each ctrelationshiptype has zero to many internationalization in codetableint (join on relationship-key_name).
-- Each codetableint provides zero to one internationalization of ctrelationshiptype (join on relationship-key_name).

-- changeset chicoreus:056
CREATE TABLE agentteam (
   --  Definition: Composition of agents into teams of individuals, such that both the team and the members can be agents.
   agentteam_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   team_agent_id bigint not null,  -- The agent which is the team.
   member_agent_id bigint not null,  -- The agent which is a member in the team.
   ordinal int,  -- The position of the agent if the team represents an ordered list of agents.
   modified_by_agent_id bigint not null default 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table agentteam add constraint fk_agentt_tagent_id foreign key (team_agent_id) references agent(agent_id) on delete no action on update cascade;
alter table agentteam add constraint fk_agentt_membid foreign key (member_agent_id) references agent(agent_id) on delete no action on update cascade;

alter table agentteam add constraint fk_agentteam_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- Each agent is a member of zero to many agentteams.
-- Each agent is the team for zero to many agentteams.
-- Each agentteam links one and only one member agents.
-- Each agentteam links one and only one team agent.

create unique index idx_agentteam_u_teammember on agentteam(team_agent_id, member_agent_id);

-- changeset chicoreus:057
CREATE TABLE agentnumberpattern (
   -- Definition: machine and human redable descriptions of collector number patterns
   agentnumberpattern_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   agent_id bigint not null,  -- the agent to whom this number pattern applies
   number_type varchar(50) default 'collector number',  -- The type of number pattern
   number_pattern varchar(255),  --  regular expression for numbers that conform with this pattern
   number_pattern_description varchar(900),  -- human readable description of the number pattern
   startyear int, --  year for first known occurrence of this number pattern
   endyear int,   --  year for last knon occurrenc of this number pattern
   integerincrement int, -- does number have an integer increment 
   notes text,
   modified_by_agent_id bigint not null default 1
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table agentnumberpattern add constraint fk_anp_agent_id foreign key (agent_id) references agent(agent_id) on delete cascade on update cascade;

alter table agentnumberpattern add constraint fk_agentnumberpattern_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- Each agent has zero to many agentnumberpatterns.
-- Each agentnumberpattern is for one and only one agent.

-- changeset chicoreus:058
CREATE TABLE agentreference (
   --  Definition: Links to published references the content of which is about collectors/agents (e.g. obituaries, biographies).
   agentreference_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   publication_id bigint not null,  -- The publication in which the agent is mentioned.
   agent_id bigint not null,   -- The agent mentioned in the publication.
   reference_type varchar(50), -- The nature of the reference (e.g. obituary).
   modified_by_agent_id bigint not null default 1
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- changeset chicoreus:059
create index idx_refagentlks_refagent on agentreference (publication_id, agent_id);

alter table agentreference add constraint fk_agentreference_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- Each agentreference is about one and only one agent.
-- Each agent has zero to many agentreferences.

-- changeset chicoreus:060
alter table agentreference add constraint fk_aref_agent_id foreign key (agent_id) references agent (agent_id) on delete cascade on update cascade;

-- Each agentreference is in one and only one publication.
-- Each publication has zero to many agentreferences.

-- changeset chicoreus:061
alter table agentreference add constraint fk_aref_pubid_id foreign key (publication_id) references publication (publication_id) on delete cascade on update cascade;

-- changeset chicoreus:062
CREATE TABLE agentlink (
   -- Definition: supporting hyperlinks out to external sources of information about collectors/agents.
   agentlink_id bigint primary key not null auto_increment, -- surrogate numeric primary key 
   agent_id bigint not null, -- The agent for which information can be found at the link.
   type varchar(50),   -- The type of link.
   link varchar(900),  -- An IRI to some source of information aobut and agent.
   isprimarytopicof boolean not null default true,  --  link can be represented as foaf:primarytopicof
   text varchar(50),  -- The text to display for the link.
   modified_by_agent_id bigint not null default 1,
   foreign key (modified_by_agent_id) references agent(agent_id) on update cascade
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each agent has zero to many agentlinks.
-- Each agentlink is for one and only one agent.

alter table agentlink add constraint fk_alink_agentid_id foreign key (agent_id) references agent (agent_id) on update cascade;

-- changeset chicoreus:063
CREATE TABLE agentname (
   --  Definition:  multiple variant forms of names and names for a collector/agent
   agentname_id bigint primary key not null auto_increment, -- surrogate numeric primary key 
   agent_id bigint not null,  -- The agent for which this is a name of.
   type varchar(35) not null default 'full name',  -- The type of agent name. 
   name  varchar(255),  -- The name of the agent.
   language varchar(6) default 'en_us',  -- The language for this name.
   modified_by_agent_id bigint not null default 1,
   foreign key (type) references ctnametypes(type) on delete no action on update cascade,
   foreign key (agent_id)  references agent(agent_id)  on delete cascade  on update cascade,
   foreign key (modified_by_agent_id) references agent(agent_id) on update cascade
)
ENGINE=myisam -- to ensure support for fulltext index
DEFAULT CHARSET=utf8;  

create unique index idx_agentname_u_idtypename on agentname(agent_id,type,name); --  combination of recordedbyid, name, and type must be unique.

-- Can't create this foreign key relation, as agentname uses the myisam index for access to full text indexing.
-- alter table author add constraint fk_authoragentname foreign key (agentname_id) references agentname (agentname_id) on update cascade;

alter table agentname add constraint fk_aname_agentid_id foreign key (agent_id) references agent (agent_id) on update cascade;

-- Each agent has zero to many agentnames.
-- Each agentname is for one and only one agent.

-- Each agentname has one and only one name type (ctnametypes.type).
-- Each ctnametype is the type for zero to many agentnames.

-- Each author has one and only one agentname.
-- Each agentname is the name for zero to many authors.

-- changeset chicoreus:064
create fulltext index ft_collectorname on agentname(name);

-- changeset chicoreus:065
CREATE TABLE ctagentnametype (
   -- Definition: controled vocabulary for agent name types.
   type varchar(35) not null,  -- The type of agent name (e.g. full name).
   ordinal int  -- An order which can be used to present this name type in a picklist or by which a name can be selected.
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table agentname add constraint fk_aname_type foreign key (type) references ctagentnametype (type) on update cascade;

-- changeset chicoreus:066
CREATE TABLE agentrelation (
   -- Definition: A relationship between one agent and another, serves to represent relationships (family,marrage,mentorship) amongst agents.
   agentrelation_id bigint not null primary key auto_increment, -- surrogate numeric primary key 
   from_agent_id bigint not null,  --  parent agent in this relationship 
   to_agent_id bigint not null,    --  child agent in this relationship 
   relationship varchar(50) not null,  -- nature of relationship from ctrelationshiptype 
   notes varchar(900),  -- Remarks concerning the relationship.
   modified_by_agent_id bigint not null default 1,
   foreign key (from_agent_id) references agent(agent_id) on delete cascade on update cascade,
   foreign key (to_agent_id) references agent(agent_id) on delete cascade on update cascade,
   foreign key (relationship) references ctrelationshiptype(relationship) on delete no action on update cascade,
   foreign key (modified_by_agent_id) references agent(agent_id) on update cascade
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- changeset chicoreus:067
CREATE TABLE agentgeography (
  -- Definition:  relationships of agents with geographies (as collector, author, etc).
  agentgeography_id bigint NOT NULL primary key AUTO_INCREMENT,
  role varchar(64) DEFAULT NULL,  -- the role of the agent with respect to the geography (e.g. author on, collector in).
  agent_id bigint NOT NULL,  -- the agent with a relattion to geography
  geography_id bigint NOT NULL,  -- the geography the agent has a relationship to.
  remarks text,
  modified_by_agent_id bigint not null default 1,
  foreign key (modified_by_agent_id) references agent(agent_id) on update cascade
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table agentgeography add constraint fk_agentgeog_agentid foreign key (agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:068
CREATE TABLE agentspeciality (
  -- Definition: Knowledge of particular agents in particular taxa.
  agentspeciality_id bigint NOT NULL primary key AUTO_INCREMENT,
  agent_id bigint not null, -- the agent with this speciality
  ordinal int(11) NOT NULL, -- ordering of specialities
  skill_level varchar(50) DEFAULT NULL, -- skill level of agent in speciality (e.g. global expert, regional expert, etc.).
  taxon_id bigint not null, -- the taxon that the agent has a speciality in.
  remarks text,
  modified_by_agent_id bigint not null default 1,
  foreign key (modified_by_agent_id) references agent(agent_id) on update cascade
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table agentspeciality add constraint fk_agentspeci_agentid foreign key (agent_id) references agent(agent_id) on update cascade;
alter table agentspeciality add constraint fk_agentspeci_taxonid foreign key (taxon_id) references taxon(taxon_id) on update cascade;

-- changeset chicoreus:069
CREATE TABLE cttextattributetype (
    -- Definition: types of text attributes
    key_name varchar(255) not null primary key,  -- the name of the attribute type
    scope varchar(900),  -- list of tables to which this attribute type applies
    modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table cttextattributetype add constraint fk_cttextatt_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:070
CREATE TABLE textattribute (
    -- Definition: a generic typed text attribute that can be added to any table.
    textattribute_id bigint not null primary key auto_increment, -- surrogate numeric primary key
    key_name varchar(255) not null,   -- the type of attribute
    value varchar(900) not null,  -- the value of the attribute
    for_table varchar(255) not null,  -- table to which this attribute is applied 
    primary_key_value bigint not null,  -- row in for_table to which this attribute is applied
    modified_by_agent_id bigint not null default 1
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE textattribute add constraint fk_textattributetype foreign key (key_name) references cttextattributetype (key_name) on update cascade; 

alter table textattribute add constraint fk_textattribute_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- Each cttextattribute type is the key for zero to many textattributes.
-- Each textattribute has one and only one cttextattributetype as a key.

-- Each textattribute applies to one and only one row in a table (keyed on for_table and primary_key_value).
-- Each row in a table has zero to many textattributes (keyed on for_table and primary_key_value).

-- changeset chicoreus:071
CREATE TABLE inference (
    -- Definition:  metadata description of the basis of an inference made in interpreting a value in any field in any table
    inference_id bigint not null primary key auto_increment, -- surrogate numeric primary key
    inference text not null,  -- the interpreter's description of the inference tha was made
    by_agent_id bigint not null, -- who (most recently) made the inference
    ondate timestamp not null default CURRENT_TIMESTAMP, -- date of most recent change to this inference, inferences added in this system, so can use date instead of eventdate.
    for_table varchar(255) not null,  -- table to which this interpretation was applied
    for_field varchar(255) not null,  -- field in the table to which this intepretation was applied
    primary_key_value bigint not null,  -- row in for_table to which this interpretation was applied
    modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;
alter table inference add constraint fk_inference_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

CREATE UNIQUE INDEX idx_infer_u_ftablefieldpkv ON inference(for_table,for_field,primary_key_value); -- allow zero or one inferences for one field in one table.

-- Each inference applies to one and only one tuple (keyed on for_table, for_field, and primary_key_value)
-- Each tuple has zero or one inference (keyed on for_table, for_field, and primary_key_value)

-- changeset chicoreus:072
CREATE TABLE ctnumericattributetype (
    -- Definition: types of numeric attributes
    name varchar(255) not null primary key,  -- the name of the attribute type
    scope varchar(900),  -- list of tables to which this attribute type applies
    modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table ctnumericattributetype add constraint fk_numatt_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:073
CREATE TABLE numericattribute (
    -- Definition: a generic typed numeric attribute that can be added to any table.
    numericattribute_id bigint not null primary key auto_increment, -- surrogate numeric primary key
    name varchar(255) not null,   -- the type of attribute
    value float(20,10) not null,  -- the value of the attribute
    units varchar(255),           -- units, if any to be ascribed to the attribute
    for_table varchar(255) not null,
    primary_key_value bigint not null,
    modified_by_agent_id bigint not null default 1
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each numericattribute is of one and only one numericattrubutetype (ctnumericattributetype).
-- Each ctnumericattributetype is the type of zero to many numeric attribtues.

ALTER TABLE numericattribute add constraint fk_numericattributetype foreign key (name) references ctnumericattributetype (name) on update cascade; 

alter table numericattribute add constraint fk_numericattribute_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- definitions for pick lists associated with biological attributes and generic attributes.  Table picklist's table/field binding can't be used for these.

-- changeset chicoreus:074
CREATE TABLE ctbiologicalattributetype (
    -- Definition: types of biological attributes 
    name varchar(255) not null primary key,   -- the name of the attribute type 
    valuecodetable varchar(60),  -- code table to use to restrict allowed values 
    unitscodetable varchar(60),   -- code table to use to restrict allowed units 
    methodcodetable varchar(60),   -- code table to use to restrict allowed determination methods
    modified_by_agent_id bigint not null default 1
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- changeset chicoreus:074aFKModByAgent
alter table ctbiologicalattributetype add constraint fk_ctbiolatttype_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:075
CREATE TABLE ctlengthunit (
   -- Definition: controled vocabulary for units of length.
   lengthunit varchar(255) not null primary key,
   modified_by_agent_id bigint not null default 1
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each ctbiologicalattributetype has zero or one length unit in ctlengthunit.
-- Each ctlengthunit is the length unit for zero to many ctbiologicalattributetypes.

-- changeset chicoreus:075aFKModByAgent
alter table ctlengthunit add constraint fk_ctblengthunit_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- changeset chicoreus:076
CREATE TABLE ctmassunit (
   -- Definition: controled vocabulary for units of mass.
   massunit varchar(255) not null primary key,
   modified_by_agent_id bigint not null default 1
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each ctbiologicalattributetype has zero or one mass unit in ctmassunit.
-- Each ctmassunit is the mass unit for zero to many ctbiologicalattributetypes.

-- changeset chicoreus:076aFKModByAgent
alter table ctmassunit add constraint fk_ctmassunit_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:077
CREATE TABLE ctageclass (
  -- Definition: controled vocabulary for age classes.
  ctageclass_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  ageclass varchar(255) not null,
  modified_by_agent_id bigint not null default 1
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table ctageclass add constraint fk_ctageclass_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- Each ctbiologicalattributetype is an age class in ctageclass.
-- Each ctageclass is the age class for for zero to many ctbiologicalattributetypes.

-- changeset chicoreus:078
CREATE TABLE scopect (
    -- Definition: relationship between a key in a code table and a scope, the scope within which a code table applies.
    scopect_id bigint not null primary key auto_increment, -- surrogate numeric primary key
    key_name varchar(255) not null,  -- key which has the scope 
    ct_table_name varchar(255) not null,  -- table in which key is found
    scope_id bigint not null,  -- scope for the key 
    biolattrib_relation_limit enum('part','identifiableitem') default null, -- if ct_table_name is biologicalattribue, limitation on which relation (to part or to identifiable item) this key can be applied to in this scope (e.g. in a lot based collection, scope for sex might be limited to part, in a specimen based collection, it might be limited to identifiable item), if null, no limitation.
    modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table scopect add constraint fk_scopect_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- Each {code table} has zero to many scopes in scopect.
-- Each scopect provides the scope for zero to many {code table}.

create unique index idx_scopect_u_keytable on scopect (key_name, ct_table_name, scope_id);

-- changeset chicoreus:079
alter table scopect add constraint fk_scopect_scopeid foreign key (scope_id) references scope (scope_id) on update cascade;
-- Each scopect has one and only one scope
-- Each scope applies to zero to many scope_id
-- Each scopect is for one and only one key name in a code table
-- Each key name in a code table has zero to many scope-codetable relations in codect

-- changeset chicoreus:080
CREATE TABLE biologicalattribute (
    -- Definition: a generic typed attribute for biological characteristics of organisms, 
    --  including metadata about who determined the attribute value when.
    biologicalattribute_id bigint not null primary key auto_increment, -- surrogate numeric primary key
    name varchar(255) not null,  -- restricted by ctbiologicalattributetype
    value varchar(900) not null, -- value for attribute, may be restricted by value code table specified in ctbiologicalattributetype
    units varchar(255) not null default '', -- units for attribute, may be restricted by unit code table specified in ctbiologicalattributetype
    determinationmethod varchar(255) not null default '',
    remarks text,
    determiningagent_id bigint,
    datedetermined varchar(50),    --  iso date for date/date ranged determined, may be just year, may be unknown
    identifiableitem_id bigint,  -- the identifiableitem to which this biological attribute applies (typical for specimen based collections)
    part_id bigint,  -- the part to which this biological attribute applies (typical for lot based collections)
    modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;
alter table biologicalattribute add constraint fk_biologicalattribute_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:081
ALTER TABLE biologicalattribute add constraint fk_biologicalattributetype foreign key (name) references ctbiologicalattributetype (name) on update cascade; 
-- Each biologicalattribute is of one and only one biologicalattrubutetype (ctbiologicalattributetype).
-- Each ctbiologicalattributetype is the type of zero to many biological attribtues.

ALTER TABLE biologicalattribute add constraint fk_biolattidentitem foreign key (identifiableitem_id) references identifiableitem (identifiableitem_id) on update cascade; 
ALTER TABLE biologicalattribute add constraint fk_biolattpart foreign key (part_id) references part (part_id) on update cascade; 
-- Each biologicalattribute applies to zero or one identifiable item.
-- Each identifiable item has zero to many biological attribtues.
-- Each biologicalattribute applies to zero or one part.
-- Each part has zero to many biological attribtues.

-- Minimal audit log of who applied changes to what tables when, does not record the query that was fired.
-- Significant change from Specify, replaces the createdByAgentId/modifiedByAgentId timestampCreated/timestampLastModified fields in each table.
-- For more detailed audit logs, use a mechanism intrinsic to the database or a plugin.

-- changeset chicoreus:082
CREATE TABLE auditlog ( 
    -- Definition: timestamps and users who have inserted, deleted, or updated data in each table.  Maintained with triggers on each table.
    auditlog_id bigint not null primary key auto_increment, -- surrogate numeric primary key
    action varchar(50),  -- action carried out, insert, delete, update 
    timestamptouched datetime not null,  -- timestamp of the modification, datetime rather than timestamp to support import of data from previous systems.
    -- TODO: add a dbusername, switch existing triggers to use that, add modifiedbyagentid to each table to obtain agent_id in trigger.
    dbusername varchar(255),   -- username of current logged in database user  TODO: Make not null 
    username varchar(255) not null,   -- username of current logged in user, retained even if agent record is edited
    agent_id bigint default null,      -- agent_id of the user who made the change
    for_table varchar(255) not null,   -- table in which primary_key_value is found
    primary_key_value bigint not null  
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each {table} has zero to many auditlogs.
-- Each audit log is for one and only one {table}.

-- changeset chicoreus:083
ALTER TABLE auditlog add constraint fk_auditlogagent_id foreign key (agent_id) references agent (agent_id) on update cascade;

-- changeset chicoreus:auditlogvarchar
CREATE TABLE auditlogvarchar ( 
    -- Definition: timestamps and users who have inserted, deleted, or updated data in each table where the primary key is a varchar (typically controled vocabulary tables).  Maintained with triggers on each applicable table.
    auditlog_id bigint not null primary key auto_increment, -- surrogate numeric primary key
    action varchar(50),  -- action carried out, insert, delete, update 
    timestamptouched datetime not null,  -- timestamp of the modification, datetime rather than timestamp to support import of data from previous systems.
    dbusername varchar(255) not null,   -- username of current logged in database user
    username varchar(255) default null,   -- username of current logged in user, retained even if agent record is edited
    agent_id bigint default null,      -- agent_id of the user who made the change
    for_table varchar(255) not null,   -- table in which primary_key_value is found
    primary_key_value varchar(255) not null  
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each {table (with varchar pk)} has zero to many auditlogsvarchar.
-- Each audit log is for one and only one {table}.

-- changeset chicoreus:auditlogvarcharfk
ALTER TABLE auditlogvarchar add constraint fk_auditlogvcagent_id foreign key (agent_id) references agent (agent_id) on update cascade;

-- Each auditlogvarchar records an action by one and noly one agent.
-- Each agent made a change recorded in zero to many auditlogvarchars.


-- Encumberances: means for masking visiblity of data, generalized from mechainism in Arctos.

-- changeset chicoreus:084
CREATE TABLE ctencumberancetype ( 
   -- Definition: controled vocabulary of encumberance types.
   encumberance_type varchar(50) not null primary key
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- changeset chicoreus:085
CREATE TABLE encumberance (
   --  Definition: a description of the limitations on the visiblity of some data to the public.  All public presentations of data must observe the encumberance associated with that data.  
   encumberance_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   explanation text,   -- the reason for the encumberance 
   encumberance_type varchar(50) not null,   
   createdby_agent_id bigint not null,
   make_visible_on date, -- date on which encumberance expires, null for no expiration date
   make_visible_criteria text, -- description of criteria under which encumberance expires 
   visible_to_scope_id bigint, -- scope to which the encumbered data should be visible
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each encumberance is of one and only one encumberancetype (ctencumberancetype).
-- Each ctencumberancetype is the type of zero to many encumberances.

-- Each encumberance was created by one and only one agent.
-- Each agent is the creator of zero to many encumberances.

-- Each encumberance is visible to one and only one scope.
-- Each scope provides the visiblility for zero to many encumberances.

ALTER TABLE encumberance add constraint fk_enctype foreign key (encumberance_type) references ctencumberancetype (encumberance_type) on update cascade;
-- changeset chicoreus:086
ALTER TABLE encumberance add constraint fk_encagent foreign key (createdby_agent_id) references agent (agent_id) on update cascade;
-- changeset chicoreus:087
ALTER TABLE encumberance add constraint fk_encvisiblescope foreign key (visible_to_scope_id) references scope (scope_id) on update cascade;

-- changeset chicoreus:088
CREATE TABLE catitemencumberance ( 
   -- Definition: relationship between encumberances and cataloged items
   catitemencumberance_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   encumberance_id bigint not null,
   catalogeditemid bigint not null,
   tablescope varchar(900) default 'catalogeditem,unit,identifiableitem,preparation,identification',  -- tables this encumberance is expected to extend to.
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each encumberance is zero to many catitemencumberances.
-- Each catitemencumberance is one and only one encumberance.
-- Each catitemencumberance is for one and only one catalogeditem.

-- changeset chicoreus:089
CREATE TABLE attachmentencumberance ( 
   -- Definition: relationship between encumberances and attachment (metadata records), encumberance of actual media objects needs to be handleed by a digital asset management system.
   attachmentencumberance_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   encumberance_id bigint not null,
   attachment_id bigint not null,
   tablescope varchar(900) default 'attachment',  -- tables this encumberance is expected to extend to.
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each encumberance is zero to many attachmentencumberances.
-- Each attachmentencumberance is one and only one encumberance.
-- Each attachmentencumberance is for one and only one attachment.

-- changeset chicoreus:090
CREATE TABLE localityencumberance ( 
   -- Definition: relationship between encumberances and localities (e.g. for fossil localities where not publicizing the locality was a condition of collecting at that locality).   
   localityencumberance_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   encumberance_id bigint not null,
   locality_id bigint not null,
   tablescope varchar(900) default 'locality,coordinate,georeference,collectingevent,catalogeditem,unit,identifiableitem,preparation,identification',  -- tables this encumberance is expected to extend to.
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each encumberance is zero to many localityencumberances.
-- Each localityencumberance is one and only one encumberance.
-- Each localityencumberance is for one and only one locality.

-- changeset chicoreus:091
CREATE TABLE taxonencumberance ( 
   -- Definition: relationship between encumberances and taxa (e.g. for soon-to-be-described species, or for taxa which are controled substances).   
   taxonencumberance_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   encumberance_id bigint not null, -- The encumberance that applies to a taxon
   taxon_id bigint not null, -- The taxon to which an encumberance applies 
   tablescope varchar(900) default 'catalogeditem,unit,identifiableitem,preparation,identification',  -- tables this encumberance is expected to extend to.
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each encumberance is zero to many taxonencumberances.
-- Each taxonencumberance is one and only one encumberance.
-- Each taxonencumberance is for one and only one taxon.

-- changeset chicoreus:091encumbmodbyagent
alter table encumberance add constraint fk_encumberance_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table catitemencumberance add constraint fk_catitemencumberance_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table attachmentencumberance add constraint fk_attachmentencumberance_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table localityencumberance add constraint fk_localityencumberance_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table taxonencumberance add constraint fk_taxonencumberance_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:092
CREATE TABLE address (
  -- Definition: an address for an agent
  address_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  address_for_agent_id bigint not null,  -- agent for which this is an address
  address_line_1 varchar(255) not null,
  address_line_2 varchar(255) default null,
  address_line_3 varchar(255) default null,
  address_line_4 varchar(255) default null,
  address_line_5 varchar(255) default null,
  city varchar(255) default null,
  postalcode varchar(32) default null,
  state_province varchar(255) default null,
  country varchar(255) default null,
  is_current boolean default null,  -- true if this is a current address 
  is_primary boolean default null,  -- true if this is the primary address for this agent
  is_shipping boolean default null, -- true if this is an address to which shipments can be sent
  ordinal int(11) default null,   -- sort order for addresses 
  start_eventdate_id bigint default null,  -- date on which this address began to be used
  end_eventdate_id bigint default null,  -- date on which this address ceased to be used
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_address_u_startdateid on address(start_eventdate_id);  --  Event dates should not be reused.
create unique index idx_address_u_enddateid on address(end_eventdate_id);  --  Event dates should not be reused.

alter table address add constraint fk_address_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- changeset chicoreus:093
CREATE INDEX idx_address_addagent_id on address(address_for_agent_id);

ALTER TABLE address add constraint fk_addressforagent foreign key (address_for_agent_id) references agent (agent_id) on update cascade; 
-- changeset chicoreus:094
ALTER TABLE address add constraint fk_add_startevdate foreign key (start_eventdate_id) references eventdate (eventdate_id) on update cascade; 
ALTER TABLE address add constraint fk_add_endevdate foreign key (end_eventdate_id) references eventdate (eventdate_id) on update cascade; 

-- Each address is for one and only one agent.
-- Each agent has zero to many addresses.

-- Each address starts use at zero or one eventdate.
-- Each eventdate is the start for one and only one address.

-- Each address ends use at zero or one eventdate.
-- Each eventdate is the end for one and only one address.

-- changeset chicoreus:095
CREATE TABLE ctelectronicaddresstype ( 
   -- controled vocabulary for allowed types of electronic addresses
   typename varchar(255) not null primary key 
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- changeset chicoreus:096
CREATE TABLE electronicaddress ( 
   -- Definition: email, phone, fax, or other electronic contact address for an agent
   electronicaddress_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   address_for_agent_id bigint not null,  -- agent for which this is an address
   typename varchar(255) not null,
   address varchar(255) not null,
   remarks text,
   is_current boolean default null,  -- true if this is a current contact number/email (no constraint preventing multiple current addresses).
   is_primary boolean default null,  -- true if this is the primary contact number/email for this agent 
   ordinal int(11) default null,   -- sort order for electronic addresses
   modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table electronicaddress add constraint fk_electronicaddress_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
ALTER TABLE electronicaddress add constraint fk_ea_nametype foreign key (typename) references ctelectronicaddresstype (typename) on update cascade;
-- changeset chicoreus:097
ALTER TABLE electronicaddress add constraint fk_eaddressforagent foreign key (address_for_agent_id) references agent (agent_id) on update cascade; 

create unique index idx_eaddress_u_agentprimary on electronicaddress(address_for_agent_id, is_primary);  --  Only one primary electronic address for an agent.

-- Each electronicaddress is of one and only one (ct)electronicaddresstype.
-- Each ctelectronicaddresstype provides the type for zero to many electronic addresses.

-- Each electronicaddress is for one and only one agent.
-- Each agent has zero to many electronicaddresses.

-- changeset chicoreus:098
CREATE TABLE addressofrecord (
  -- Definition: an address to which something was sent, which must be preserved even as an agent changes their current address.
  addressofrecord_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  address_for_agent_id bigint default null,  -- agent for which this is an address of record for some shipment.
  adressee_agent_name varchar(244) not null,   -- name of agent at time address became address of record.
  address_line_1 varchar(255) not null,
  address_line_2 varchar(255) default null,
  address_line_3 varchar(255) default null,
  address_line_4 varchar(255) default null,
  address_line_5 varchar(255) default null,
  city varchar(255) default null,
  postalcode varchar(32) default null,  -- postal code, zip code etc.
  state_province varchar(255) default null,  -- primary division for address
  country varchar(255) default null, 
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- changeset chicoreus:099
alter table addressofrecord add constraint fk_addressofrecord_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
ALTER TABLE addressofrecord add constraint fk_aor_addressforagent foreign key (address_for_agent_id) references agent (agent_id) on update cascade ; 

-- Each addressofrecord is a preserved address for one and only one agent.
-- Each agent has zero to many preserved addressesofrecord.

-- changeset chicoreus:100
ALTER TABLE loan add constraint fk_loan_loanaddress foreign key (recipient_addressofrecord_id) references addressofrecord (addressofrecord_id) on update cascade; 
ALTER TABLE gift add constraint fk_gift_giftaddress foreign key (recipient_addressofrecord_id) references addressofrecord (addressofrecord_id) on update cascade; 
ALTER TABLE borrow add constraint fk_borrow_senderaddress foreign key (sender_addressofrecord_id) references addressofrecord (addressofrecord_id) on update cascade; 

-- Each loan has zero or one recipient addressofrecord.
-- Each addressofrecord is the recipient address for zero to many loans.
-- Each gift has zero or one recipient addressofrecord.
-- Each addressofrecord is the recipient address for zero to many gifts.
-- Each borrow has zero or one sender addressofrecord.
-- Each addressofrecord is the sender address for zero to many borrows.

-- accession and closely related tables

-- changeset chicoreus:101
CREATE TABLE accession (
  -- Definition: a record of the acceptance of a set of collection objects into the care of an institution.
  --  forms a record of the legal ownership of the material, unless the material is being held for another organization
  --  under a repository agreement, where legal ownership is retained by the other organization, but the accepting institution
  --  agrees to be a repository for the material.
  accession_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  accessionnumber varchar(255) not null,
  date_accessioned_eventdate_id bigint default null, -- date of this accession
  date_acknowledged_eventdate_id bigint default null,  -- date on which this accession was acknowledged
  date_received_eventdate_id bigint default null, -- date on which this accessioned material was received
  accession_condition varchar(255) default null,  -- conditions or restrictions applied to this accession
  remarks text,
  status varchar(32) default null,
  accessiontype varchar(32) default null,
  verbatim_accession_info varchar(50) default null, -- verbatim information on which this accession is based (for legacy accessions created from other forms of records).
  addressofrecord_id bigint default null,  -- address from which this accession was recieved 
  repositoryagreement_id bigint default null,  -- repository agreement which governs this accession
  scope_id bigint not null,  -- the scope within which this accession record is visible
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table accession add constraint fk_accession_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:102
create unique index idx_access_u_dateackid on accession(date_acknowledged_eventdate_id);  --  Event dates should not be reused.
create unique index idx_access_u_dateaccid on accession(date_accessioned_eventdate_id);  --  Event dates should not be reused.
create unique index idx_access_u_daterecid on accession(date_received_eventdate_id);  --  Event dates should not be reused.

-- Each accession was received on zero or one eventdate.
-- Each accession was accessioned on zero or one eventdate.
-- Each accession was acknowleged on zero or one eventdate.
-- Each eventdate is the received date for zero or one accession.
-- Each eventdate is the accession date for zero or one accession.
-- Each eventdate is the acknowleged date for zero or one accession.

-- Each accession is visible within one and only one scope.
-- Each scope provides visibility for zero to many accessions.

-- changeset chicoreus:103
alter table accession add constraint fk_acc_scope_id foreign key (scope_id) references scope (scope_id) on update cascade on delete NO ACTION;

-- changeset chicoreus:104
CREATE TABLE repositoryagreement (
  -- Definition: an agreement under which one institution agrees to be the repository for material that is owned by another organization.
  repositoryagreement_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  datereceived date default null,  -- date at which the repository agreement document was received.
  enddate date default null,  -- date at which this repository agreement ends.
  remarks text,
  repositoryagreementnumber varchar(60) not null,  
  startdate date default null,  -- date at which this reposoitory agreement becomes effective 
  status varchar(32) default null,
  agreementwithagent_id bigint not null,   -- agent with whom this repository agreement has been made with
  scope_id bigint not null,  -- the scope within which this repository agreement record is visible
  addressofrecord_id bigint default null,  -- address of record for the agent with whom this repository agreement is with at the time of the agreement.
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table repositoryagreement add constraint fk_repositoryagreement_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- Each accession is under zero to one repositoryagreement.
-- Each repositoryagreement applies to zero to many accessions.

-- Each accession has zero to one source addressofrecord.
-- Each addressofrecord is the source for zero or one accession.

-- changeset chicoreus:105
ALTER TABLE accession add constraint fk_acc_repositoryagreement foreign key (repositoryagreement_id) references repositoryagreement (repositoryagreement_id) on update cascade; 
-- changeset chicoreus:106
ALTER TABLE accession add constraint fk_acc_addresofrecrod foreign key (addressofrecord_id) references addressofrecord (addressofrecord_id) on update cascade; 

-- changeset chicoreus:107
alter table repositoryagreement add constraint fk_ra_scope_id foreign key (scope_id) references scope (scope_id) on update cascade on delete NO ACTION;
-- changeset chicoreus:108
ALTER TABLE repositoryagreement add constraint fk_ra_agreementwith foreign key (agreementwithagent_id) references agent (agent_id) on update cascade;
-- changeset chicoreus:109
ALTER TABLE repositoryagreement add constraint fk_ra_addressofrecord foreign key (addressofrecord_id) references addressofrecord (addressofrecord_id) on update cascade;

-- Each repositoryagreeement is visible within one and only one scope.
-- Each scope provides visibility for zero to many repositoryagreements.

-- Each repositoryagreement is an agreement with one and only one agent.
-- Each agent has zero to many repositoryagreements.

-- Each repositoryagreement has zero to one addressofrecord.
-- Each addressofrecord is for for zero or one repositoryagreeement.

-- changeset chicoreus:110
CREATE TABLE accessionagent (
  -- Definition: The participation of an agent in an accession in some defined role (e.g. the agent who approved some accession).
  accessionagent_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  role varchar(50) not null,
  accession_id bigint not null,
  agent_id bigint not null,
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE accessionagent add constraint fk_accessionagent foreign key (agent_id) references agent (agent_id) on update cascade; 
ALTER TABLE accessionagent add constraint fk_accessionforagent foreign key (accession_id) references accession (accession_id) on update cascade on delete cascade; 

alter table accessionagent add constraint fk_accessionagent_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
--  an agent cannot have the same role twice in the same accession.
CREATE UNIQUE INDEX idx_accessionagent_agroacc on accessionagent(agent_id, role, accession_id); 

-- Each accession has zero to many accessionagents.  (Each accession has zero or one accessionagent with a particular agent in a particular role).
-- Each accessionagent is for one and only one accession.
-- Each accessionagent is one and only one agent.
-- Each agent is zero to many accessionagents.

-- attachments

-- changeset chicoreus:111
CREATE TABLE attachment (
  -- Definition: Metadata concerning a media object that can be attached to a data object
  attachment_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  title varchar(255) default null,  
  iri varchar(2000) default null,  -- iri from which the attachment can be retrieved (e.g. from a digital asset management system).
  copyrightdate varchar(64) default null,
  copyrightholder varchar(64) default null,
  license varchar(64) default null,
  credit varchar(64) default null,
  dateimaged varchar(64) default null,
  filecreateddate date default null,
  guid varchar(128) default null,
  is_public boolean not null,
  mimetype varchar(64) default null,
  origfilename text not null,
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table attachment add constraint fk_attachment_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- changeset chicoreus:112
CREATE TABLE attachmentrelation (
  -- Definition: relationship between any row in any table and an attached media object.  Means of associating media objects with data records.
  attachmentrelation_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  attachment_id bigint not null,
  for_table varchar(255) not null,
  primary_key_value bigint not null,
  ordinal int(11) not null,
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table attachmentrelation add constraint fk_attachmentrelation_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table attachmentrelation add constraint fk_attrel_attid foreign key (attachment_id) references attachment (attachment_id) on update cascade;

-- Each attachmentrelation involves one and only one attachment.
-- Each attachment is involved in zero to many attachmentrelations.

-- Each attachmentrelation involves one and only one {arbitrary table}.
-- Each {aribtrary table} has zero to many attachmentrelations.

-- changeset chicoreus:113
CREATE TABLE collector (
  -- Definition: The relation of an agent, possibly with additional un-named agents, to a collecting event (supports a workflow where collectors are transcribed verbatim and then subsequently parsed into known agent teams.
  collector_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  verbatim_collector text,  -- the verbatim transcribed text for the collector 
  agent_id bigint,  -- the agent (individual or group) that has been identified as the collector.
  primary_collector_agent_id bigint,  -- the agent (individual) that has been identified as the primary collector (who's number series is used in the collecting event).
  etal text, -- unnamed individuals and groups that were part of the collecting team.  examples: and students; and native guide.
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table collector add constraint fk_collector_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
-- changeset chicoreus:114
ALTER TABLE collector add constraint fk_col_collectoragent foreign key (agent_id) references agent (agent_id) on update cascade;
-- changeset chicoreus:115
ALTER TABLE collector add constraint fk_col_pricollectoragent foreign key (primary_collector_agent_id) references agent (agent_id) on update cascade;
-- changeset chicoreus:116
ALTER TABLE collectingevent add constraint fk_colevent_col foreign key (collector_id) references collector (collector_id) on update cascade;

-- Each collector is zero to one agent.
-- Each agent is one to many collectors.

-- Each collector collected in zero to many collectingevents.
-- Each collectingevent had one and only one collector (handle teams by verbatim collector and etal, then parse into collectoragent as a group with etal).

-- tables supporting coordinates and georeferences

-- changeset chicoreus:117
CREATE TABLE ctcoordinatetype ( 
   -- Definition: Controled vocabulary of vocabulary types.
   coordinatetype varchar(50) not null primary key,  -- allowed coordinate types for table coordinate
   fieldprefix varchar(5) not null  -- prefix for field names that apply for this coordinate type
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each coordinate is of one and only one (ct)coordinatetype.
-- Each (ct)coordintetype is the type for zero to many coordinates.

-- changeset chicoreus:118
CREATE TABLE coordinate ( 
   -- Definition: a two dimensional point description of a location in one of several standard forms, allows splitting a verbatim coordinate into atomic parts, intended for retaining information about original coordinates, separate from subsequent georeferences.
   coordinate_id bigint not null primary key auto_increment, -- surrogate numeric primary key  
   geodeticdatum varchar(255) not null default 'not recorded',   -- geodetic datum that applies for this coordinate
   remarkslatlongmeridian varchar(50) default null, -- meridian (grenwich, paris) for latitude and longitude, could apply to any lat/long representation
   remarks text default null, -- any additional information needed to interpret the coordinate
   cordinatesource varchar(255) default null, -- source for this coordinate (e.g. field notes, gps, field map)
   locality_id bigint not null,  -- the locality that this coordinate describes 
   coordinatetype varchar(50) not null default 'decimal degrees',  -- which standard form of a coordinate is this, determines which fields apply 
   utmzone varchar(3) default null,  -- utm/ups zone number and optinal letter,
   utmeasting int default null,  -- utm easting in meters
   utmnorthing int default null, -- utm northing in meters 
   gridzone varchar(6) default null, -- zone or zone and squrare identifier for other (osgb, nzmg, mgrs, usng etc) grid systems that use a zone/square identifier and variable numbers of digits to represent an area of arbitrary size.
   grideasting varchar(12) default null, -- zone easting for other grid systems, varchar to preserve number of digits and leading zeros
   gridnorthing varchar(12) default null, -- zone northing for other grid systems, varchar to preserve number of digits and leading zeros
   xygridx varchar(12) default null, -- x direction for x=, y= grids such as the swedish and swiss grids
   xygridy varchar(12) default null, -- y direction for x=, y= grids such as the swedish and swiss grids
   ddglatitude decimal(12,10) default null,  -- decimal degrees, latitude
   ddglongitude decimal(12,10) default null,  
   ddglatdirection enum ('n','s') default null, 
   ddglongdirection enum ('e','w') default null,
   dmslatdeg int default null,  -- degrees minutes seconds, latitude degrees
   dmslatmin int default null,
   dmslatsec decimal(8,6) default null,
   dmslongdeg int default null,
   dmslongmin int default null,
   dmslongsec decimal(8,6) default null,
   dmslatdirection enum ('n','s') default null, 
   dmslongdirection enum ('e','w') default null,
   ddmlatdeg int default null,  -- degrees decimal minutes, latitude degrees
   ddmlongdeg int default null,
   ddmlatdecimalminutes decimal(10,8) default null,
   ddmlongdecimalminutes decimal(10,8) default null,
   ddmlatdirection enum ('n','s') default null, 
   ddmlongdirection enum ('e','w') default null,
   plsstownship int default null,  -- public land survey system (us and canada) township line number
   plsstownshipdirection varchar(1) default null, -- plss township offset direction 
   plssrange int default null, -- plss range line number
   plssrangedirection varchar(1) default null, -- plss range offset direction
   plsssection int default null, -- plss section number
   plsssectionpart varchar(50) default null -- plss section subdivisions (e.g. sw 1/4; sw 1/4 ne 1/4).
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_coord_u_typelocalityid on coordinate(coordinatetype, locality_id);  --  Localities are limited to one coordinate of a given type.

-- Each locality has zero to many coordinates.  [Each locality has zero to one coordinate of a given type]
-- Each coordinate is for one and only one locality.

-- changeset chicoreus:119
CREATE TABLE georeference (
  -- Definition: a three dimensional description of a location in standard form of decimal degress with elevation and depth, with metadata about the georeference and how it was determined, interpreted from textual locality and coordinate information.
  georeference_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  locality_id bigint not null, -- the locality to which this georeference applies 
  acceptedflag boolean not null,  -- the single georeference which is regarded as the primary/accepted georeference for the locality
  fieldverifiedflag boolean not null,  -- set true if verified by the collector in the field
  decimal_latitude decimal(12,10) not null,  -- the latitude in decimal degrees >= -90 and <= 90.
  decimal_longitude decimal(13,10) not null, -- the longitude in decimal degrees > -180 and <= 180. 
  coordinateuncertantymeters int not null,  -- an uncertanty radius in meters around the decimal latitude and longitude within which the locality falls.
  geodeticdatum varchar(50) not null default 'not recorded (forced wgs84)', -- common name (wgs84, ed50, nad27, osgb36 etc) for the geodetic datum, using a controled vocabulary.
  srs varchar(50) default null, -- epsg code for the spatial reference system for this coordinate.
  georeference_source varchar(900),  -- source for the georeference (e.g. collector, gazetter, etc).
  georeference_protocol varchar(900),  -- protocol that was followed for recording the georeference.
  georeference_method varchar(900), -- method by which the georeference was determined.
  verificationstatus varchar(40), -- verification of this georeference
  gnss_accuracy decimal(8,3) default null, -- accuracy metadata provided by gps, if source was a gps/gnss reciever
  by_agent_id bigint not null,  -- agent who determined the georeference.
  georeference_eventdate_id bigint default null,  -- event date on which the georeference was determined.
  maxelevation_meters double default null,  -- elevation of the locality, or the surface of the water (e.g. elevation of the water surface of a lake)
  minelevation_meters double default null,
  elevationaccuracy double default null,
  elevation_method varchar(50) default null,
  mindepth_meters double default null, -- minumum depth below the surface of a water body for this locality in meters.
  maxdepth_meters double default null,
  depthaccuracy double default null,
  depth_method varchar(50) default null, -- method for determining the depth
  mindistanceabovesurface_meters double default null, -- the lesser distance in a range of distance from a reference surface in the vertical direction, in meters. use positive values for locations above the surface, negative values for locations below. if depth measures are given, the reference surface is the location given by the depth, otherwise the reference surface is the location given by the elevation.
  maxdistanceabovesurface_meters double default null, -- the greater distance in a range of distance from a reference surface in the vertical direction, in meters. use positive values for locations above the surface, negative values for locations below. if depth measures are given, the reference surface is the location given by the depth, otherwise the reference surface is the location given by the elevation
  distanceabovesurfaceaccuracy double default null,
  distanceabovesurfacemethod varchar(50) default null, -- method for determining the offset distance from the surface.
  horizontal_datum varchar(255) not null default 'not recorded',
  footprint_wkt text,  -- a well known text representation of the spatial extent of the georeference, if other than point/radius
  guid varchar(128) default null,
  latlong_accuracy double default null,
  orginal_elevation_unit varchar(50) default null,
  verbatim_elevation varchar(50) default null,
  verbatim_latitude varchar(50) default null,
  verbatim_longitude varchar(50) default null,
  remarks text
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- changeset chicoreus:120
create unique index idx_georef_u_dategeorefid on georeference(georeference_eventdate_id);  --  Event dates should not be reused.

-- changeset chicoreus:121
ALTER TABLE georeference add constraint fk_gr_byagent foreign key (by_agent_id) references agent (agent_id) on update cascade;
-- changeset chicoreus:122
ALTER TABLE georeference add constraint fk_gr_geography foreign key (locality_id) references locality (locality_id) on update cascade;
-- changeset chicoreus:123
ALTER TABLE georeference add constraint fk_gr_georefdate foreign key (georeference_eventdate_id) references eventdate (eventdate_id) on update cascade;

-- Each locality has zero to many georeferences.
-- Each georeference is for one and only one locality.

-- Each georeference was georeferenced on zero to one eventdate.
-- Each eventdate is the date of zero or one georeference.

-- Each georeference was by one and only one agent.
-- Each agent made zero to many georeferences.

-- tables supporting geography

-- changeset chicoreus:124
CREATE TABLE geography (
  -- Definition: heriarchically nested higher geographical entities 
  geography_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  name varchar(255) not null,
  full_name varchar(900) default null,
  parent_id bigint default null,
  parentage varchar(2000), -- the path from the root of the tree to this geography node, maintaned by a trigger.  Starts with /, ends with the parent_id of the current node. 
  remarks text,
  abbreviation varchar(16) default null,
  centroid_lat decimal(19,2) default null,
  centroid_long decimal(19,2) default null,
  common_name varchar(128) default null,
  geography_code varchar(24) default null,  -- standard code for the geography (e.g. country code, fips code).
  geography_code_type varchar(24) default null, -- which standard code is used for the geography_code.
  guid varchar(128) default null,
  is_accepted boolean not null default true,  -- is a locally accepted value 
  accepted_id bigint default null,  -- if not accepted, which is the accepted geography entry to use instead.
  is_current boolean not null default true, -- is a current geopolitical entity 
  geographytreedef_id bigint not null,  -- which geography tree is this geography placed in    ??Redundant??
  geographytreedefitem_id bigint not null, -- which node definition applies to this node.
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create index idx_geog_name on geography(name);
create index idx_geog_full_name on geography(full_name(200));

alter table geography add constraint fk_geo_parent_id foreign key (parent_id) references geography (geography_id);
alter table geography add constraint fk_geo_accepted_id foreign key (accepted_id) references geography (geography_id);

-- Each locality is politically contained in zero or one geography.
-- Each locality is geographically contained in zero or one geography.
-- Each geography is the political container for zero to many localities.
-- Each geography is the geographic container for zero to many localities.

-- changeset chicoreus:125
CREATE TABLE geographytreedef (
  -- Definition: Definition of a geography tree
  geographytreedef_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  full_name_direction int(11) default null,  -- negative for higher to lower reading right to left, positive for higher to lower reading left to right
  name varchar(64) not null,  -- name of the geographic tree
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text  
) 
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- changeset chicoreus:126
CREATE TABLE geographytreedefitem (
  -- Definition: Definition of a node in a geography tree
  geographytreedefitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  full_name_separator varchar(32) default null,
  is_enforced boolean default null,
  is_in_full_name boolean default null,
  name varchar(64) not null,
  rank_id int(11) not null,   
  text_after varchar(64) default null,
  text_before varchar(64) default null,
  title varchar(64) default null,
  geographytreedef_id bigint not null,
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table geographytreedefitem add constraint fk_geogtrdi_treeid foreign key (geographytreedef_id) references geographytreedef(geographytreedef_id) on update cascade;

-- changeset chicoreus:127
alter table geography add constraint fk_geo_treedefitem_id foreign key (geographytreedefitem_id) references geographytreedefitem (geographytreedefitem_id);


-- changeset chicoreus:128
alter table locality add constraint fk_local_polgeogid foreign key (geopolitical_geography_id) references geography (geography_id) on update cascade;
-- changeset chicoreus:129
alter table locality add constraint fk_local_geogeogid foreign key (geographic_geography_id) references geography (geography_id) on update cascade;

-- changeset chicoreus:130
alter table agentgeography add constraint fk_agentgeog_geogid foreign key (geography_id) references geography(geography_id) on update cascade;

alter table geography add constraint fk_geography_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table geographytreedef add constraint fk_geographytreedef_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table geographytreedefitem add constraint fk_geographytreedefitem_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- Each geographytreedef is the tree for zero to many geographytreedefitem nodes.
-- Each geographytreedefitem is a node in one and only one geographytreedef.

-- Each geography is defined by one and only one geographytreedefitem.
-- Each geographytreedefitem defines zero to many taxa.

-- changeset chicoreus:131
CREATE TABLE collection (
  -- Definition: a managed set of collection objects that corresponds to an entity to which a dwc:collectionId is assigned.  Collection manages metadata about the collection, scope is for access control, and catalognumberseries links to sets of data within a collection.
  collection_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  collection_name varchar(900) default null,
  institution_code varchar(900) default null,  -- dwc:institutionCode
  institution_guid varchar(900) default null,  -- dwc:institutionId
  collection_code varchar(900) default null,  -- dwc:collectionCode
  collection_type varchar(32) default null,
  collection_guid varchar(900) default null,  -- dwc:collectionId (guid for this collection, if any)
  description text,
  estimated_size int(11) default null,
  estimated_size_units varchar(50) default 'specimens',
  scope_id varchar(900) default null,  -- the scope into which this collection falls 
  remarks text,
  website_iri varchar(255) default null,  -- website providing more information about this collection
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create index idx_coll_name on collection(collection_name(200));
alter table collection add constraint fk_collection_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:132
ALTER TABLE catalogeditem add constraint fk_ci_collection_id foreign key (collection_id) references collection(collection_id);
-- changeset chicoreus:133
ALTER TABLE catnumseriescollection add constraint fk_cnsc_collid foreign key (collection_id) references collection(collection_id) on update cascade;

-- Each catalogeditem is cataloged in one and only one collection.
-- Each collection catalogs zero to many catalogeditems.

-- Each collection falls into zero or one scope.
-- Each scope convers zero to many collections.

-- storage and changes to preparation
-- changeset chicoreus:134
CREATE TABLE storagetreedef (
  -- Definition: Definitions for storage trees 
  storagetreedef_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  full_name_direction int(11) default null,
  name varchar(64) not null,
  remarks text,
  disciplineid bigint,  -- scope of the tree
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- changeset chicoreus:135
CREATE TABLE storagetreedefitem (
  -- Definition: definition of ranks within a storage heirarchy 
  storagetreedefitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  storagetreedef_id bigint not null,  -- tree for which this is a node
  name varchar(64) not null,
  full_name_separator varchar(32) default null,
  is_enforced boolean default null,  -- if true, then must be present in the path to root for any child node
  is_in_full_name boolean default null,
  rank_id int(11) not null,  -- container rank heirarchy, larger numbers are lower ranks, lower ranks nest in higher ranks
  text_after varchar(64) default null,
  text_before varchar(64) default null,
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE INDEX idx_stdi_name ON storagetreedefitem(name);
CREATE INDEX idx_stdi_rank ON storagetreedefitem(rank_id);

ALTER TABLE storagetreedefitem add constraint fk_stdi_treeid foreign key (storagetreedef_id) references storagetreedef(storagetreedef_id);

-- changeset chicoreus:136
CREATE TABLE storage (
  -- Definition: location where zero or more preparations are stored 
  storage_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  name varchar(64) not null,  -- the name of this storage location
  barcode varchar(900) not null,  -- barcoded identifier of this storage location
  abbreviation varchar(16) not null default '', -- an abbreviated name for this storage location
  full_name varchar(255) default null,  -- a constructed full name for this storage location built from the rules in the node definition
  parent_id bigint default null, -- the parent node for this tree in the storage heirarchy
  parentage varchar(2000),  -- the list of nodes from this node to the root of the tree, separator is '/', starts with separator, ends with parent_id of current node.  Maintained with a trigger.
  scope_id bigint not null,  
  storagetreedefitem_id bigint not null,  -- node definition that applies to this storage 
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

CREATE INDEX idx_storage_parentid ON storage(parent_id);
CREATE INDEX idx_storage_name ON storage(name);
ALTER TABLE storage add constraint fk_stor_parent_id foreign key (parent_id) references storage (storage_id) on update cascade;
ALTER TABLE storage add constraint fk_stor_treeitemdefid foreign key (storagetreedefitem_id) references storagetreedefitem (storagetreedefitem_id) on update cascade;

-- changeset chicoreus:136storagemodbyagent
alter table storage add constraint fk_storage_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table storagetreedef add constraint fk_storagetreedef_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table storagetreedefitem add constraint fk_storagetreedefitem_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:137
ALTER TABLE preparation add constraint fk_prep_storage_id foreign key (storage_id) references storage (storage_id) on update cascade;

-- Each preparation has one and only one storage location.
-- Each storage is the location for zero to many preparations.

-- Each storagetreedef is the tree for zero to many storagetreedefitem nodes.
-- Each storagetreedefitem is a node in one and only one storagetreedef.

-- Each storage is defined by one and only one storagetreedefitem.
-- Each storagetreedefitem defines zero to many taxa.

-- Each storage has one and only one scope.
-- Each scope is for zero to many storage.

-- Each storage has zero or one parent storage.
-- Each storage is the parent for zero to many other storages.

-- a model for geological context 

-- changeset chicoreus:138

CREATE TABLE rocktimeunit (
  -- Definition: a geological time, rock, or rock/time unit (lithostratigraphic unit, chronostratigraphic unit.
  rocktimeunit_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  name varchar(64) not null,
  parent_id bigint default null,  -- the immediate parent of this node, null for root.
  parentage varchar(2000), -- path from the current node to root, Starts with /, ends with the parent_id of the current node.  Maintained with a trigger.
  accepted_id bigint default null,
  full_name varchar(255) default null,
  guid varchar(128) default null,
  remarks text,
  standard varchar(64) default null,
  rocktimeunittreedefitem_id int(11) not null,  -- the definition for this node 
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


alter table rocktimeunit add constraint fk_geoltp_parent_id foreign key (parent_id) references rocktimeunit (rocktimeunit_id);
alter table rocktimeunit add constraint fk_geoltp_accepted_id foreign key (accepted_id) references rocktimeunit (rocktimeunit_id);

-- Each rocktimeunit has zero or one parent rocktimeunit. 
-- Each rocktimeunit is the parent for zero to many rocktimeunits.

-- changeset chicoreus:139
CREATE TABLE rocktimeunittreedef (
  -- Definition: geologic rock/time unit trees
  rocktimeunittreedef_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  full_name_direction int(11) default null, -- assembly order for full name, negative for high to low as left to right.
  name varchar(64) not null,  -- name 
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

CREATE UNIQUE INDEX idx_geotimpertdef_u_name ON rocktimeunittreedef (name);

-- changeset chicoreus:140
CREATE TABLE rocktimeunittreedefitem (
  -- Definition: a definition of a rank in a geologic rock/time unit tree
  rocktimeunittreedefitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  name varchar(64) not null,  -- name for this rank 
  rank_id int(11) not null, -- rank for this name in the tree, larger numbers are lower ranks.
  full_name_separator varchar(32) not null default ':',
  is_enforced boolean not null default 0, -- if true, then this rank must be present in the path from any lower node to root.
  is_in_full_name boolean not null default 1, -- include this element when assembling full name 
  text_after varchar(64) default null,  -- text to place after the name of a node at this rank when assembling the name
  text_before varchar(64) default null, -- text to place before the name of a node at this rank when assembling the name
  rocktimeunittreedef_id int(11) not null,
  modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
  remarks text  -- remarks concerning the item definition
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Each rocktimeunittreedef is the tree for zero to many rocktimeunittreedefitem nodes.
-- Each rocktimeunittreedefitem is a node in one and only one rocktimeunittreedef.

-- Each rocktimeunit is defined by one and only one rocktimeunittreedefitem.
-- Each rocktimeunittreedefitem defines zero to many taxa.

-- Ranks in geochronologic (geological time, rather than chronostratigraphic rock/time) heirarchy

-- Ranks in Lithostratigraphic heirarchy
-- Could include subgroup, but it is quite uncommon.

-- changeset chicoreus:141
CREATE TABLE paleocontext (
  -- Definition: a geological context from which some material was collected.
  paleocontext_id bigint NOT NULL primary key AUTO_INCREMENT,
  paleocontext_name varchar(80) DEFAULT NULL,  -- in case context is named
  verbatim_geologic_context varchar(900) not null default '',
  verbatim_lithology varchar(900) not null default '',  -- verbatim description of the lithology 
  lithology varchar(255) default null,  -- lithology using a controled vocabulary
  biostratigraphic_unit varchar(255) default null,  -- Biostratigraphic unit for this paleocontext: superzone, biozone, subzone, or biohorizion, or historically zonule.
  is_float enum ('Yes','No','Unknown') default 'Unknown',  -- sample was collected as float on the surface and may come from elsewhere in the section
  measured_location_in_section varchar(900) not null default '',  -- description of the measured location in the section at which the material was collected.
  earlyest_geochronologic_unit_id bigint DEFAULT NULL, -- earlest geochronlological unit for this paleocontext
  latest_geochronologic_unit_id bigint DEFAULT NULL,   -- latest geochronological unit for this paleocontext
  lithostratigraphic_unit_id bigint DEFAULT NULL,  -- lithological unit for paleocontext 
  remarks text,
  modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


-- changeset chicoreus:142
alter table paleocontext add constraint fk_paleoctx_earlgeounit foreign key (earlyest_geochronologic_unit_id) references rocktimeunit (rocktimeunit_id) on update cascade;
alter table paleocontext add constraint fk_paleoctx_latgeounit foreign key (latest_geochronologic_unit_id) references rocktimeunit (rocktimeunit_id) on update cascade;
alter table paleocontext add constraint fk_paleoctx_lithunit foreign key (lithostratigraphic_unit_id) references rocktimeunit (rocktimeunit_id) on update cascade;

-- changeset chicoreus:142geolmodby
alter table rocktimeunit add constraint fk_rocktimeunit_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table rocktimeunittreedef add constraint fk_rocktimeunittreedef_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table rocktimeunittreedefitem add constraint fk_rocktimeunittreedefitem_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;
alter table paleocontext add constraint fk_paleocontext_magentid foreign key (modified_by_agent_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:143
alter table locality add constraint fk_local_paleocontext foreign key (paleocontext_id) references paleocontext (paleocontext_id) on update cascade;
-- changeset chicoreus:144
alter table collectingevent add constraint fk_colev_paleoid foreign key (paleocontext_id) references paleocontext(paleocontext_id) on update cascade;

-- Each collectingevent has zero or one paleocontext.
-- Each locality has zero or one paleocontext.
-- Each paleocontext is for zero to many collecting events.
-- Each paleocontext is for zero to many localities.

-- Each paleocontext includes zero or one lithostratigraphicunit.
-- Each paleocontext has zero or one lower bound earlyest rocktimeunit.
-- Each paleocontext has zero or one upper bound latest rocktimeunit.

-- Each lithostratigraphic unit is exposed in zero to many paleocontexts.

-- Each rocktimeunit is the lower bound for zero to many paleocontexts.
-- Each rocktimeunit is the upper bound for zero to many paleocontexts.

-- additional accumulated foreign key constraints

-- changeset chicoreus:145
alter table collectingevent add constraint fk_colev_localityid foreign key (locality_id) references locality(locality_id) on update cascade;
-- changeset chicoreus:146
alter table collectingevent add constraint fk_colev_eventdateid foreign key (date_collected_eventdate_id) references eventdate(eventdate_id) on update cascade;

-- Each systemuser is one and only one agent
-- Each agent is also zero or one systemuser
-- changeset chicoreus:147
create unique index idx_sysuser_u_useragentid on systemuser(user_agent_id);
-- changeset chicoreus:148
alter table systemuser add constraint fk_sysuser_useragentid foreign key (user_agent_id) references agent (agent_id) on update cascade;

-- changeset chicoreus:catitemindexes
create index idx_ii_catitem on identifiableitem(catalogeditem_id);
create index idx_prep_catitem on preparation(catalogeditem_id);

--  Last liquibase changeset in this document was number 148.

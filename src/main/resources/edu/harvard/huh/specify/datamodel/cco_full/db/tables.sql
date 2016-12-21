-- liquibase formatted sql

-- Schema for DINA with the CCO model at the core, strong influence from Specify-6 and influence from Arctos.
-- General conventions: table and field names in all lower case, with underscore separators for names composed from multiple words.
-- @author Paul J. Morris

-- changeset chicoreus:1
-- Framework for access control.

CREATE TABLE scope ( 
   -- Definition: Institutions and departments for which access control limitations may be applicable for some data.  NOTE: Serves to support the functionality provided with virtual private databases in Arctos.  
   scope_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   name varchar(255) not null,  -- the name for the scope, that is the name of the 
   parent_scope_id bigint default null -- Normally expected that there might be two levels of scope limitations, institutions and departments.
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table scope add constraint fk_scope_parentscopeid foreign key (parent_scope_id) references scope(scope_id) on update cascade;
-- each scope has zero to one parent scope
-- each scope is the parent for zero to many scopes

CREATE TABLE principal (
   -- Definition: An entity to which some set of access rights may apply, typically a group. (e.g. a principal may be "data entry", a group having some set of access rights for data entry, which rights and how they are implemented is not specified here).
   principal_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   principal_name varchar(255) not null,  
   is_active boolean not null default TRUE, -- does this principal have any currently active rights 
   scope_id bigint not null -- the scope to which this principal extends (e.g. principal may be data entry, scope limits that to data entry in some collection.
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_principal_u_scopename on principal(principal_name, scope_id);
alter table principal add constraint fk_principal_scopeid foreign key (scope_id) references scope(scope_id) on update cascade;
-- each principal has one and only one scope
-- each scope is for zero to many principals

CREATE TABLE systemuser ( 
   -- Definition: A user of the system
   systemuser_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   username varchar(255) not null,  
   password_hash varchar(900) not null default '', -- cryptographic hash of the password for this user
   is_enabled boolean default TRUE,
   last_login date, 
   user_agent_id bigint not null -- The agent record for this user
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_sysuser_u_username on systemuser (username);

CREATE TABLE systemuserprincipal (
   -- Definition: Participation of a system user in principles (associative entity relating systemusers to principals).
   systemuserprincipal_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   systemuser_id bigint not null,
   principal_id bigint not null
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_syuspr_u_sysuserprincipal on systemuserprincipal(systemuser_id, principal_id);

alter table systemuserprincipal add constraint fk_supr_sysuserid foreign key (systemuser_id) references systemuser(systemuser_id) on update cascade;
alter table systemuserprincipal add constraint fk_supr_principalid foreign key (principal_id) references principal(principal_id) on update cascade;
-- each systemuser has zero to many principals
-- each principal is for zero to many systemusers
-- each systemuserprincipal is for one and only one principal 
-- each principal has zero to many systemuserprincipals
-- each systemuserprincipal is for one and only one systemuser
-- each systemuser has zero to many systemuserprincipals

-- Example of composition of scope, principal, and systemuser to define permissions for users.
insert into scope (scope_id, name) values (1,'Example Institution');
insert into scope (scope_id, name,parent_scope_id) values (2,'Example Department',1);
insert into scope (scope_id, name,parent_scope_id) values (3,'Example Mammalogy Department',1);
insert into scope (scope_id, name,parent_scope_id) values (4,'Example Icthyology Department',1);
insert into scope (scope_id, name,parent_scope_id) values (5,'Example Ornithology Department',1);
insert into principal (principal_id, principal_name,scope_id) values (1,'exampleuser',1);
insert into principal (principal_id, principal_name,scope_id) values (2,'data entry',2);
insert into principal (principal_id, principal_name,scope_id) values (3,'manage transactions',2);
insert into systemuser (systemuser_id, username, is_enabled,user_agent_id) values (1,'example@example.com',FALSE,1);  
insert into systemuserprincipal (systemuser_id, principal_id) values (1,1);  -- example user has user permissions in example institution
insert into systemuserprincipal (systemuser_id, principal_id) values (1,2);  -- example user has data entry permissions in example collection

-- changeset chicoreus:2

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
  picklist_type_hint enum('select','filtering','radio') not null default 'select' -- hint to the UI of what sort of control to use to render the picklist.
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE INDEX idx_picklist_name ON picklist(name); 
CREATE UNIQUE INDEX idx_picklist_u_tablefield ON picklist (table_name,field_name); -- one picklist for a field in a table, scope is per item.

-- each picklist applies to one and only one table and field 
-- each table and field may have zero to one picklist

CREATE TABLE picklistitem (
  -- Definition: code table defining context sensitive controled vocabularies for specific fields in the database.
  picklist_item_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  picklist_id bigint not null,  -- the picklist to which this picklist item belongs
  scope_id bigint default null,  -- if not null, only show this picklist item in this context (e.g. limit 'egg' as an age class to ornithology).
  ordinal int(11) default null,  -- sort order for picklist items
  title varchar(64) not null,  -- option to show to users (e.g. 'yes', 'no', 'juvenile')
  value varchar(64) default null -- value to store in database (e.g. 1, 0, 'juvenile'), should be different from title only if field type is numeric (e.g. yes=1).
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE picklistitem add constraint fk_pklstit_picklist_id foreign key (picklist_id) references picklist(picklist_id) on update cascade on delete cascade;  
ALTER TABLE picklistitem add constraint fk_pklstit_scope_id foreign key (scope_id) references scope(scope_id) on update cascade;  
-- each picklist has zero to many picklistitems
-- each picklistitem is on one and only one picklist 
-- each ctpiclistitem is in zero to one scope (where zero scopes means the picklistitem applies in any scope)
-- each scope may apply to zero to many picklistitems


CREATE TABLE picklistitemint (
    -- Definition: internationalization for picklist items, allows use of a single language key in picklist items, provides translations of that key and definitions for that key in an arbitrary number of languages.  Because picklistitems have scopes and picklists, picklist.title is not expectd to be unique, and thus the same key for different picklists or scopes may have different definitions, thus picklistitem internationalization needs to relate to picklistitem by primary key.  
    codetableintid bigint not null primary key auto_increment, -- surrogate numeric primary key
    picklist_item_id bigint not null, -- the picklistitem which for which this is an internationalization
    lang varchar(10) not null default 'en-gb',  -- language for this record
    title_lang varchar(255),  -- translation of value to be shown to users into lang
    definition text  -- definition of name in lang
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

ALTER TABLE picklistitemint add constraint fk_pklstitint_pklstitid foreign key (picklist_item_id) references picklistitem(picklist_item_id) on update cascade;  
-- each picklistitem has zero to many translations in picklistitemint
-- each picklistitemint is a translation for one and only one picklistitem 

-- code tables (tables prefixed by ct and keyed on varchar(255)) have different bindings and are internationalized separately from picklistitems (which key on a surrogate numeric primary key).

CREATE TABLE codetableint ( 
    -- Definition: internationalization for code tables (where , allows use of a single language key in code tables, provides
    -- translations of that key and definitions for that key in an arbitrary number of languages.  Applies to code tables 
    codetableintid bigint not null primary key auto_increment, -- surrogate numeric primary key
    key_name varchar(255) not null, -- name/key in code table.  (e.g. miles in a length unit code table.
    codetable varchar(255) not null, -- code table (table name prefixed ct) in which name is found.
    lang varchar(10) not null default 'en-gb',  -- language for this record
    key_name_lang varchar(255),  -- translation of name into lang
    definition_lang text  -- definition of key_name in lang
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- changeset chicoreus:3

-- unit, identifiableitem, preparation, and catalogeditem are the core tables of the cco model.

CREATE TABLE unit (
  -- Definition: logical unit that was collected or observed in a collecting event.
  unit_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  field_number varchar(255),  -- number assigned by the collector to this collection at the collecting event
  materialsample_id bigint,
  verbatim_collection_description text,
  collectingevent_id bigint not null,
  unit_remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- each unit was collected in one and only one collectingevent
-- each collectingevent had zero to many units collected in it 

-- each unit had zero or one material sample produced from it.

-- each unit is composed of zero to many preparations (many to many unit-preparation relation with identifiable item as an associative entity)
-- each preparation is a physical preparation of one to many units 

-- changeset chicoreus:4
CREATE TABLE identifiableitem (
  -- Definition: a component of a unit for which a scientific identification can be made.
  identifiableitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  occurrence_guid varchar(900),  -- dwc:occurrenceId
  unit_id bigint not null,  -- the unit in which this identifiable item was collected,
  catalogeditem_id bigint,
  individual_count int,
  individual_count_modifier varchar(50),  -- e.g. +
  individual_count_units varchar(50)      -- e.g. valves
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- each identifiable item comes from one and only one unit
-- each unit has zero to many identifiable items

-- To apply a pick list to a field, first define a picklist
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (110, 'count modifier','identifiableitem','individual_count_modifier');
-- then define the items which comprise that pick list.
INSERT INTO picklistitem (picklist_item_id, picklist_id, ordinal, title, value) VALUES (1,110,1,'?','?');
INSERT INTO picklistitem (picklist_item_id, picklist_id, ordinal, title, value) VALUES (2,110,2,'+','+'); 
INSERT INTO picklistitem (picklist_item_id, picklist_id, ordinal, title, value) VALUES (3,110,3,'ca.','ca.');

INSERT INTO picklistitemint (picklist_item_id, lang, title_lang, definition) VALUES (1,'en_gb','?','count is uncertain.') ;
INSERT INTO picklistitemint (picklist_item_id, lang, title_lang, definition) VALUES (2,'en_gb','+','and more, count is at least the specified number.') ;
INSERT INTO picklistitemint (picklist_item_id, lang, title_lang, definition) VALUES (3,'en_gb','circa','count is approximate.') ;

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (120, 'count units','identifiableitem','individual_count_units');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (120,1,'individuals','individuals');  -- for lot based collections 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (120,2,'valves','valves');  -- could restrict to malacology and invertebrate paleontology
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (120,3,'fragments','fragments');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (120,3,'eggs','eggs');  -- could restrict to ornithology 

-- changeset chicoreus:5

CREATE TABLE part ( 
  -- Defintion:  Associative entity between identifiable items and preparations.  Generally parts of organisms that comprise preparations.
  part_id bigint not null primary key auto_increment,  -- surrogae numeric primary key 
  identifiableitem_id bigint not null,  -- the identification of the organism that this part is of
  preparation_id bigint not null, -- the preparation this part is in/on/is
  part_name varchar(50) not null, -- the name of this part
  lotcount int(11) default 1,     -- the number of items comprising this part (e.g. number of specimens in a lot)
  lotcount_modifier varchar(50) default '',  -- a modifier for the lot count (fragments, valves, ca., ?).
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (190, 'preparation status','preparation','status');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,1,'in collection','in collection');  -- verified in an inventory as in the collection

CREATE TABLE preparation (
  -- Definition: an existing or previous physical artifact that could participate in a transaction, e.g. be sent in a loan.
  -- note: does not specify preparation history or conservation history, additional entities are needed for these.
  preparation_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  exists boolean not null default TRUE, -- does this preparation still exist as a physical loanable artifact (false if the preparation has been entirely split into child preparations, or if the preparation has otherwise been destroyed, otherwise true).
  catalogeditem_id bigint,
  materialsample_id bigint,
  preparation_type varchar(50),
  preservation_type varchar(50),
  conservation_status varchar(255),
  parent_preparation_id bigint,   -- the preparation from which this preparation was derived. 
  status varchar(32) default 'in collection',
  description text default null,
  storage_id bigint default null,
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (190, 'preparation status','preparation','status');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,1,'in collection','in collection');  -- verified in an inventory as in the collection
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,2,'unknown','unknown'); -- usual status for material entered from ledgers or other paper records. 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,3,'on loan','on loan'); -- preparation is out on loan
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,3,'destroyed','destroyed'); -- preparation known to have been destroyed
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,3,'lost','lost'); -- preparation lost


-- each preparation may be the parent of zero to many child preparations (e.g. a slide prepared from a whole animal)
-- each preparation has zero or one parent preparation from which it was derived.

-- each identifiable item has zero to one parts preserved in a collection.
-- each part is one and only one identifable item.

-- each part is prepared as as one and only one preparation.
-- each preparation is composed of one to many parts


ALTER TABLE preparation add constraint fk_parentprep foreign key (parent_preparation_id) references preparation (preparation_id) on update cascade; 

ALTER TABLE preparation add constraint fk_deritentitem foreign key (derived_from_identifiable_item_id references identifiableitem (identifiableitem_id) on update cascade.

ALTER TABLE identifiableitem add constraint fk_item_unitid foreign key (unit_id) references unit(unit_id) on update cascade;  
ALTER TABLE identifiableitem add constraint fk_item_prepid foreign key (preparation_id) references preparation (preparation_id) on update cascade;

-- each preparation may be a preparation of zero or one identifiable item.
-- each identifiable item may be prepared into zero to many preparations.

ALTER TABLE preparation add constraint fk_prepofitem foreign key (preparation_of_identifiable_item_id references identifiableitem (identifiableitem_id) on update cascade.


-- Cardinality descriptions completed to here 
-- **************************************************************************************
-- 

-- changeset chicoreus:6
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
   remarks text  -- remarks concerning the identification 
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_ident_u_dateidentid on identification(date_determined_eventdate_id);  --  Event dates should not be reused.
create unique index idx_ident_u_dateverifid on identification(date_verified_eventdate_id);  --  Event dates should not be reused.

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (130, 'identification qualifier','identification','qualifier');
INSERT INTO picklistitem (picklist_item_id, picklist_id, ordinal, title, value) VALUES (10,130,1,'?','?');
INSERT INTO picklistitem (picklist_item_id, picklist_id, ordinal, title, value) VALUES (11,130,2,'aff.','aff.');
INSERT INTO picklistitem (picklist_item_id, picklist_id, ordinal, title, value) VALUES (12,130,3,'cf.','cf.');
INSERT INTO picklistitem (picklist_item_id, picklist_id, ordinal, title, value) VALUES (13,130,4,'near','near');
INSERT INTO picklistitem (picklist_item_id, picklist_id, ordinal, title, value) VALUES (14,130,6,'(group)','(group)');
INSERT INTO picklistitem (picklist_item_id, picklist_id, ordinal, title, value) VALUES (15,130,6,'sp. nov.','sp. nov.');  -- place holder for to be described species in a genus, taxon_id should have rank of genus. 
INSERT INTO picklistitem (picklist_item_id, picklist_id, ordinal, title, value) VALUES (16,130,7,'ssp. nov.','ssp. nov.');  -- place holder for to be described subspecies in a species, taxon_id should have rank of species. 

INSERT INTO picklistitemint (picklist_item_id, lang, title_lang, definition) VALUES (15,'en_gb','sp. nov.','place holder for types of soon to be described species where the name is not yet available.  the taxon used in the identification should be a genus, the assertion in the identification is that this is a new species in that genus.');
INSERT INTO picklistitemint (picklist_item_id, lang, title_lang, definition) VALUES (16,'en_gb','ssp. nov.','place holder for types of soon to be described subspecies where the name is not yet available.  the taxon used in the identification should be a species, the assertion in the identification is that this is a new subspecies in that species.');

-- changeset chicoreus:7
-- scientific name strings and taxonomic placement therof

CREATE TABLE taxon (
   -- Definition: A scientific name string that may be curated to be linked to a nomeclatural act or to an authoriative record of a name usage.
   taxon_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   scientific_name varchar(900) not null,   -- the complete scientific name for the taxon, without the authorship string
   trivial_epithet varchar(64) not null,    -- the lowest rank epithet of this scientific name (e.g. the subspecific eptithet for a subspecies).
   cultivar_name varchar(32) default null,  
   authorship varchar(900) not null,  -- the authorship string for the scientific name
   nomenclatural_code varchar(20) default null,  -- the nomenclatural code that applies to the formulation of this name and its authorship 
   display_name varchar(2000) default null,  -- assembled name, with markup for display in html
   parent_id bigint,   -- pointer to parent node in tree 
   parentage varchar(2000) not null,  -- enumerated path from current node to root of tree, using '/' as a separator, starting with a separator, ending with the taxon_id of the current node.
   taxontreedefitem_id bigint not null, -- what is the definition for this node
   rank_id int,  -- the rank of this node in the heirarchy
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
   publication_id bigint,  -- the publication containing the nomenclatural act that created the protonym/basionym for this scientific name (the publication in which this taxon was originaly described).
   cites_status varchar(32) not null default 'none',  -- CITES listing for this taxon.
   remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;


-- Each taxon has zero or one accepted taxon 
-- Each taxon is accepted for zero to many taxa.

-- Each taxon is defined by one and only one taxontreedefitem
-- Each taxontreedefitem defines zero to many taxa

-- Each taxon has zero or one parent taxon (each taxon except the root node has one and only one parent taxon)
-- Each taxon is the parent for zero to many child taxa

create index idx_taxon_acceptaxonid on taxon (accepted_taxon_id); 
alter table taxon add constraint fk_taxon_acceptedid foreign key (accepted_taxon_id) references taxon (taxon_id) on update cascade;
alter table taxon add constraint fk_taxon_parentid foreign key (parent_id) references taxon (taxon_id) on update cascade;

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (5000, 'Cites Status','taxon','cites_status');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5000,1,'none','none');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5000,2,'CITES I','CITES I');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5000,3,'CITES II','CITES II');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5000,5,'CITES III','CITES III');

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (5001, 'Nomenclatural Code','taxon','nomenclatural_code');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5001,3,'noncompliant','noncompliant');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5001,1,'ICZN','ICZN');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5001,2,'ICNafp','ICNafp');


CREATE TABLE taxontreedef (
  -- Definition: Definition of a taxonomic tree
  taxontreedef_id bigint NOT NULL primary key AUTO_INCREMENT,
  full_name_direction int(11) DEFAULT -1,  -- direction of assembly of full name
  name varchar(64) NOT NULL, -- name of the taxon tree
  remarks varchar(255) DEFAULT NULL
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

insert into taxontreedef(taxontreedef_id, name) values (1,'Taxonomic Tree');

CREATE TABLE taxontreedefitem (
  -- Definition: Definition of ranks within a taxon tree.  NOTE: Because Phylum is used for animals and Division for plants, and it is expected that both are defined in a single tree, the definitions form a map rather than a tree, so parentid and parentage aren't used.  A sort on values for rank_id is needed to find the next higher or next lower rank definition.
  taxontreedefitem_id bigint NOT NULL primary key AUTO_INCREMENT,
  fullname_separator varchar(32) not null default ' ', -- separator to use between this element and any lower rank taxon when assembling full name
  is_enforced boolean not null default FALSE, -- Must be included in tree for any node at this or lower (larger rank_id) rank
  is_in_fullname boolean not null DEFAULT FALSE,  -- Must be included in full name for any node at this 
  name varchar(64) NOT NULL,  -- the name of this rank
  nomenclatural_code varchar(20) not null default 'Any',  -- the nomenclatural code in which this rank is used
  rank_id int(11) NOT NULL,  -- Root of tree is zero.  Numerically higher ranks are lower in the taxonomic tree.  
  text_after varchar(64) DEFAULT NULL, -- text to include before this element when using in full name 
  text_before varchar(64) DEFAULT NULL, -- text to include after this element when using in full name
  taxontreedef_id bigint NOT NULL,  -- The taxon tree to which this rank definition applies
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table taxontreedefitem add constraint fk_ttdefitem_ttreedef foreign key (taxontreedef_id) references taxontreedef (taxontreedef_id) on update cascade;

alter table taxon add constraint fk_taxon_ttdefitem_id foreign key (taxontreedefitem_id)  references taxontreedefitem (taxontreedefitem_id) on update cascade;

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (5005, 'Nomenclatural Code','taxontreedefitem','nomenclatural_code');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5005,1,'Any','Any');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5005,2,'ICZN','ICZN');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5005,3,'ICNafp','ICNafp');

insert into taxontreedefitem (taxontreedefitem_id, rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (1,0, 'Life', 1, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (10, 'Kingdom', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (20, 'Major Group', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id,nomenclatural_code) values (30, 'Phylum', 0, 0,1,'ICZN');
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id,nomenclatural_code) values (30, 'Division', 0, 0,1,'ICNafp');
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (50, 'Superclass', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (60, 'Class', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (70, 'Subclass', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (90, 'Superorder', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (100, 'Order', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (110, 'Suborder', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (120, 'Infraorder', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (130, 'Superfamily', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (140, 'Family', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (150, 'Subfamily', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (160, 'Tribe', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (180, 'Genus', 1, 1,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id,text_before,text_after) values (190, 'Subgenus', 0, 0,1,'(',')');
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (220, 'Species', 1, 1,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id) values (230, 'Subspecies', 0, 0,1);
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id,text_before) values (240, 'Variety', 0, 0,1,'var.');
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id,text_before,nomenclatural_code) values (250, 'Subvariety', 0, 0,1,'sub var.','ICNafp');
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id,text_before) values (260, 'Forma', 0, 0,1,'f.');
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id,text_before,nomenclatural_code) values (270, 'Subforma', 0, 0,1,'sub f.','ICNafp');
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id,text_before,nomenclatural_code) values (280, 'Lusus', 0, 0,1,'lusus','ICNafp');
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id,text_before,nomenclatural_code) values (290, 'Modification', 0, 0,1,'mod.','ICNafp');
insert into taxontreedefitem (rank_id,name,is_enforced,is_in_fullname,taxontreedef_id,text_before,nomenclatural_code) values (300, 'Prolus', 0, 0,1,'prolus','ICNafp');

ALTER TABLE identification add constraint fk_idtaxon foreign key (taxon_id) references taxon (taxon_id) on update cascade;
ALTER TABLE taxon add constraint fk_idparent foreign key (parent_id) references taxon (taxon_id) on update cascade;
ALTER TABLE taxon add constraint fk_idaccepted foreign key (accepted_taxon_id) references taxon (taxon_id) on update cascade;

insert into taxon (taxon_id, scientific_name, trivial_epithet, authorship, display_name, parent_id, parentage, taxontreedefitem_id, rank_id) values (1,'Life','','','<strong>Life</strong>',null,'/1',1,1);

-- changeset chicoreus:8
CREATE TABLE catalogeditem (
   -- Definition: the application of a catalog number out of some catalog number series.
   catalogeditem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   catalognumberseries_id bigint not null,
   catalog_number varchar(255) not null,
   date_cataloged_eventdate_id bigint,
   cataloger_agent_id bigint,  -- The agent who cataloged the cataloged item
   accession_id bigint not null,  -- The accession in which ownership of this cataloged item was taken
   in_collection_id bigint not null  -- the collection within which this item is cataloged
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_catitem_u_datecatid on catalogeditem(date_cataloged_eventdate_id);  --  Event dates should not be reused.

-- changeset chicoreus:9
CREATE TABLE materialsample(
   -- Definition: see darwincore.
   materialsample_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   materialsample_guid varchar(255) not null,  -- dwc:materialSampleID
   sample_number varchar(255),  
   date_sampled_eventdate_id bigint,  -- the date the material sample was created
   sampled_by_agent_id bigint -- the agent who created the material sample
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_matsamp_u_datesampid on materialsample(date_sampled_eventdate_id);  --  Event dates should not be reused.

-- changeset chicoreus:10
CREATE TABLE catalognumberseries ( 
   -- Definition: a sequence of numbers of codes assigned as catalog numbers to material held in a natural science collection.
   -- note: this entity is not fully normalized.  
   catalognumberseries_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   name varchar(900),
   institution varchar(900),  
   institution_code varchar(900),
   collection varchar(900),
   collection_code varchar(900),
   dataset varchar(900),
   dataset_id varchar(900),
   remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- changeset chicoreus:11

CREATE TABLE collectingevent (
   -- Definition: an event in which an occurrance was observed in the wild, and typically, for a natural science collection, a voucher was collected, time at which a collector visited a locality and collected one or more collected units using a single sampling method.
  collectingevent_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  locality_id bigint default null,
  sampling_method varchar(50) default null,  -- the sampling method that was applied in this collecting event
  collectors_field_number varchar(255) default null,  -- a number assigned by the collector to the collecting event, this might be called a field number or a station number or a collector number, but the semantics for this number must be that it applies to the collecting event.
  verbatim_date varchar(255) default null,
  date_collected_eventdate_id bigint default null, -- date or date range within which this collecting event occurred
  guid varchar(128) default null,
  paleocontext_id bigint default null,
  expedition varchar(900) default null,  -- named expedition that this collecting event was part of
  vessel varchar(900) default null,  -- RV, ship or other vessel that this collecting event was made from
  platform varchar(900) default null, -- submersible, ROV, or other platform that this collecting event was made from
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_colev_u_datecollid on collectingevent(date_collected_eventdate_id);  --  Event dates should not be reused.
alter table unit add constraint fk_unit_colleventid foreign key (collectingevent_id) references collectingevent(collectingevent_id) on update cascade;
alter table unit add constraint fk_unit_matsampid foreign key (materialsample_id) references materialsample(materialsample_id) on update cascade;

-- changeset chicoreus:12

CREATE TABLE eventdate ( 
   -- Definition: a set of spans of time in which some event occurred.  NOTE: Cardinality is enforced as zero or one to one in each relation with unique indexes, and event dates should not be reused accross relations.
   eventdate_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   date_type varchar(50) not null default 'date',
   verbatim_date varchar(255) not null,  -- the event date in its original verbatim form
   iso_date varchar(255) not null default '',  -- The event date in ISO form, including date ranges.
   start_date date,  -- the first date of the event date in date form
   start_date_precision int,  -- precision of the start date (to year, to month, or to day)
   start_datetime datetime default null,  -- if start or end times are known
   end_date date,  -- the last date of the event date in date form
   end_date_precision int, -- the precision of the end date (to year, to month, or to day)
   end_datetime datetime default null, -- if start or end times are known
   start_end_fully_specifies boolean default true -- true if a single date or a continuous range.
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (6001, 'Date Type','eventdate','date_type');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (6001,1,'date','date');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (6001,2,'interval','interval');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (6001,3,'year','year');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (6001,4,'year/month','year/month');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (6001,5,'date time','date time');

-- changeset chicoreus:13

ALTER TABLE unit add constraint fk_colevent foreign key (collectingevent_id) references collectingevent (collectingevent_id) on update cascade;

ALTER TABLE collectingevent add constraint fk_colevent_cdate foreign key (date_collected_eventdate_id) references eventdate (eventdate_id) on update cascade;
ALTER TABLE materialsample add constraint fk_matsamp_samdate foreign key (date_sampled_eventdate_id) references eventdate (eventdate_id) on update cascade;
ALTER TABLE catalogeditem add constraint fk_catitem_catdate foreign key (date_cataloged_eventdate_id) references eventdate (eventdate_id) on update cascade;
ALTER TABLE identification add constraint fk_ident_detdate foreign key (date_determined_eventdate_id) references eventdate (eventdate_id) on update cascade;
ALTER TABLE identification add constraint fk_ident_verdate foreign key (date_verified_eventdate_id) references eventdate (eventdate_id) on update cascade;

-- changeset chicoreus:14

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
  geographic_geography_id bigint default null -- the geographic context  for this locality (ocean, ocean region, ocean subregion, sea, continent, etc.),
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create index idx_local_name on locality(locality_name);
create index idx_local_num on locality(locality_number);
create index idx_local_shortname on locality(short_name);
create index idx_local_namedplace on locality(named_place);
create index idx_local_namedplacerel on locality(relation_to_named_place);

ALTER TABLE collectingevent add constraint fk_locality foreign key (locality_id) references locality (locality_id) on update cascade;

-- changeset chicoreus:15
CREATE TABLE othernumber (
   --  Definition: a number or code associated with a specimen that is not known to be its catalog number
   othernumber_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   target_table varchar(255) not null,  -- the table to which pk refers to the primary key.
   pk bigint not null,                 -- the surrogate numeric primary key of a row in target_table.
   number_type varchar(255) not null,  -- the type of other number (which may be unknown)
   number_value varchar(255) not null  -- the value of the other number
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;
 
CREATE UNIQUE INDEX idx_tablepk on othernumber(target_table, pk);

-- changeset chicoreus:16
-- tables supporting transactions 

CREATE TABLE transactionitem (
   -- Definition:  the participation of a preparation in a transaction (e.g. a loan).
   -- note: table is only minimally specified.
   transactionitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   trans_preparation_id bigint, -- can be null to allow for transactions of non-cataloged items
   item_count int, -- number of items involved in the transaction.
   item_count_modifier varchar(50),  -- modifier on the item count (about, more than, etc.)
   item_count_units varchar(50),  -- units of item count (truckloads, boxes, lots, specimens, etc).
   description text, -- description of the material involved in the transaction.
   item_conditions text,  -- conditions applied to this item in this transaction, e.g. no destructive sampling
   disposition varchar(50)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

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
   remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_coltra_u_numserscope on transactionc (trans_number, trans_number_series, scope_id);  

INSERT INTO picklist (picklist_id, name, table_name, field_name,read_only) VALUES (150, 'transaction type','coll_transaction','trans_type',1);  -- ennumerated subtypes of transactions corresponding to subtype tables.
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (150,1,'Loan','loan'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (150,2,'Gift','gift'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (150,3,'Borrow','borrow'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (150,4,'Deaccession','deaccession'); 

INSERT INTO picklist (picklist_id, name, table_name, field_name,read_only) VALUES (170, 'transaction type','coll_transaction','status',0);  -- status for transactions
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (170,1,'in process','in process'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (170,2,'open','open'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (170,3,'open partial return','open partial return'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (170,4,'closed','closed'); 

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
  SrcGeography text DEFAULT null,  -- Countries of origin of the material.   
  SrcTaxonomy text DEFAULT NULL,   -- Taxa included in the material.  
  recipient_addressofrecord_id bigint DEFAULT NULL  -- address to which this loan was sent 
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE gift (
  -- Definition: A record of a non-returnable movement of a set of specimens out of a collection to another insitution
  gift_id bigint not null primary key AUTO_INCREMENT,
  transactionc_id bigint not null,
  summary_description varchar(255) not null, -- brief description of the material involved in the gift.
  sent_date  date, -- the date on which the loan was made 
  recipient_addressofrecord_id bigint DEFAULT NULL  -- address to which this gift was sent 
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

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
  SrcGeography text DEFAULT null,  -- Countries of origin of the material.
  SrcTaxonomy text DEFAULT NULL,   -- Taxa included in the material.
  sender_addressofrecord_id bigint DEFAULT NULL  -- address to which this borrow was expected to be returned.
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE deaccession (
  -- Definition: A record of a non-returnable movement of a set of specimens out of a collection to outside of institutional care
  deaccession_id bigint not null primary key AUTO_INCREMENT,
  transactionc_id bigint not null,
  summary_description varchar(255) not null, -- brief description of the material involved in the deaccesison.
  deaccession_date  date, -- the date on which the material was deaccessioned.
  deaccession_reason text -- reason why this material was deaccessioned
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (160, 'loan type','loan','loan_type');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (160,1,'returnable','returnable');  -- returnable in whole or in part
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (160,2,'consumable','consumable'); -- entirely consumable, only data is expected to be returned.
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (160,3,'exhibition','exhibition'); -- loan of valuable material for exhibition with additional standard conditions 

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (180, 'borrow type','borrow','borrow_type');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (180,1,'returnable','returnable');  -- returnable in whole or in part
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (180,2,'consumable','consumable'); -- entirely consumable, only data is expected to be returned.
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (180,3,'exhibition','exhibition'); -- loan of valuable material for exhibition with additional standard conditions 

CREATE TABLE transactionagent (
  -- Definition: the participation of an agent in a transaction in some defined role (e.g. the agent who gave approval for some loan).
  transactionagent_id bigint NOT NULL primary key AUTO_INCREMENT,
  agent_id bigint not null,  -- the agent involved in this transaction 
  transactionc_id bigint not null, -- the transaction the agent is involved in
  role varchar(50) not null,  -- the role of the agent in the transaction
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create unique index idx_transagent_u_roletransagent on transactionagent(role, agent_id, transactionc_id);

-- changeset chicoreus:17

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
    guid varchar(900),  --  owl:sameas  external guid for this record.
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
    living enum('Yes','No','?') not null default '?'
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

-- when a picklist applies to a field defined with an enum, specify read_only=1 for the picklist.
INSERT INTO picklist (picklist_id, name, table_name, field_name, read_only) VALUES (100, 'agent type','agent','agent_type',1);
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (100,1,'individual','individual');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (100,2,'team','team');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (100,3,'organization','organization');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (100,4,'software agent','software agent');

INSERT INTO picklist (picklist_id, name, table_name, field_name, read_only) VALUES (101, 'agent living','agent','living',1);
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (101,1,'Yes','Yes');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (101,2,'No','No');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (101,3,'?','?');

-- changeset chicoreus:18
-- catching up on agent relations 

ALTER TABLE catalogeditem add constraint foreign key fk_catagent (cataloger_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_authagent (author_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_parauthagent (parauthor_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_exauthagent (exauthor_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_parexauthagent (parexauthor_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_sanctauthagent (sanctauthor_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_parsaauthagent (parsanctauthor_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE taxon add constraint foreign key fk_citauthagent (cited_in_agent_id) references agent (agent_id) on update cascade;

alter table transactionagent add constraint fk_ta_agentid foreign key (agent_id) references agent(agent_id) on update cascade;
alter table transactionagent add constraint fk_ta_coltransid foreign key (transactionc_id) references agent(agent_id) on update cascade;

-- changeset chicoreus:19

-- add additional tables to support agents

CREATE TABLE ctrelationshiptype (
   -- Definition: types of relationships between pairs of agents.
   relationship varchar(255) not null primary key,
   inverse varchar(50),
   collective varchar(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ctrelationshiptype (relationship, inverse, collective) VALUES ('child of', 'parent of', 'children');
INSERT INTO ctrelationshiptype (relationship, inverse, collective) VALUES ('student of', 'teacher of', 'students');
INSERT INTO ctrelationshiptype (relationship, inverse, collective) VALUES ('spouse of', 'spouse of', 'married to');
INSERT INTO ctrelationshiptype (relationship, inverse, collective) VALUES ('could be', 'confused with', 'confused with');  -- to accompany nototherwisespecified 
INSERT INTO ctrelationshiptype (relationship, inverse, collective) VALUES ('successor of', 'predecessor of', 'sucessors');  -- to relate organizations 

-- each ctrelationshiptype has zero to many internationalization in codetableint (join on relationship-key_name).
-- each codetableint provides zero to one internationalization of ctrelationshiptype (join on relationship-key_name).

CREATE TABLE agentteam (
   --  Definition: Composition of agents into teams of individuals, such that both the team and the members can be agents.
   agentteam_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   team_agent_id bigint not null, 
   memberagent_id bigint not null, 
   ordinal int
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table agentteam add constraint fk_agentt_tagent_id foreign key (team_agent_id) references agent(agent_id) on delete no action on update cascade;
alter table agentteam add constraint fk_agentt_membid foreign key (memberagent_id) references agent(agent_id) on delete no action on update cascade;

CREATE TABLE agentnumberpattern (
   -- Definition: machine and human redable descriptions of collector number patterns
   agentnumber_pattern_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   agent_id bigint not null,  -- the agent to whom this number pattern applies
   number_type varchar(50) default 'collector number',
   number_pattern varchar(255),  --  regular expression for numbers that conform with this pattern
   number_pattern_description varchar(900),  -- human readable description of the number pattern
   startyear int, --  year for first known occurrence of this number pattern
   endyear int,   --  year for last knon occurrenc of this number pattern
   integerincrement int, -- does number have an integer increment 
   notes text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table agentnumberpattern add constraint fk_anp_agent_id foreign key (agent_id) references agent(agent_id) on delete cascade on update cascade;

CREATE TABLE agentreference (
   --  Definition: Links to published references the content of which is about collectors/agents (e.g. obituaries, biographies).
   agentreference_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   refid int not null,
   agent_id int not null
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create index idx_refagentlks_refagent on agentreference (refid, agent_id);

CREATE TABLE agentlink (
   -- Definition: supporting hyperlinks out to external sources of information about collectors/agents.
   agentlink_id bigint primary key not null auto_increment, -- surrogate numeric primary key 
   agent_id int not null, 
   type varchar(50), 
   link varchar(900), 
   isprimarytopicof boolean not null default true,  --  link can be represented as foaf:primarytopicof
   text varchar(50)
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


CREATE TABLE agentname (
   --  Definition:  multiple variant forms of names and names for a collector/agent
   agentname_id bigint primary key not null auto_increment, -- surrogate numeric primary key 
   agent_id int not null,  
   type varchar(32) not null default 'full name', 
   name  varchar(255),  
   language varchar(6) default 'en_us', 
   foreign key (type) references ctnametypes(type) on delete no action on update cascade,
   foreign key (agent_id)  references agent(agent_id)  on delete cascade  on update cascade
)
ENGINE=myisam -- to ensure support for fulltext index
DEFAULT CHARSET=utf8;  

create unique index idx_agentname_u_idtypename on agentname(agent_id,type,name); --  combination of recordedbyid, name, and type must be unique.

create fulltext index ft_collectorname on agentname(name);

INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (140, 'Name Types','agent','name_type');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (140,1,'full name','full name'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (140,1,'initials last name','initials last name'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (140,1,'last name, initials','last name, initials'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (140,1,'first initials last','first initials last'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (140,1,'first last','first last'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (140,1,'standard abbreviation','standard abbreviation'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (140,1,'standard dwc list','standard dwc list'); 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (140,1,'also known as','also known as'); 


CREATE TABLE agentrelation (
   -- Definition: A relationship between one agent and another, serves to represent relationships (family,marrage,mentorship) amongst agents.
   agentrelation_id bigint not null primary key auto_increment, -- surrogate numeric primary key 
   from_agent_id bigint not null,  --  parent agent in this relationship 
   to_agent_id bigint not null,    --  child agent in this relationship 
   relationship varchar(50) not null,  -- nature of relationship from ctrelationshiptype 
   notes varchar(900),
   foreign key (from_agent_id) references agent(agent_id) on delete cascade on update cascade,
   foreign key (to_agent_id) references agent(agent_id) on delete cascade on update cascade,
   foreign key (relationship) references ctrelationshiptype(relationship) on delete no action on update cascade
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE agentgeography (
  -- Definition:  relationships of agents with geographies (as collector, author, etc).
  agentgeography_id bigint NOT NULL primary key AUTO_INCREMENT,
  role varchar(64) DEFAULT NULL,  -- the role of the agent with respect to the geography (e.g. author on, collector in).
  agent_id bigint NOT NULL,  -- the agent with a relattion to geography
  geography_id bigint NOT NULL,  -- the geography the agent has a relationship to.
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table agentgeography add constraint fk_agentgeog_agentid foreign key (agent_id) references agent(agent_id) on update cascade;

CREATE TABLE agentspeciality (
  -- Definition: Knowledge of particular agents in particular taxa.
  agentspeciality_id bigint NOT NULL primary key AUTO_INCREMENT,
  agent_id bigint not null, -- the agent with this speciality
  ordinal int(11) NOT NULL, -- ordering of specialities
  skill_level varchar(50) DEFAULT NULL, -- skill level of agent in speciality (e.g. global expert, regional expert, etc.).
  taxon_id bigint not null, -- the taxon that the agent has a speciality in.
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

alter table agentspeciality add constraint fk_agentspeci_agentid foreign key (agent_id) references agent(agent_id) on update cascade;
alter table agentspeciality add constraint fk_agentspeci_taxonid foreign key (taxon_id) references taxon(taxon_id) on update cascade;

-- changeset chicoreus:20


CREATE TABLE cttextattributetype (
    -- Definition: types of text attributes
    key_name varchar(255) not null primary key,  -- the name of the attribute type
    scope varchar(900)  -- list of tables to which this attribute type applies
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE textattribute (
    -- Definition: a generic typed text attribute that can be added to any table.
    textattributeid bigint not null primary key auto_increment, -- surrogate numeric primary key
    key_name varchar(255) not null,   -- the type of attribute
    value varchar(900) not null,  -- the value of the attribute
    for_table varchar(255) not null,  -- table to which this attribute is applied 
    primary_key_value bigint not null  -- row in for_table to which this attribute is applied
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE textattribute add constraint fk_textattributetype foreign key (key_name) references cttextattributetype (key_name) on update cascade; 
-- each cttextattribute type is the key for zero to many textattributes
-- each textattribute has one and only one cttextattributetype as a key

-- each textattribute applies to one and only one row in a table (keyed on for_table and primary_key_value)
-- each row in a table has zero to many textattributes (keyed on for_table and primary_key_value)

CREATE TABLE inference (
    -- Definition:  metadata description of the basis of an inference made in interpreting a value in any field in any table
    inferenceid bigint not null primary key auto_increment, -- surrogate numeric primary key
    inference text not null,  -- the interpreter's description of the inference tha was made
    by_agent_id bigint not null, -- who (most recently) made the inference
    ondate timestamp not null default CURRENT_TIMESTAMP, -- date of most recent change to this inference, inferences added in this system, so can use date instead of eventdate.
    for_table varchar(255) not null,  -- table to which this interpretation was applied
    for_field varchar(255) not null,  -- field in the table to which this intepretation was applied
    primary_key_value bigint not null  -- row in for_table to which this interpretation was applied
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE UNIQUE INDEX idx_infer_u_ftablefieldpkv ON inference(for_table,for_field,primary_key_value); -- allow zero or one inferences for one field in one table.

-- each inference applies to one and only one tuple (keyed on for_table, for_field, and primary_key_value)
-- each tuple has zero or one inference (keyed on for_table, for_field, and primary_key_value)

-- changeset chicoreus:21

CREATE TABLE ctnumericattributetype (
    -- Definition: types of numeric attributes
    name varchar(255) not null primary key,  -- the name of the attribute type
    scope varchar(900)  -- list of tables to which this attribute type applies
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE numericattribute (
    -- Definition: a generic typed numeric attribute that can be added to any table.
    attributeid bigint not null primary key auto_increment, -- surrogate numeric primary key
    name varchar(255) not null,   -- the type of attribute
    value float(20,10) not null,  -- the value of the attribute
    units varchar(255),           -- units, if any to be ascribed to the attribute
    for_table varchar(255) not null,
    primary_key_value bigint not null
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE numericattribute add constraint fk_numericattributetype foreign key (name) references ctnumericattributetype (name) on update cascade; 

-- changeset chicoreus:22

-- definitions for pick lists associated with biological attributes and generic attributes.  Table picklist's table/field binding can't be used for these.

CREATE TABLE ctbiologicalattributetype (
    -- Definition: types of biological attributes 
    name varchar(255) not null primary key,   -- the name of the attribute type 
    valuecodetable varchar(60),  -- code table to use to restrict allowed values 
    unitscodetable varchar(60),   -- code table to use to restrict allowed units 
    methodcodetable varchar(60)   -- code table to use to restrict allowed determination methods
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE ctlengthunit (
  -- Definition: controled vocabulary for units of length.
  lengthunit varchar(255) not null primary key
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

INSERT INTO ctlengthunit (lengthunit) VALUES ('meters');
INSERT INTO ctlengthunit (lengthunit) VALUES ('centimeters');
INSERT INTO ctlengthunit (lengthunit) VALUES ('milimeters');

CREATE TABLE ctmassunit (
  -- Definition: controled vocabulary for units of mass.
  massunit varchar(255) not null primary key
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

INSERT INTO ctmassunit (massunit) VALUES ('grams');
INSERT INTO ctmassunit (massunit) VALUES ('kilograms');
INSERT INTO ctmassunit (massunit) VALUES ('miligrams');

CREATE TABLE ctageclass (
  -- Definition: controled vocabulary for age classes.
  ageclassid bigint not null primary key auto_increment, -- surrogate numeric primary key
  ageclass varchar(255) not null
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE scopect (
  -- Definition relationship between a key in a code table and a scope.
  scopect_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  key_name varchar(255) not null,  -- key which has the scope 
  ct_table_name varchar(255) not null,  -- table in which key is found
  scope_id bigint not null  -- scope for the key 
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_scopect_u_keytable on scopect (key_name, ct_table_name, scope_id);

alter table scopect add constraint fk_scopect_scopeid foreign key (scope_id) references scope (scope_id) on update cascade;
-- each scopect has one and only one scope
-- each scope applies to zero to many scope_id
-- each scopect is for one and only one key name in a code table
-- each key name in a code table has zero to many scope-codetable relations in codect

INSERT INTO ctageclass (ageclass) VALUES ('unknown');
INSERT INTO ctageclass (ageclass) VALUES ('adult');
INSERT INTO ctageclass (ageclass) VALUES ('juvenile');
INSERT INTO ctageclass (ageclass) VALUES ('pup');
INSERT INTO ctageclass (ageclass) VALUES ('chick');
INSERT INTO ctageclass (ageclass) VALUES ('nestling');
INSERT INTO ctageclass (ageclass) VALUES ('subadult');
INSERT INTO ctageclass (ageclass) VALUES ('immature');
INSERT INTO ctageclass (ageclass) VALUES ('egg');
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','pup',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','chick',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','nestling',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','subadult',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','immature',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','egg',5);

INSERT INTO ctbiologicalattributetype (name) VALUES ('sex');
INSERT INTO ctbiologicalattributetype (name) VALUES ('age');
INSERT INTO ctbiologicalattributetype (name,valuecodetable) VALUES ('age class','ctageclass');
INSERT INTO ctbiologicalattributetype (name) VALUES ('numeric age');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('weight','ctmassunit');
INSERT INTO ctbiologicalattributetype (name) VALUES ('stomach contents');
INSERT INTO ctbiologicalattributetype (name) VALUES ('reproductive condition');
INSERT INTO ctbiologicalattributetype (name) VALUES ('reproductive data');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('standard length','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('body length','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('disk length','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('fork length','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('head length','ctlengthunit');
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','standard length',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','body length',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','disk length',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','fork length',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','head length',4);
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('axillary girth','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('crown-rump length','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('curvilinear length','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('ear from crown','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('ear from notch','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('forearm length','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('hind foot with claw','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('hind foot without claw','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('tail length','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('tragus length','ctlengthunit');
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','axillary girth',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','crown-rump length',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','curvilinear length',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','ear from crown',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','ear from notch',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','forearm length',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','hind foot with claw',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','hind foot without claw',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','tail length',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','tragus length',3);
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('total length','ctlengthunit');
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','total length',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','total length',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','total length',5);
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('wing chord','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('eggshell thickness','ctlengthunit');
INSERT INTO ctbiologicalattributetype (name) VALUES ('bare parts coloration');
INSERT INTO ctbiologicalattributetype (name) VALUES ('colors');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('egg content weight','ctmassunit');
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('embryo weight','ctmassunit');
INSERT INTO ctbiologicalattributetype (name) VALUES ('extent');
INSERT INTO ctbiologicalattributetype (name) VALUES ('fat deposition');
INSERT INTO ctbiologicalattributetype (name) VALUES ('incubation');
INSERT INTO ctbiologicalattributetype (name) VALUES ('molt condition');
INSERT INTO ctbiologicalattributetype (name) VALUES ('ossification');
INSERT INTO ctbiologicalattributetype (name) VALUES ('plumage coloration');
INSERT INTO ctbiologicalattributetype (name) VALUES ('plumage description');
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','wing chord',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','eggshell thickness',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','bare parts coloration',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','colors',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','egg content weight',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','embryo weight',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','extent',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','fat deposition',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','incubation',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','molt condition',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','ossification',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','plumage coloration',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','plumage description',5);

CREATE TABLE biologicalattribute (
    -- Definition: a generic typed attribute for biological characteristics of organisms, 
    --  including metadata about who determined the attribute value when.
    attributeid bigint not null primary key auto_increment, -- surrogate numeric primary key
    name varchar(255) not null,  -- restricted by ctbiologicalattributetype
    value varchar(900) not null, -- value for attribute, may be restricted by value code table specified in ctbiologicalattributetype
    units varchar(255) not null, -- units for attribute, may be restricted by unit code table specified in ctbiologicalattributetype
    determinationmethod varchar(255) not null,
    remarks text,
    determiningagent_id bigint,
    datedetermined varchar(50),    --  iso date for date/date ranged determined, may be just year, may be unknown
    identifiableitem_id bigint not null  -- the identifiableitem to which this biological attribute applies
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE biologicalattribute add constraint fk_biologicalattributetype foreign key (name) references ctbiologicalattributetype (name) on update cascade; 

-- changeset chicoreus:23

-- Minimal audit log of who applied changes to what tables when, does not record the query that was fired.
-- Significant change from Specify, replaces the createdByAgentId/modifiedByAgentId timestampCreated/timestampLastModified fields in each table.
-- For more detailed audit logs, use a mechanism intrinsic to the database or a plugin.

CREATE TABLE auditlog ( 
    -- Definition: timestamps and users who have inserted, deleted, or updated data in each table.  NOTE: Maintain with triggers on each table.
    auditlogid bigint not null primary key auto_increment, -- surrogate numeric primary key
    action varchar(50),  -- action carried out, insert, delete, update 
    timestamptouched datetime not null,  -- timestamp of the modification, datetime rather than timestamp to support import of data from previous systems.
    username varchar(255) not null,   -- username of current logged in user, retained even if agent record is edited
    agent_id bigint default null,      -- agent_id of the user who made the change
    for_table varchar(255) not null,   -- table in which primary_key_value is found
    primary_key_value bigint not null  
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


ALTER TABLE auditlog add constraint fk_auditlogagent_id foreign key (agent_id) references agent (agent_id) on update cascade;

-- changeset chicoreus:24

-- encumbarances, masking visiblity of data, generalized from mechainism in Arctos.

CREATE TABLE ctencumberancetype ( 
   -- Definition: controled vocabulary of encumberance types.
   encumberance_type varchar(50) not null primary key
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

INSERT INTO ctencumberancetype (encumberance_type) VALUES ('mask record'); -- Do not show the encumbered record (e.g. hide a media record).
INSERT INTO ctencumberancetype (encumberance_type) VALUES ('redact locality');  -- Redact coordinate, georeference, elevation, and detailed locality information associated with this record.  
INSERT INTO ctencumberancetype (encumberance_type) VALUES ('mask record and relations'); -- Do not show the encumbered record or related data object (e.g. for a taxon, hide units that use this taxon in an identificaiton; or for a media record hide the meida record and associated unit data).

CREATE TABLE encumberance (
   --  Definition: a description of the limitations on the visiblity of some data to the public.  All public presentations of data must observe the encumberance associated with that data.  
   encumberance_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   explanation text,   -- the reason for the encumberance 
   encumberance_type varchar(50),   
   createdby_agent_id bigint not null,
   make_visible_on date, -- date on which encumberance expires, null for no expiration date
   make_visible_criteria text, -- description of criteria under which encumberance expires 
   visible_to_scope_id bigint -- scope to which the encumbered data should be visible
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE encumberance add constraint fk_enctype foreign key (encumberance_type) references ctencumberancetype (encumberance_type) on update cascade;
ALTER TABLE encumberance add constraint fk_encagent foreign key (createdby_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE encumberance add constraint fk_encvisiblescope foreign key (visible_to_scope_id) references scope (scope_id) on update cascade;

CREATE TABLE catitemencumberance ( 
   -- Definition: relationship between encumberances and cataloged items
   catitemencumberance_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   encumberance_id bigint not null,
   catalogeditemid bigint not null
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE attachmentencumberance ( 
   -- Definition: relationship between encumberances and attachment (metadata records), encumberance of actual media objects needs to be handleed by a digital asset management system.
   attachmentencumberance_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   encumberance_id bigint not null,
   attachment_id bigint not null
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE localityencumberance ( 
   -- Definition: relationship between encumberances and localities (e.g. for fossil localities where not publicizing the locality was a condition of collecting at that locality).   
   localityencumberance_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   encumberance_id bigint not null,
   locality_id bigint not null
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE taxonencumberance ( 
   -- Definition: relationship between encumberances and taxa (e.g. for soon-to-be-described species, or for taxa which are controled substances).   
   taxonencumberance_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   encumberance_id bigint not null, -- The encumberance that applies to a taxon
   taxon_id bigint not null -- The taxon to which an encumberance applies 
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- changeset chicoreus:25 

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
  isprimary boolean default null,  -- true if this is the primary address for this agent
  isshipping boolean default null, -- true if this is an address to which shipments can be sent
  ordinal int(11) default null,   -- sort order for addresses 
  start_eventdate_id bigint default null,  -- date on which this address began to be used
  end_eventdate_id bigint default null,  -- date on which this address ceased to be used
  remarks text
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_address_u_startdateid on address(start_eventdate_id);  --  Event dates should not be reused.
create unique index idx_address_u_enddateid on address(end_eventdate_id);  --  Event dates should not be reused.

CREATE INDEX idx_address_addagent_id on address(address_for_agent_id);

ALTER TABLE address add constraint fk_addressforagent foreign key (address_for_agent_id) references agent (agent_id) on update cascade; 
ALTER TABLE address add constraint fk_add_startevdate foreign key (start_eventdate_id) references eventdate (eventdate_id) on update cascade; 
ALTER TABLE address add constraint fk_add_endevdate foreign key (end_eventdate_id) references eventdate (eventdate_id) on update cascade; 

CREATE TABLE ctelectronicaddresstype ( 
   -- controled vocabulary for allowed types of electronic addresses
   typename varchar(255) not null primary key 
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

INSERT INTO ctelectronicaddresstype (typename) VALUES ('phone');
INSERT INTO ctelectronicaddresstype (typename) VALUES ('fax');
INSERT INTO ctelectronicaddresstype (typename) VALUES ('email');

CREATE TABLE electronicaddress ( 
   -- Definition: email, phone, fax, or other electronic contact address for an agent
   electronicaddress_id bigint not null primary key auto_increment, -- surrogate numeric primary key
   typename varchar(255) not null,
   address varchar(255) not null,
   remarks text,
   is_current boolean default null,  -- true if this is a current contact number/email
   isprimary boolean default null,  -- true if this is the primary contact number/email for this agent
   ordinal int(11) default null   -- sort order for electronic addresses
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE electronicaddress add constraint fk_ea_nametype foreign key (typename) references ctelectronicaddresstype (typename) on update cascade;

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
  remarks text
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE addressofrecord add constraint fk_aor_addressforagent foreign key (address_for_agent_id) references agent (agent_id) on update cascade ; 

ALTER TABLE loan add constraint fk_loan_loanaddress foreign key (recipient_addressofrecord_id) references addressofrecord (addressofrecord_id) on update cascade ; 
-- changeset chicoreus:26 
-- accession and closely related tables

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
  repositoryagreementid bigint default null,  -- repository agreement which governs this accession
  scope_id bigint not null  -- the scope within which this accession record is visible
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create unique index idx_access_u_dateackid on accession(date_acknowledged_eventdate_id);  --  Event dates should not be reused.
create unique index idx_access_u_dateaccid on accession(date_accessioned_eventdate_id);  --  Event dates should not be reused.
create unique index idx_access_u_daterecid on accession(date_received_eventdate_id);  --  Event dates should not be reused.

alter table accession add constraint fk_acc_scope_id foreign key (scope_id) references scope (scope_id) on update cascade on delete NO ACTION;

CREATE TABLE repositoryagreement (
  -- Definition: an agreement under which one institution agrees to be the repository for material that is owned by another organization.
  repositoryagreementid bigint not null primary key auto_increment, -- surrogate numeric primary key
  datereceived date default null,  -- date at which the repository agreement document was received.
  enddate date default null,  -- date at which this repository agreement ends.
  remarks text,
  repositoryagreementnumber varchar(60) not null,  
  startdate date default null,  -- date at which this reposoitory agreement becomes effective 
  status varchar(32) default null,
  agreementwithagent_id bigint not null,   -- agent with whom this repository agreement has been made with
  scope_id bigint not null,  -- the scope within which this repository agreement record is visible
  addressofrecord_id bigint default null  -- address of record for the agent with whom this repository agreement is with at the time of the agreement.
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;


ALTER TABLE accession add constraint fk_acc_repositoryagreement foreign key (repositoryagreementid) references repositoryagreement (repositoryagreementid) on update cascade; 
ALTER TABLE accession add constraint fk_acc_addresofrecrod foreign key (addressofrecord_id) references addressofrecord (addressofrecord_id) on update cascade; 

alter table repositoryagreement add constraint fk_ra_scope_id foreign key (scope_id) references scope (scope_id) on update cascade on delete NO ACTION;
ALTER TABLE repositoryagreement add constraint fk_ra_agreementwith foreign key (agreementwithagent_id) references agent (agent_id) on update cascade;
ALTER TABLE repositoryagreement add constraint fk_ra_addressofrecord foreign key (addressofrecord_id) references addressofrecord (addressofrecord_id) on update cascade;


CREATE TABLE accessionagent (
  -- Definition: The participation of an agent in an accession in some defined role (e.g. the agent who approved some accession).
  accessionagent_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  role varchar(50) not null,
  accession_id bigint default null,
  agent_id bigint not null,
  remarks text
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

ALTER TABLE accessionagent add constraint fk_accessionagent foreign key (agent_id) references agent (agent_id) on update cascade; 
ALTER TABLE accessionagent add constraint fk_accessionforagent foreign key (accession_id) references accession (accession_id) on update cascade on delete cascade; 

--  an agent cannot have the same role twice in the same accession.
CREATE UNIQUE INDEX idx_accessionagent_agroacc on accessionagent(agent_id, role, accession_id); 

-- changeset chicoreus:27

-- attachments

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
  remarks text
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE attachmentrelation (
  -- Definition: relationship between any row in any table and an attached media object.  Means of associating media objects with data records.
  attachmentrelationid bigint not null primary key auto_increment, -- surrogate numeric primary key
  attachment_id bigint not null,
  for_table varchar(255) not null,
  primary_key_value bigint not null,
  ordinal int(11) not null,
  remarks text
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table attachmentrelation add constraint fk_attrel_attid foreign key (attachment_id) references attachment (attachment_id) on update cascade;

-- changeset chicoreus:28


CREATE TABLE collector (
  -- Definition: The relation of an agent, possibly with additional un-named agents, to a collecting event.
  collectorid bigint not null primary key auto_increment, -- surrogate numeric primary key
  verbatim_collector text,  -- the verbatim transcribed text for the collector 
  collectoragent_id bigint,  -- the agent (individual or group) that has been identified as the collector
  collectingevent_id bigint not null, -- the collecting event in which this collector collected
  etal text, -- unnamed individuals and groups that were part of the collecting team.  examples: and students; and native guide.
  remarks text
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE UNIQUE INDEX idx_colltor_u_agentevent ON collector(collectoragent_id, collectingevent_id);  
CREATE INDEX idx_coltor_eventid ON collector(collectingevent_id);

ALTER TABLE collector add constraint fk_col_collectoragent foreign key (collectoragent_id) references agent (agent_id) on update cascade;
ALTER TABLE collector add constraint fk_col_colevent foreign key (collectingevent_id) references collectingevent (collectingevent_id) on update cascade;

-- changeset chicoreus:29
-- tables supporting coordinates and georeferences

CREATE TABLE ctcoordinatetype ( 
   -- Definition: Controled vocabulary of vocabulary types.
   coordinatetype varchar(50) not null primary key,  -- allowed coordinate types for table coordinate
   fieldprefix varchar(5) not null  -- prefix for field names that apply for this coordinate type
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('utm/ups','utm');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('decimal degrees','ddg');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('degrees minutes seconds','dms');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('degrees decimal minutes','ddm');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('mgrs','grid');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('osgb','grid');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('rikets nät, rt 90','xy');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('swiss grid','xy');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('public land survey system (township section range)','plss');

CREATE TABLE coordinate ( 
   -- Definition: a two dimensional point description of a location in one of several standard forms, allows splitting a verbatim coordinate into atomic parts, intended for retaining information about 
   coordinateid bigint not null primary key auto_increment, -- surrogate numeric primary key  
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

CREATE TABLE georeference (
  -- Definition: a three dimensional description of a location in standard form of decimal degress with elevation and depth, with metadata about the georeference and how it was determined
  georeferenceid bigint not null primary key auto_increment, -- surrogate numeric primary key
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

create unique index idx_georef_u_dategeorefid on georeference(georeference_eventdate_id);  --  Event dates should not be reused.

ALTER TABLE georeference add constraint fk_gr_byagent foreign key (by_agent_id) references agent (agent_id) on update cascade;
ALTER TABLE georeference add constraint fk_gr_geography foreign key (locality_id) references locality (locality_id) on update cascade;
ALTER TABLE georeference add constraint fk_gr_georefdate foreign key (georeference_eventdate_id) references eventdate (eventdate_id) on update cascade;

-- changeset chicoreus:30
-- tables supporting geography

CREATE TABLE geography (
  -- Definition: heriarchically nested higher geographical entities 
  geography_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  name varchar(255) not null,
  fullname varchar(900) default null,
  rank_id int(11) not null,
  parent_id bigint default null,
  parentage varchar(2000) not null, -- the path from the root of the tree to this geography node
  remarks text,
  abbreviation varchar(16) default null,
  centroid_lat decimal(19,2) default null,
  centroid_long decimal(19,2) default null,
  common_name varchar(128) default null,
  geography_code varchar(24) default null,  -- standard code for the geography (e.g. country code, fips code).
  geography_code_type varchar(24) default null, -- which standard code is used for the geography_code.
  guid varchar(128) default null,
  is_accepted boolean not null,  -- is a locally accepted value 
  accepted_id bigint default null,  -- if not accepted, which is the accepted geography entry to use instead.
  is_current boolean default null, -- is a current geopolitical entity 
  geographytreedef_id int(11) not null,  -- which geography tree is this geography placed in 
  geographytreedefitem_id int(11) not null -- which node definition applies to this node.
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

create index idx_geog_name on geography(name);
create index idx_geog_fullname on geography(fullname);

alter table geography add constraint fk_geo_parent_id foreign key (parent_id) references geography (geography_id);
alter table geography add constraint fk_geo_accepted_id foreign key (accepted_id) references geography (geography_id);

CREATE TABLE geographytreedef (
  -- Definition: Definition of a geography tree
  geographytreedef_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  fullname_direction int(11) default null,  -- negative for higher to lower reading right to left, positive for higher to lower reading left to right
  name varchar(64) not null,  -- name of the geographic tree
  remarks text  
) 
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

INSERT INTO geographytreedef (geographytreedef_id,fullname_direction,name) VALUES (1,-1,'geopolitical heirarchy');

CREATE TABLE geographytreedefitem (
  -- Definition: Definition of a node in a geography tree
  geographytreedefitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  full_name_separator varchar(32) default null,
  is_enforced boolean default null,
  is_in_fullname boolean default null,
  name varchar(64) not null,
  rank_id int(11) not null,   
  text_after varchar(64) default null,
  text_before varchar(64) default null,
  title varchar(64) default null,
  geographytreedef_id bigint not null,
  remarks text
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table geographytreedefitem add constraint fk_geogtrdi_treeid foreign key (geographytreedef_id) references geographytreedef(geographytreedef_id) on update cascade;

INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (1,', ',1,0,'root',0,null,null,null,'root',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (2,', ',0,0,'continent',100,null,null,null,'continent',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (3,', ',0,0,'region',150,null,null,null,'region',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (4,', ',0,0,'island group',160,null,null,null,'island group',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (5,', ',0,0,'island',170,null,null,null,'island',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (6,':' ,0,1,'country',200,null,null,null,'country',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (7,', ',0,0,'land',210,null,null,null,'land',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (8,', ',0,0,'territory',220,null,null,null,'territory',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (9,', ',0,0,'subcontinent island(s)',230,null,null,null,'subcontinent island(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (10,', ',0,0,'continent subregion',250,null,null,null,'continent subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (11,', ',0,0,'country subregion',260,null,null,null,'country subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (12,', ',0,0,'straights',270,null,null,null,'straights',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (13,', ',0,0,'subcountry island(s)',280,null,null,null,'subcountry island(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (14,':' ,0,1,'state/province',300,null,null,null,'state/province',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (15,', ',0,0,'peninsula',310,null,null,null,'peninsula',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (16,', ',0,0,'substate island(s)',320,null,null,null,'substate island(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (19,', ',0,0,'state subregion',380,null,null,null,'state subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (20,', ',0,1,'county',400,null,null,null,'county',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (21,', ',0,0,'mountain(s)',410,null,null,null,'mountain(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (22,', ',0,0,'river',420,null,null,null,'river',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (23,', ',0,0,'forest',430,null,null,null,'forest',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (24,', ',0,0,'valley',440,null,null,null,'valley',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (25,', ',0,0,'island(s)',450,null,null,null,'island(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (26,', ',0,0,'hill(s)',460,null,null,null,'hill(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (27,', ',0,0,'canyon',470,null,null,null,'canyon',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (28,', ',0,0,'lake',480,null,null,null,'lake',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (29,', ',0,1,'county subregion',490,null,null,null,'county subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (30,', ',0,1,'muncipality',500,null,null,null,'muncipality',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (31,', ',0,0,'city subregion',510,null,null,null,'city subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (32,':' ,0,1,'ocean',100,null,null,null,'ocean',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (33,':' ,0,1,'ocean region',150,null,null,null,'ocean region',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (34,', ',0,0,'ocean subregion',250,null,null,null,'ocean subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_fullname, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (35,', ',0,0,'exclusive economic zone',260,null,null,null,'maritime eez',1);

alter table locality add constraint fk_local_polgeogid foreign key (geopolitical_geography_id) references geography (geography_id) on update cascade;
alter table locality add constraint fk_local_geogeogid foreign key (geographic_geography_id) references geography (geography_id) on update cascade;

alter table agentgeography add constraint fk_agentgeog_geogid foreign key (geography_id) references geography(geography_id) on update cascade;

-- changeset chicoreus:31

CREATE TABLE collection (
  -- Definition: a managed set of collection objects that corresponds to an entity to which a dwc:collectioncode is assigned
  usergroupscope_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  collection_name varchar(900) default null,
  institution_code varchar(900) default null,  -- dwc:institutionCode
  institution_id varchar(900) default null,  -- dwc:institutionId
  collection_code varchar(900) default null,  -- dwc:collectionCode
  collection_type varchar(32) default null,
  collection_id varchar(900) default null,  -- dwc:collectionId (guid for this collection, if any)
  description text,
  estimated_size int(11) default null,
  estimated_size_units varchar(50) default 'specimens',
  scope_id varchar(900) default null,  -- the scope into which this collection falls 
  remarks text,
  website_iri varchar(255) default null  -- website providing more information about this collection
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

create index idx_coll_name on collection(collection_name);

ALTER TABLE catalogeditem add constraint fk_ci_collection_id foreign key (in_collection_id) references collection(usergroupscope_id);

-- changeset chicoreus:32

-- storage and changes to preparation
CREATE TABLE storagetreedef (
  -- Definition: Definitions for storage trees 
  storagetreedef_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  fullname_direction int(11) default null,
  name varchar(64) not null,
  remarks text,
  disciplineid bigint  -- scope of the tree
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE TABLE storagetreedefitem (
  -- Definition: definition of ranks within a storage heirarchy 
  storagetreedefitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  storagetreedef_id bigint not null,  -- tree for which this is a node
  name varchar(64) not null,
  full_name_separator varchar(32) default null,
  is_enforced boolean default null,  -- if true, then must be present in the path to root for any child node
  is_in_fullname boolean default null,
  rank_id int(11) not null,  -- container rank heirarchy, larger numbers are lower ranks, lower ranks nest in higher ranks
  text_after varchar(64) default null,
  text_before varchar(64) default null,
  remarks text
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

CREATE INDEX idx_stdi_name ON storagetreedefitem(name);
CREATE INDEX idx_stdi_rank ON storagetreedefitem(rank_id);

ALTER TABLE storagetreedefitem add constraint fk_stdi_treeid foreign key (storagetreedef_id) references storagetreedef(storagetreedef_id);

CREATE TABLE storage (
  -- Definition: location where zero or more preparations are stored 
  storage_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  name varchar(64) not null,  -- the name of this storage location
  barcode varchar(900) not null,  -- barcoded identifier of this storage location
  abbreviation varchar(16) not null default '', -- an abbreviated name for this storage location
  rank_id int(11) not null,    -- the rank of this storage.  ? redundant with node definition
  fullname varchar(255) default null,  -- a constructed full name for this storage location built from the rules in the node definition
  parent_id bigint default null, -- the parent node for this tree in the storage heirarchy
  parentage varchar(2000) not null,  -- the list of nodes from this node to the root of the tree, separator is '/', starts with separator, ends with storage_id of current node.  
  scope_id bigint not null,  
  storagetreedefitem_id bigint not null,  -- node definition that applies to this storage 
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

CREATE INDEX idx_storage_parentid ON storage(parent_id);
CREATE INDEX idx_storage_name ON storage(name);
ALTER TABLE storage add constraint fk_stor_parent_id foreign key (parent_id) references storage (storage_id) on update cascade;
ALTER TABLE storage add constraint fk_stor_treeitemdefid foreign key (storagetreedefitem_id) references storagetreedefitem (storagetreedefitem_id) on update cascade;


ALTER TABLE preparation add constraint fk_prep_storage_id foreign key (storage_id) references storage (storage_id) on update cascade;

-- changeset chicoreus:33
-- a model for geological context 

CREATE TABLE geologictimeperiod (
  -- Definition: a geological time, rock, or rock/time unit.
  geologictimeperiod_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  name varchar(64) not null,
  rank_id int(11) not null,  -- the rank 
  parent_id bigint default null,  -- the immediate parent of this node, null for root.
  parentage varchar(2000) not null, -- path from the current node to root
  accepted_id bigint default null,
  fullname varchar(255) default null,
  guid varchar(128) default null,
  remarks text,
  standard varchar(64) default null,
  geologictimeperiodtreedefitem_id int(11) not null  -- the definition for this node 
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table geologictimeperiod add constraint fk_geoltp_parent_id foreign key (parent_id) references geologictimeperiod (geologictimeperiod_id);
alter table geologictimeperiod add constraint fk_geoltp_accepted_id foreign key (accepted_id) references geologictimeperiod (geologictimeperiod_id);

CREATE TABLE geologictimeperiodtreedef (
  -- Definition: geologic rock/time unit trees
  geologictimeperiodtreedef_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  fullname_direction int(11) default null, -- assembly order for full name, negative for high to low as left to right.
  name varchar(64) not null,  -- name 
  remarks text
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

CREATE UNIQUE INDEX idx_geotimpertdef_u_name ON geologictimeperiodtreedef (name);

INSERT INTO geologictimeperiodtreedef (geologictimeperiodtreedef_id,fullname_direction,name) VALUES (1,-1,"Geochronologic tree");

INSERT INTO geologictimeperiodtreedef (geologictimeperiodtreedef_id,fullname_direction,name) VALUES (2,-1,"Lithostratigraphic tree");

CREATE TABLE geologictimeperiodtreedefitem (
  -- Definition: a definition of a rank in a geologic rock/time unit tree
  geologictimeperiodtreedefitem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
  name varchar(64) not null,  -- name for this rank 
  rank_id int(11) not null, -- rank for this name in the tree, larger numbers are lower ranks.
  full_name_separator varchar(32) not null default ':',
  is_enforced boolean not null default 0, -- if true, then this rank must be present in the path from any lower node to root.
  is_in_fullname boolean not null default 1, -- include this element when assembling full name 
  text_after varchar(64) default null,  -- text to place after the name of a node at this rank when assembling the name
  text_before varchar(64) default null, -- text to place before the name of a node at this rank when assembling the name
  geologictimeperiodtreedef_id int(11) not null,
  remarks text  -- remarks concerning the item definition
) 
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

-- Ranks in geochronologic (geological time, rather than chronostratigraphic rock/time) heirarchy
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (1,1,':',0,'Eon',100);
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (2,1,':',1,'Era',200);
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (3,1,':',1,'Period',300);
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (4,1,':',1,'Epoch',400); -- e.g.  If not named (e.g. Llandovery), uses time related Early/Middle/Late divisions of Period, e.g.  Late Devonian (not position terms, e.g. not Upper Devonian).
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (5,1,':',1,'Age',500);
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (6,1,':',1,'Subage',500);

-- Ranks in Lithostratigraphic heirarchy
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (100, 2,':',0,'Supergroup',100);
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (101, 2,':',0,'Group',200);  
-- Could include subgroup, but it is quite uncommon.
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (102, 2,':',0,'Formation',300);
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (103, 2,':',0,'Member',400);
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (104, 2,':',0,'Bed',500);
insert into geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_fullname,name,rank_id) values (105, 2,':',0,'Flow',500);  -- for named volcanic flows

CREATE TABLE paleocontext (
  -- Definition: a geological context from which some material was collected 
  paleocontext_id bigint NOT NULL primary key AUTO_INCREMENT,
  paleocontext_name varchar(80) DEFAULT NULL,  -- incase context is named
  verbatim_geologic_context varchar(900) not null default '',
  verbatim_lithology varchar(900) not null default '',  -- verbatim description of the lithology 
  lithology varchar(255) default null,  -- lithology using a controled vocabulary
  biostratigraphic_unit varchar(255) default null,  -- Biostratigraphic unit for this paleocontext: superzone, biozone, subzone, or biohorizion, or historically zonule.
  is_float enum ('Yes','No','Unknown') default 'Unknown',  -- sample was collected as float on the surface and may come from elsewhere in the section
  measured_location_in_section varchar(900) not null default '',  -- description of the measured location in the section at which the material was collected.
  remarks text,
  earlyest_geochronologic_unit_id bigint DEFAULT NULL, -- earlest geochronlological unit for this paleocontext
  latest_geochronologic_unit_id bigint DEFAULT NULL,   -- latest geochronological unit for this paleocontext
  lithostratigraphic_unit_id bigint DEFAULT NULL  -- lithological unit for paleocontext 
)
ENGINE=InnoDB 
DEFAULT CHARSET=utf8;

alter table paleocontext add constraint fk_paleoctx_earlgeounit foreign key (earlyest_geochronologic_unit_id) references geologictimeperiod (geologictimeperiod_id) on update cascade;
alter table paleocontext add constraint fk_paleoctx_latgeounit foreign key (latest_geochronologic_unit_id) references geologictimeperiod (geologictimeperiod_id) on update cascade;
alter table paleocontext add constraint fk_paleoctx_lithunit foreign key (lithostratigraphic_unit_id) references geologictimeperiod (geologictimeperiod_id) on update cascade;


alter table locality add constraint fk_local_paleocontext foreign key (paleocontext_id) references paleocontext (paleocontext_id) on update cascade;
alter table collectingevent add constraint fk_colev_paleoid foreign key (paleocontext_id) references paleocontext(paleocontext_id) on update cascade;


-- changeset chicoreus:34
-- additional accumulated foreign key constraints

alter table collectingevent add constraint fk_colev_localityid foreign key (locality_id) references locality(locality_id) on update cascade;
alter table collectingevent add constraint fk_colev_eventdateid foreign key (date_collected_eventdate_id) references eventdate(eventdate_id) on update cascade;

create unique index idx_sysuser_u_useragentid on systemuser(user_agent_id);

insert into agent(agent_id, preferred_name_string) values (0,'example');
alter table systemuser add constraint fk_sysuser_useragentid foreign key (user_agent_id) references agent (agent_id) on update cascade;
-- each systemuser is one and only one agent
-- each agent is also zero or one systemuser

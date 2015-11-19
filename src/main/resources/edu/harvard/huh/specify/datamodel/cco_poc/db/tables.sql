--liquibase formatted sql

--changeset chicoreus:1
create table unit (
  -- Definition: Logical unit that was collected or observed in a collecting event.
  unit_id bigint not null primary key auto_increment,
  field_number varchar(255),  -- number assigned by the collector to this collection at the collecting event
  material_sample_id bigint,
  verbatim_collection_description text,
  collecting_event_id bigint,
  unit_remarks text
);  

--changeset chicoreus:2
create table identifiable_item (
  -- Definition: A component of a unit for which a scientific identification can be made.
  identifiable_item_id bigint not null primary key auto_increment,
  occurrenceId varchar(900),
  unit_id bigint not null,
  preparation_id big int not null,  -- allow nulls if including unvouchered observational data
  cataloged_item_id bigint,
  individual_count int,
  individual_count_modifier varchar(50),  -- e.g. +
  individual_count_units varchar(50)      -- e.g. valves
);

--changeset chicoreus:3
create table preparation (
  -- Definition: A physical artifact that could participate in a transaction, e.g. be sent in a loan.
  -- Note: Does not specify preparation history or conservation history, additional entities are needed for these.
  preparation_id bigint not null primary key auto_increment,
  cataloged_item_id bigint,
  material_sample_id bigint,
  preparation_type varchar(50),
  preservation_type varchar(50),
  conservation_status varchar(255),
  parent_preparation_id bigint,
  preparation_remarks bigint,
  remarks text
);

alter table preparation add constraint fk_parentprep foreign key (parent_preparation_id) references preparation (preparation_id) on update cascade; 

-- add constraint, a preparation for which parent_preparation_id is not null is not allowed to have it's preparation_id present as the parent_preparation_id of any preparation.  Needs a trigger.

delimiter //
create triger tr_prep_const before update on preparation
for each row 
begin
   IF NEW.parent_id is not null THEN
      select count(*) from preparation where parent_id = NEW.taxon_id into childcount
      IF  childcount > 0 
         SIGNAL sqlstate '45001' set message_text = "A preparation which is a child cannot itself have children."
      ENDIF;
   ENDIF;
end;//
delimiter ;

--changeset chicoreus:4
alter table identifiable_item add constraint fk_colobj foreign key (unit_id) references unit (unit_id) on update cascade;
alter table identifiable_item add constraint fk_prep foreign key (preparation_id) references preparation (preparation_id) on update cascade;

--changeset chicoreus:5
create table identification
  -- Definition: The application of a scientific name by some agent at some point in time to an identifiable item.
  identification_id bigint not null primary key auto_increment,
  identifiable_item_id bigint not null,
  taxon_id bigint not null,
  determiner_agent_id bigint,
  date_determined_event_date_id bigint,  
  type_status varchar(50),
  verifier bigint,
  date_verified_event_date_id bigint, 
  verbatim_annotation_text text
);

--changeset chicoreus:6
create table taxon (
   -- Definition: A scientific name string that may be curated to be linked to a nomeclatural act
   taxon_id bigint not null primary key auto_increment,
   scientificName varchar(900) not null,
   authorship varchar(900) not null,
   parent_taxon_id bigint,
   rankid int,
   status varchar(50),
   accepted_taxon_id bigint,
   nomenclator_guid varchar(900),  
   curated boolean default false,
   author_agent_id bigint,    -- zoological and botanical
   parauthor_agent_id bigint, -- zoological and botanical
   exauthor_agent_id bigint,  -- botanical
   parexauthor_agent_id bigint,  -- botanical
   sanctauthor_agent_id bigint,  -- botanical (fungal)
   parsanctauthor_agent_id bigint,  -- botanical (fungal)
   cited_in_agent_id bigint,  -- zoological and botanical
   publication_id bigint,
   remarks text
);

--changeset chicoreus:7
alter table identification add constraint fk_idtaxon foreign key (taxon_id) references taxon (taxon_id) on update cascade;
alter table taxon add constraint fk_idparent foreign key (parent_taxon_id) references taxon (taxon_id) on update cascade;
alter table taxon add constraint fk_idaccepted foreign key (accepted_taxon_id) references taxon (taxon_id) on update cascade;

--changeset chicoreus:8
create table cataloged_item (
   -- Definition: The application of a catalog number out of some catalog number series.
   cataloged_item_id bigint not null primary key auto_increment,
   catalog_number_series_id bigint not null,
   catalog_number varchar(255) not null,
   date_cataloged_event_date_id bigint,
   cataloger_agent_id bigint
); 

--changeset chicoreus:9
create table material_sample(
   -- Definition: See DarwinCore.
   material_sample_id bigint not null primary key auto_increment,
   guid varchar(255) not null,
   sample_number varchar(255),
   date_sampled_event_date_id bigint,
   sampled_by_agent_id bigint
); 

--changeset chicoreus:10
create table catalog_number_series ( 
   -- Definition: A sequence of numbers of codes assigned as catalog numbers to material held in a natural science collection.
   -- Note: This entity is not fully normalized.  
   catalog_number_series_id bigint not null primary key auto_increment,
   name varchar(900),
   institution varchar(900),  
   institution_code varchar(900),
   collection varchar(900),
   collection_code varchar(900),
   dataset varchar(900),
   dataset_id varchar(900),
   remarks text
);

--changeset chicoreus:11
create table collecting_event (
   -- Definition: An event in which an occurrance was observed in the wild, and typically, for a natural science collection, a voucher was collected.
   collecting_event_id bigint not null primary key auto_increment,
   datecollected_event_date_id big int, 
   collector_number varchar(255),  -- number assigned by the collector to this collecting event
   locality_id bigint,
   collecting_method varchar(255)
);

--changeset chicoreus:12
alter table collection_object add constraint fk_colevent foreign key (collecting_event_id) references collecting_event (collecting_event_id) on update cascade;

--changeset chicoreus:13
create table event_date ( 
   -- Definition: A span of time in which some event occurred.
   event_date_id bigint not null primary key auto_increment,
   verbatim_date varchar(255),
   iso_date varchar(255) not null,
   start_date date,
   start_date_precision int,
   end_date date,
   end_date_precision int,
   start_end_fully_specifies boolean default true -- true if a single date or a continuous range.
);

--changeset chicoreus:14
create table locality ( 
   -- Definition: A place.  
   -- Note: Table is only minimally specified.  
   locality_id bigint not null primary key auto_increment,
   verbatim_locality varchar(900)
);

--changeset chicoreus:15
alter table collecting_event add constraint fk_locality foreign key (locality_id) references locality (locality_id) on update cascade;

--changeset chicoreus:16
create table other_number (
   --  Definition: A number or code associated with a specimen that is not known to be its catalog number
   other_number_id bigint not null primary key auto_increment,
   targettable varchar(255) not null,  -- The table to which pk refers to the primary key.
   pk bigint not null,                 -- The surrogate numeric primary key of a row in targettable.
   number_type varchar(255) not null,  -- The type of other number (which may be unknown)
   number_value varchar(255) not null  -- The value of the other number
);
 
--changeset chicoreus:17
alter table other_number add unique index idx_tablepk on other_number(targettable, pk);

--changeset chicoreus:18
create table transaction_item (
   -- Definition:  The participation of a preparation in a transaction (e.g. a loan).
   -- Note: Table is only minimally specified.
   transaction_item_id bigint not null primary key auto_increment,
   trans_preparation_id bigint, -- can be null to allow for transactions of non-cataloged items
   item_count int,
   item_count_modifier varchar(50),
   item_count_units varchar(50),
   description varchar(900),
   item_conditions text,  -- conditions applied to this item in this transaction, e.g. no destructive sampling
   disposition varchar(50)
)

--changeset chicoreus:19
create table col_transaction (
   -- Definition: A record of the movement of a set of specimens in or out of a collection, e.g. loan, accession, outgoing gift, deaccession, borrow.
   -- Note: Table is only minimally specified.
   col_transaction_id bigint not null primary key auto_increment,
   trans_number varchar(50) not null,
   trans_number_series varchar(50) not null,
   trans_type varchar(50),
   status varchar(50),
   conditions text
);

--changeset chicoreus:20
create table agent (
    -- Definition: a person or organization with some role related to natural science collections.
    -- Note: Not fully specified.
    agent_id bigint not null primary key auto_increment,
    agent_type varchar(50),
    curated boolean not null default false
);

--changeset chicoreus:21
alter table cataloged_item add constraint foreign key fk_catagent (cataloger_agent_id) references agent (agent_id) on update cascade;
alter table taxon add constraint foreign key fk_authagent (author_agent_id) references agent (agent_id) on update cascade;
alter table taxon add constraint foreign key fk_parauthagent (parauthor_agent_id) references agent (agent_id) on update cascade;
alter table taxon add constraint foreign key fk_exauthagent (exauthor_agent_id) references agent (agent_id) on update cascade;
alter table taxon add constraint foreign key fk_parexauthagent (parexauthor_agent_id) references agent (agent_id) on update cascade;
alter table taxon add constraint foreign key fk_sanctauthagent (sanctauthor_agent_id) references agent (agent_id) on update cascade;
alter table taxon add constraint foreign key fk_parsaauthagent (parsanctauthor_agent_id) references agent (agent_id) on update cascade;
alter table taxon add constraint foreign key fk_citauthagent (citedinauthor_agent_id) references agent (agent_id) on update cascade;

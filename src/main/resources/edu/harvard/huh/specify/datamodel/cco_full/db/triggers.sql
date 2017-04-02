-- liquibase formatted sql

-- changeset chicoreus:158 dbms:none
delimiter |
-- changeset chicoreus:158 endDelimiter:\| dbms:mysql

--  TODO: Fill in trigger logic to write data to the audit log.
--  TODO: add auditlog.dbusername and add lastmodifiedagentid to tables to obtain agent_id for audit log.

create trigger trg_scope_update after update on scope 
  for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'scope',NEW.scope_id);
    end |
 create trigger trg_principal_update after update on  principal 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'principal',NEW.principal_id);
    end |
 create trigger trg_systemuser_update after update on  systemuser 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'systemuser',NEW.systemuser_id);
    end | 
 create trigger trg_systemuserprincipal_update after update on  systemuserprincipal 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'systemuserprincipal',NEW.systemuserprincipal_id);
    end |
 create trigger trg_picklist_update after update on  picklist 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'picklist',NEW.picklist_id);
    end |
 create trigger trg_picklistitem_update after update on  picklistitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'picklistitem',NEW.picklistitem_id);
    end |
 create trigger trg_picklistitemint_update after update on  picklistitemint 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'picklistitemint',NEW.picklistitemint_id);
    end |
 create trigger trg_codetableint_update after update on  codetableint 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'codetableint',NEW.codetableint_id);
    end | 
 create trigger trg_unit_update after update on  unit 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'unit',NEW.unit_id);
    end |
 create trigger trg_identifiableitem_update after update on  identifiableitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'identifiableitem',NEW.identifiableitem_id);
    end |
 create trigger trg_biologicalindividual_update after update on  biologicalindividual 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'biologicalindividual',NEW.biologicalindividual_id);
    end |
 create trigger trg_preparation_update after update on  preparation 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'preparation',NEW.preparation_id);
    end |
 create trigger trg_part_update after update on  part 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'part',NEW.part_id);
    end |
 create trigger trg_identification_update after update on  identification 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'identification',NEW.identification_id);
    end |
 create trigger trg_taxon_update after update on  taxon 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'taxon',NEW.taxon_id);
    end |
 create trigger trg_taxon_bupdate before update on  taxon 
   for each row 
    begin 
      -- Find the parentage of the new parent, append the parent_id of the current node.
    if NEW.parent_id is not null then 
        set NEW.parentage = replace(concat(cco_full.getTaxonParentage(NEW.parent_id),'/',NEW.parent_id),'//','/');
    else
        set NEW.parentage = '/';
    end if;
    end |
 create trigger trg_taxontreedef_update after update on  taxontreedef 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'taxontreedef',NEW.taxontreedef_id);
    end |
 create trigger trg_taxontreedefitem_update after update on  taxontreedefitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'taxontreedefitem',NEW.taxontreedefitem_id);
    end |
 create trigger trg_journal_update after update on  journal 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'journal',NEW.journal_id);
    end |
 create trigger trg_journaltitle_update after update on  journaltitle 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'journaltitle',NEW.journaltitle_id);
    end |
 create trigger trg_journalidentifier_update after update on  journalidentifier 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'journalidentifier',NEW.journalidentifier_id);
    end |
 create trigger trg_publication_update after update on  publication 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'publication',NEW.publication_id);
    end |
 create trigger trg_author_update after update on  author 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'author',NEW.author_id);
    end |
 create trigger trg_catalogeditem_update after update on  catalogeditem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'catalogeditem',NEW.catalogeditem_id);
    end |
 create trigger trg_materialsample_update after update on  materialsample
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'materialsample',NEW.materialsample_id);
    end |
 create trigger trg_catalognumberseries_update after update on  catalognumberseries 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'catalognumberseries',NEW.catalognumberseries_id);
    end | 
 create trigger trg_collectingevent_update after update on  collectingevent 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'collectingevent',NEW.collectingevent_id);
    end |
 create trigger trg_eventdate_update after update on  eventdate 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'eventdate',NEW.eventdate_id);
    end | 
 create trigger trg_locality_update after update on  locality 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'locality',NEW.locality_id);
    end |
 create trigger trg_othernumber_update after update on  othernumber 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'othernumber',NEW.othernumber_id);
    end |
 create trigger trg_transactionitem_update after update on  transactionitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'transactionitem',NEW.transactionitem_id);
    end |
 create trigger trg_transactionc_update after update on  transactionc 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'transactionc',NEW.transactionc_id);
    end |
 create trigger trg_loan_update after update on  loan 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'loan',NEW.loan_id);
    end |
 create trigger trg_gift_update after update on  gift 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'gift',NEW.gift_id);
    end |
 create trigger trg_borrow_update after update on  borrow 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'borrow',NEW.borrow_id);
    end |
 create trigger trg_deaccession_update after update on  deaccession 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'deaccession',NEW.deaccession_id);
    end |
 create trigger trg_transactionagent_update after update on  transactionagent 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'transactionagent',NEW.transactionagent_id);
    end |
 create trigger trg_agent_update after update on  agent 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'agent',NEW.agent_id);
    end |
 create trigger trg_ctrelationshiptype_update after update on  ctrelationshiptype 
   for each row 
    begin 
      insert into auditlogvarchar(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'ctrelationshiptype',NEW.relationship);
    end |
 create trigger trg_agentteam_update after update on  agentteam 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'agentteam',NEW.agentteam_id);
    end |
 create trigger trg_agentnumberpattern_update after update on  agentnumberpattern 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'agentnumberpattern',NEW.agentnumberpattern_id);
    end |
 create trigger trg_agentreference_update after update on  agentreference 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'agentreference',NEW.agentreference_id);
    end |
 create trigger trg_agentlink_update after update on  agentlink 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'agentlink',NEW.agentlink_id);
    end |
 create trigger trg_agentname_update after update on  agentname 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'agentname',NEW.agentname_id);
    end |
 create trigger trg_agentrelation_update after update on  agentrelation 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'agentrelation',NEW.agentrelation_id);
    end |
 create trigger trg_agentgeography_update after update on  agentgeography 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'agentgeography',NEW.agentgeography_id);
    end |
 create trigger trg_agentspeciality_update after update on  agentspeciality 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'agentspeciality',NEW.agentspeciality_id);
    end |
 create trigger trg_cttextattributetype_update after update on  cttextattributetype 
   for each row 
    begin 
      insert into auditlogvarchar(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'cttextattributetype',NEW.key_name);
    end |
 create trigger trg_textattribute_update after update on  textattribute 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'textattribute',NEW.textattribute_id);
    end |
 create trigger trg_inference_update after update on  inference 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'inference',NEW.inference_id);
    end |
 create trigger trg_ctnumericattributetype_update after update on  ctnumericattributetype 
   for each row 
    begin 
      insert into auditlogvarchar(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'ctnumericattributetype',NEW.name);
    end |
 create trigger trg_numericattribute_update after update on  numericattribute 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'numericattribute',NEW.numericattribute_id);
    end |
-- TODO: non numeric primary key
-- create trigger trg_ctbiologicalattributetype_update after update on  ctbiologicalattributetype 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'ctbiologicalattributetype',NEW.ctbiologicalattributetype_id);
--    end |
-- create trigger trg_ctlengthunit_update after update on  ctlengthunit 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'ctlengthunit',NEW.ctlengthunit_id);
--    end |
-- create trigger trg_ctmassunit_update after update on  ctmassunit 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'ctmassunit',NEW.ctmassunit_id);
--    end |
-- create trigger trg_ctageclass_update after update on  ctageclass 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'ctageclass',NEW.ctageclass_id);
--    end |
 create trigger trg_scopect_update after update on  scopect 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'scopect',NEW.scopect_id);
    end |
 create trigger trg_biologicalattribute_update after update on  biologicalattribute 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'biologicalattribute',NEW.biologicalattribute_id);
      -- TODO: one and only one of identifiableitem_id and part_id must be not_null.
    end |
-- create trigger trg_ctencumberancetype_update after update on  ctencumberancetype 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'ctencumberancetype',NEW.ctencumberancetype_id);
--    end | 
 create trigger trg_encumberance_update after update on  encumberance 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'encumberance',NEW.encumberance_id);
    end |
 create trigger trg_catitemencumberance_update after update on  catitemencumberance 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'catitemencumberance',NEW.catitemencumberance_id);
    end | 
 create trigger trg_attachmentencumberance_update after update on  attachmentencumberance 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'attachmentencumberance',NEW.attachmentencumberance_id);
    end | 
 create trigger trg_localityencumberance_update after update on  localityencumberance 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'localityencumberance',NEW.localityencumberance_id);
    end | 
 create trigger trg_taxonencumberance_update after update on  taxonencumberance 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'taxonencumberance',NEW.taxonencumberance_id);
    end | 
 create trigger trg_address_update after update on  address 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'address',NEW.address_id);
    end |
-- create trigger trg_ctelectronicaddresstype_update after update on  ctelectronicaddresstype 
--   for each row 
--    begin 
--     insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'ctelectronicaddresstype',NEW.ctelectronicaddresstype_id);
--    end | 
 create trigger trg_electronicaddress_update after update on  electronicaddress 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'electronicaddress',NEW.electronicaddress_id);
    end | 
 create trigger trg_addressofrecord_update after update on  addressofrecord 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'addressofrecord',NEW.addressofrecord_id);
    end |
 create trigger trg_accession_update after update on  accession 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'accession',NEW.accession_id);
    end |
 create trigger trg_repositoryagreement_update after update on  repositoryagreement 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'repositoryagreement',NEW.repositoryagreement_id);
    end |
 create trigger trg_accessionagent_update after update on  accessionagent 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'accessionagent',NEW.accessionagent_id);
    end |
 create trigger trg_attachment_update after update on  attachment 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'attachment',NEW.attachment_id);
    end |
 create trigger trg_attachmentrelation_update after update on  attachmentrelation 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'attachmentrelation',NEW.attachmentrelation_id);
    end |
 create trigger trg_collector_update after update on  collector 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'collector',NEW.collector_id);
    end |
-- create trigger trg_ctcoordinatetype_update after update on  ctcoordinatetype 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'ctcoordinatetype',NEW.ctcoordinatetype_id);
--    end | 
 create trigger trg_coordinate_update after update on  coordinate 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'coordinate',NEW.coordinate_id);
    end | 
 create trigger trg_georeference_update after update on  georeference 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),null,'georeference',NEW.georeference_id);
    end |
 create trigger trg_geography_update after update on  geography 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'geography',NEW.geography_id);
    end |
 create trigger trg_geography_bupdate before update on  geography
   for each row 
    begin 
      if NEW.parent_id is not null then 
         set NEW.parentage = concat(cco_full.getGeogParentage(NEW.parent_id),'/',NEW.parent_id);
      else 
         set NEW.parentage = '/';
      end if;
    end |
 create trigger trg_geographytreedef_update after update on  geographytreedef 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'geographytreedef',NEW.geographytreedef_id);
    end |
 create trigger trg_geographytreedefitem_update after update on  geographytreedefitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'geographytreedefitem',NEW.geographytreedefitem_id);
    end |
 create trigger trg_collection_update after update on  collection 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'collection',NEW.collection_id);
    end |
 create trigger trg_storagetreedef_update after update on  storagetreedef 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'storagetreedef',NEW.storagetreedef_id);
    end |
 create trigger trg_storagetreedefitem_update after update on  storagetreedefitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'storagetreedefitem',NEW.storagetreedefitem_id);
    end |
 create trigger trg_storage_update after update on  storage 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'storage',NEW.storage_id);
    end |
 create trigger trg_storage_bupdate before update on  storage
   for each row 
    begin 
      -- Find the parentage of the new parent, append the parent_id of the current node.
    if NEW.parent_id is not null then 
        set NEW.parentage = replace(concat(cco_full.getStorageParentage(NEW.parent_id),'/',NEW.parent_id),'//','/');
    else
        set NEW.parentage = '/';
    end if;
    end |
 create trigger trg_rocktimeunit_update after update on  rocktimeunit 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'rocktimeunit',NEW.rocktimeunit_id);
    end |
 create trigger trg_rocktimeunit_bupdate before update on  rocktimeunit
   for each row 
    begin 
      -- Find the parentage of the new parent, append the parent_id of the current node.
    if NEW.parent_id is not null then 
        set NEW.parentage = replace(concat(cco_full.getRockTimeParentage(NEW.parent_id),'/',NEW.parent_id),'//','/');
    else
        set NEW.parentage = '/';
    end if;
    end |
 create trigger trg_rocktimeunittreedef_update after update on  rocktimeunittreedef 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'rocktimeunittreedef',NEW.rocktimeunittreedef_id);
    end |
 create trigger trg_rocktimeunittreedefitem_update after update on  rocktimeunittreedefitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'rocktimeunittreedefitem',NEW.rocktimeunittreedefitem_id);
    end |
 create trigger trg_paleocontext_update after update on  paleocontext 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('update',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'paleocontext',NEW.paleocontext_id);
    end | 

-- End after update triggers

-- After insert triggers 

create trigger trg_scope_insert after insert on scope 
  for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'scope',NEW.scope_id);
    end |
 create trigger trg_principal_insert after insert on  principal 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'principal',NEW.principal_id);
    end |
 create trigger trg_systemuser_insert after insert on  systemuser 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'systemuser',NEW.systemuser_id);
    end | 
 create trigger trg_systemuserprincipal_insert after insert on  systemuserprincipal 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'systemuserprincipal',NEW.systemuserprincipal_id);
    end |
 create trigger trg_picklist_insert after insert on  picklist 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'picklist',NEW.picklist_id);
    end |
 create trigger trg_picklistitem_insert after insert on  picklistitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'picklistitem',NEW.picklistitem_id);
    end |
 create trigger trg_picklistitemint_insert after insert on  picklistitemint 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'picklistitemint',NEW.picklistitemint_id);
    end |
 create trigger trg_codetableint_insert after insert on  codetableint 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'codetableint',NEW.codetableint_id);
    end | 
 create trigger trg_unit_insert after insert on  unit 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'unit',NEW.unit_id);
    end |
 create trigger trg_identifiableitem_insert after insert on  identifiableitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'identifiableitem',NEW.identifiableitem_id);
    end |
 create trigger trg_biologicalindividual_insert after insert on  biologicalindividual 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'biologicalindividual',NEW.biologicalindividual_id);
    end |
 create trigger trg_preparation_insert after insert on  preparation 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'preparation',NEW.preparation_id);
    end |
 create trigger trg_part_insert after insert on  part 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'part',NEW.part_id);
    end |
 create trigger trg_identification_insert after insert on  identification 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'identification',NEW.identification_id);
    end |
 create trigger trg_taxon_insert after insert on  taxon 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'taxon',NEW.taxon_id);
    end |
 create trigger trg_taxon_binsert before insert on  taxon 
   for each row 
    begin 
      -- Find the parentage of the new parent.
      if NEW.parent_id is not null then
         set NEW.parentage = replace(concat(cco_full.getTaxonParentage(NEW.parent_id),'/',NEW.parent_id),'//','/');
      else 
         set NEW.parentage = '/';
      end if;
    end |
 create trigger trg_taxontreedef_insert after insert on  taxontreedef 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'taxontreedef',NEW.taxontreedef_id);
    end |
 create trigger trg_taxontreedefitem_insert after insert on  taxontreedefitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'taxontreedefitem',NEW.taxontreedefitem_id);
    end |
 create trigger trg_journal_insert after insert on  journal 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'journal',NEW.journal_id);
    end |
 create trigger trg_journaltitle_insert after insert on  journaltitle 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'journaltitle',NEW.journaltitle_id);
    end |
 create trigger trg_journalidentifier_insert after insert on  journalidentifier 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'journalidentifier',NEW.journalidentifier_id);
    end |
 create trigger trg_publication_insert after insert on  publication 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'publication',NEW.publication_id);
    end |
 create trigger trg_author_insert after insert on  author 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'author',NEW.author_id);
    end |
 create trigger trg_catalogeditem_insert after insert on  catalogeditem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'catalogeditem',NEW.catalogeditem_id);
    end |
 create trigger trg_materialsample_insert after insert on  materialsample
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'materialsample',NEW.materialsample_id);
    end |
 create trigger trg_catalognumberseries_insert after insert on  catalognumberseries 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'catalognumberseries',NEW.catalognumberseries_id);
    end | 
 create trigger trg_collectingevent_insert after insert on  collectingevent 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'collectingevent',NEW.collectingevent_id);
    end |
 create trigger trg_eventdate_insert after insert on  eventdate 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'eventdate',NEW.eventdate_id);
    end | 
 create trigger trg_locality_insert after insert on  locality 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'locality',NEW.locality_id);
    end |
 create trigger trg_othernumber_insert after insert on  othernumber 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'othernumber',NEW.othernumber_id);
    end |
 create trigger trg_transactionitem_insert after insert on  transactionitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'transactionitem',NEW.transactionitem_id);
    end |
 create trigger trg_transactionc_insert after insert on  transactionc 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'transactionc',NEW.transactionc_id);
    end |
 create trigger trg_loan_insert after insert on  loan 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'loan',NEW.loan_id);
    end |
 create trigger trg_gift_insert after insert on  gift 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'gift',NEW.gift_id);
    end |
 create trigger trg_borrow_insert after insert on  borrow 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'borrow',NEW.borrow_id);
    end |
 create trigger trg_deaccession_insert after insert on  deaccession 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'deaccession',NEW.deaccession_id);
    end |
 create trigger trg_transactionagent_insert after insert on  transactionagent 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'transactionagent',NEW.transactionagent_id);
    end |
 create trigger trg_agent_insert after insert on  agent 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'agent',NEW.agent_id);
    end |
 create trigger trg_ctrelationshiptype_insert after insert on  ctrelationshiptype 
   for each row 
    begin 
      insert into auditlogvarchar(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'ctrelationshiptype',NEW.relationship);
    end |
 create trigger trg_agentteam_insert after insert on  agentteam 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'agentteam',NEW.agentteam_id);
    end |
 create trigger trg_agentnumberpattern_insert after insert on  agentnumberpattern 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'agentnumberpattern',NEW.agentnumberpattern_id);
    end |
 create trigger trg_agentreference_insert after insert on  agentreference 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'agentreference',NEW.agentreference_id);
    end |
 create trigger trg_agentlink_insert after insert on  agentlink 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'agentlink',NEW.agentlink_id);
    end |
 create trigger trg_agentname_insert after insert on  agentname 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'agentname',NEW.agentname_id);
    end |
 create trigger trg_agentrelation_insert after insert on  agentrelation 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'agentrelation',NEW.agentrelation_id);
    end |
 create trigger trg_agentgeography_insert after insert on  agentgeography 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'agentgeography',NEW.agentgeography_id);
    end |
 create trigger trg_agentspeciality_insert after insert on  agentspeciality 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'agentspeciality',NEW.agentspeciality_id);
    end |
 create trigger trg_cttextattributetype_insert after insert on  cttextattributetype 
   for each row 
    begin 
      insert into auditlogvarchar(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'cttextattributeype',NEW.key_name);
    end |
 create trigger trg_textattribute_insert after insert on  textattribute 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'textattribute',NEW.textattribute_id);
    end |
 create trigger trg_inference_insert after insert on  inference 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'inference',NEW.inference_id);
    end |
 create trigger trg_ctnumericattributetype_insert after insert on  ctnumericattributetype 
   for each row 
    begin 
      insert into auditlogvarchar(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'ctnumericattributeype',NEW.name);
    end |
 create trigger trg_numericattribute_insert after insert on  numericattribute 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'numericattribute',NEW.numericattribute_id);
    end |
-- TODO: non numeric primary key
-- create trigger trg_ctbiologicalattributetype_insert after insert on  ctbiologicalattributetype 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'ctbiologicalattributetype',NEW.ctbiologicalattributetype_id);
--    end |
-- create trigger trg_ctlengthunit_insert after insert on  ctlengthunit 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'ctlengthunit',NEW.ctlengthunit_id);
--    end |
-- create trigger trg_ctmassunit_insert after insert on  ctmassunit 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'ctmassunit',NEW.ctmassunit_id);
--    end |
-- create trigger trg_ctageclass_insert after insert on  ctageclass 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'ctageclass',NEW.ctageclass_id);
--    end |
 create trigger trg_scopect_insert after insert on  scopect 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'scopect',NEW.scopect_id);
    end |
 create trigger trg_biologicalattribute_insert after insert on  biologicalattribute 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'biologicalattribute',NEW.biologicalattribute_id);
      -- TODO: one and only one of identifiableitem_id and part_id must be not_null.
    end |
-- create trigger trg_ctencumberancetype_insert after insert on  ctencumberancetype 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'ctencumberancetype',NEW.ctencumberancetype_id);
--    end | 
 create trigger trg_encumberance_insert after insert on  encumberance 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'encumberance',NEW.encumberance_id);
    end |
 create trigger trg_catitemencumberance_insert after insert on  catitemencumberance 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'catitemencumberance',NEW.catitemencumberance_id);
    end | 
 create trigger trg_attachmentencumberance_insert after insert on  attachmentencumberance 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'attachmentencumberance',NEW.attachmentencumberance_id);
    end | 
 create trigger trg_localityencumberance_insert after insert on  localityencumberance 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'localityencumberance',NEW.localityencumberance_id);
    end | 
 create trigger trg_taxonencumberance_insert after insert on  taxonencumberance 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'taxonencumberance',NEW.taxonencumberance_id);
    end | 
 create trigger trg_address_insert after insert on  address 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'address',NEW.address_id);
    end |
-- create trigger trg_ctelectronicaddresstype_insert after insert on  ctelectronicaddresstype 
--   for each row 
--    begin 
--     insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'ctelectronicaddresstype',NEW.ctelectronicaddresstype_id);
--    end | 
 create trigger trg_electronicaddress_insert after insert on  electronicaddress 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'electronicaddress',NEW.electronicaddress_id);
    end | 
 create trigger trg_addressofrecord_insert after insert on  addressofrecord 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'addressofrecord',NEW.addressofrecord_id);
    end |
 create trigger trg_accession_insert after insert on  accession 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'accession',NEW.accession_id);
    end |
 create trigger trg_repositoryagreement_insert after insert on  repositoryagreement 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'repositoryagreement',NEW.repositoryagreement_id);
    end |
 create trigger trg_accessionagent_insert after insert on  accessionagent 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'accessionagent',NEW.accessionagent_id);
    end |
 create trigger trg_attachment_insert after insert on  attachment 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'attachment',NEW.attachment_id);
    end |
 create trigger trg_attachmentrelation_insert after insert on  attachmentrelation 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'attachmentrelation',NEW.attachmentrelation_id);
    end |
 create trigger trg_collector_insert after insert on  collector 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'collector',NEW.collector_id);
    end |
-- create trigger trg_ctcoordinatetype_insert after insert on  ctcoordinatetype 
--   for each row 
--    begin 
--      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'ctcoordinatetype',NEW.ctcoordinatetype_id);
--    end | 
 create trigger trg_coordinate_insert after insert on  coordinate 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'coordinate',NEW.coordinate_id);
    end | 
 create trigger trg_georeference_insert after insert on  georeference 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),null,'georeference',NEW.georeference_id);
    end |
 create trigger trg_geography_insert after insert on  geography 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'geography',NEW.geography_id);
    end |
 create trigger trg_geography_binsert before insert on  geography
   for each row 
    begin 
      if NEW.parent_id is not null then 
         set NEW.parentage = replace(concat(cco_full.getGeogParentage(NEW.parent_id),'/',NEW.parent_id),'//','/');
      else 
         set NEW.parentage = '/';
      end if;
    end |
 create trigger trg_geographytreedef_insert after insert on  geographytreedef 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'geographytreedef',NEW.geographytreedef_id);
    end |
 create trigger trg_geographytreedefitem_insert after insert on  geographytreedefitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'geographytreedefitem',NEW.geographytreedefitem_id);
    end |
 create trigger trg_collection_insert after insert on  collection 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'collection',NEW.collection_id);
    end |
 create trigger trg_storagetreedef_insert after insert on  storagetreedef 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'storagetreedef',NEW.storagetreedef_id);
    end |
 create trigger trg_storagetreedefitem_insert after insert on  storagetreedefitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'storagetreedefitem',NEW.storagetreedefitem_id);
    end |
 create trigger trg_storage_insert after insert on  storage 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'storage',NEW.storage_id);
    end |
 create trigger trg_storage_binsert before insert on  storage
   for each row 
    begin 
      -- Find the parentage of the new parent, append the parent_id of the current node.
    if NEW.parent_id is not null then 
        set NEW.parentage = replace(concat(cco_full.getStorageParentage(NEW.parent_id),'/',NEW.parent_id),'//','/');
    else
        set NEW.parentage = '/';
    end if;
    end |
 create trigger trg_rocktimeunit_insert after insert on  rocktimeunit 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'rocktimeunit',NEW.rocktimeunit_id);
    end |
 create trigger trg_rocktime_binsert before insert on  rocktimeunit
   for each row 
    begin 
      -- Find the parentage of the new parent, append the parent_id of the current node.
    if NEW.parent_id is not null then 
        set NEW.parentage = replace(concat(cco_full.getRockTimeParentage(NEW.parent_id),'/',NEW.parent_id),'//','/');
    else
        set NEW.parentage = '/';
    end if;
    end |
 create trigger trg_rocktimeunittreedef_insert after insert on  rocktimeunittreedef 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'rocktimeunittreedef',NEW.rocktimeunittreedef_id);
    end |
 create trigger trg_rocktimeunittreedefitem_insert after insert on  rocktimeunittreedefitem 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'rocktimeunittreedefitem',NEW.rocktimeunittreedefitem_id);
    end |
 create trigger trg_paleocontext_insert after insert on  paleocontext 
   for each row 
    begin 
      insert into auditlog(action,timestamptouched,dbusername,username,agent_id,for_table,primary_key_value) values ('insert',now(),user(),getAgentName(NEW.modified_by_agent_id),NEW.modified_by_agent_id,'paleocontext',NEW.paleocontext_id);
    end | 

-- End after insert triggers

-- changeset chicoreus:159 dbms:none
delimiter ;
-- changeset chicoreus:159 endDelimiter:; dbms:mysql
-- just a placeholder for the delimiter
select 1;


--  The last liquibase changeset in this document was number 159

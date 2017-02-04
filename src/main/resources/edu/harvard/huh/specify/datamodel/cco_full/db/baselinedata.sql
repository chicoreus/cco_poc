-- liquibase formatted sql

-- changeset chicoreus:160

--  Baseline data for a cco_full database.

-- Composition of scope, principal, and systemuser to define permissions for users.
INSERT INTO scope (scope_id, name) VALUES (1,'Default Institution');
INSERT INTO scope (scope_id, name,parent_scope_id) VALUES (2,'Default Malacology Department',1);
INSERT INTO scope (scope_id, name,parent_scope_id) VALUES (3,'Default Mammalogy Department',1);
INSERT INTO scope (scope_id, name,parent_scope_id) VALUES (4,'Default Icthyology Department',1);
INSERT INTO scope (scope_id, name,parent_scope_id) VALUES (5,'Default Ornithology Department',1);
INSERT INTO scope (scope_id, name,parent_scope_id) VALUES (6,'Default Paleontology Department',1);
INSERT INTO scope (scope_id, name,parent_scope_id) VALUES (7,'Default Botany Department',1);
INSERT INTO scope (scope_id, name,parent_scope_id) VALUES (8,'Default Herpetology Department',1);
INSERT INTO scope (scope_id, name,parent_scope_id) VALUES (9,'Default Entomology Department',1);

INSERT INTO agent(agent_id, preferred_name_string) VALUES (1,'Example User');
INSERT INTO agentname(agent_id, type, name) VALUES (2,'full name','Example User');

INSERT INTO principal (principal_id, principal_name,scope_id) VALUES (1,'user',1);
INSERT INTO principal (principal_id, principal_name,scope_id) VALUES (2,'data entry',2);
INSERT INTO principal (principal_id, principal_name,scope_id) VALUES (3,'manage transactions',2);
INSERT INTO systemuser (systemuser_id, username, is_enabled,user_agent_id) VALUES (1,'example@example.com',FALSE,1);  
INSERT INTO systemuserprincipal (systemuser_id, principal_id) VALUES (1,1);  -- example user has user permissions in default institution
INSERT INTO systemuserprincipal (systemuser_id, principal_id) VALUES (1,2);  -- example user has data entry permissions in default malacology collection

-- Populate some picklists, including examples of internationalization and definitions.
-- changeset chicoreus:161
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (110, 'count modifier','identifiableitem','individual_count_modifier');
INSERT INTO picklistitem (picklistitem_id, picklist_id, ordinal, title, value) VALUES (1,110,1,'?','?');
INSERT INTO picklistitem (picklistitem_id, picklist_id, ordinal, title, value) VALUES (2,110,2,'+','+'); 
INSERT INTO picklistitem (picklistitem_id, picklist_id, ordinal, title, value) VALUES (3,110,3,'ca.','ca.');
INSERT INTO picklistitemint (picklistitem_id, lang, title_lang, definition) VALUES (1,'en_gb','?','count is uncertain.') ;
INSERT INTO picklistitemint (picklistitem_id, lang, title_lang, definition) VALUES (2,'en_gb','+','and more, count is at least the specified number.') ;
INSERT INTO picklistitemint (picklistitem_id, lang, title_lang, definition) VALUES (3,'en_gb','circa','count is approximate.') ;
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (120, 'count units','identifiableitem','individual_count_units');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (120,1,'individuals','individuals');  -- for lot based collections 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (120,2,'valves','valves');  -- could restrict to malacology and invertebrate paleontology
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (120,3,'fragments','fragments');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (120,3,'eggs','eggs');  -- could restrict to ornithology 
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (130, 'identification qualifier','identification','qualifier');
INSERT INTO picklistitem (picklistitem_id, picklist_id, ordinal, title, value) VALUES (10,130,1,'?','?');
INSERT INTO picklistitem (picklistitem_id, picklist_id, ordinal, title, value) VALUES (11,130,2,'aff.','aff.');
INSERT INTO picklistitem (picklistitem_id, picklist_id, ordinal, title, value) VALUES (12,130,3,'cf.','cf.');
INSERT INTO picklistitem (picklistitem_id, picklist_id, ordinal, title, value) VALUES (13,130,4,'near','near');
INSERT INTO picklistitem (picklistitem_id, picklist_id, ordinal, title, value) VALUES (14,130,6,'(group)','(group)');
INSERT INTO picklistitem (picklistitem_id, picklist_id, ordinal, title, value) VALUES (15,130,6,'sp. nov.','sp. nov.');  -- place holder for to be described species in a genus, taxon_id should have rank of genus. 
INSERT INTO picklistitem (picklistitem_id, picklist_id, ordinal, title, value) VALUES (16,130,7,'ssp. nov.','ssp. nov.');  -- place holder for to be described subspecies in a species, taxon_id should have rank of species. 
INSERT INTO picklistitemint (picklistitem_id, lang, title_lang, definition) VALUES (15,'en_gb','sp. nov.','place holder for types of soon to be described species where the name is not yet available.  the taxon used in the identification should be a genus, the assertion in the identification is that this is a new species in that genus.');
INSERT INTO picklistitemint (picklistitem_id, lang, title_lang, definition) VALUES (16,'en_gb','ssp. nov.','place holder for types of soon to be described subspecies where the name is not yet available.  the taxon used in the identification should be a species, the assertion in the identification is that this is a new subspecies in that species.');
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (190, 'preparation status','preparation','status');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,1,'in collection','in collection');  -- verified in an inventory as in the collection
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,2,'unknown','unknown'); -- usual status for material entered from ledgers or other paper records. 
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,3,'on loan','on loan'); -- preparation is out on loan
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,3,'destroyed','destroyed'); -- preparation known to have been destroyed
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (190,3,'lost','lost'); -- preparation lost
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (5000, 'Cites Status','taxon','cites_status');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5000,1,'none','none');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5000,2,'CITES I','CITES I');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5000,3,'CITES II','CITES II');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5000,5,'CITES III','CITES III');
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (5001, 'Nomenclatural Code','taxon','nomenclatural_code');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5001,3,'noncompliant','noncompliant');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5001,1,'ICZN','ICZN');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5001,2,'ICNafp','ICNafp');
INSERT INTO taxontreedef(taxontreedef_id, name) VALUES (1,'Taxonomic Tree');
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (5005, 'Nomenclatural Code','taxontreedefitem','nomenclatural_code');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5005,1,'Any','Any');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5005,2,'ICZN','ICZN');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (5005,3,'ICNafp','ICNafp');

-- changeset chicoreus:162
INSERT INTO taxontreedefitem (taxontreedefitem_id, rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (1,0, 'Life', 1, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (10, 'Kingdom', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (20, 'Major Group', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id,nomenclatural_code) VALUES (30, 'Phylum', 0, 0,1,'ICZN');
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id,nomenclatural_code) VALUES (30, 'Division', 0, 0,1,'ICNafp');
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (50, 'Superclass', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (60, 'Class', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (70, 'Subclass', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (90, 'Superorder', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (100, 'Order', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (110, 'Suborder', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (120, 'Infraorder', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (130, 'Superfamily', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (140, 'Family', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (150, 'Subfamily', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (160, 'Tribe', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (180, 'Genus', 1, 1,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id,text_before,text_after) VALUES (190, 'Subgenus', 0, 0,1,'(',')');
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (220, 'Species', 1, 1,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id) VALUES (230, 'Subspecies', 0, 0,1);
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id,text_before) VALUES (240, 'Variety', 0, 0,1,'var.');
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id,text_before,nomenclatural_code) VALUES (250, 'Subvariety', 0, 0,1,'sub var.','ICNafp');
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id,text_before) VALUES (260, 'Forma', 0, 0,1,'f.');
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id,text_before,nomenclatural_code) VALUES (270, 'Subforma', 0, 0,1,'sub f.','ICNafp');
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id,text_before,nomenclatural_code) VALUES (280, 'Lusus', 0, 0,1,'lusus','ICNafp');
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id,text_before,nomenclatural_code) VALUES (290, 'Modification', 0, 0,1,'mod.','ICNafp');
INSERT INTO taxontreedefitem (rank_id,name,is_enforced,is_in_full_name,taxontreedef_id,text_before,nomenclatural_code) VALUES (300, 'Prolus', 0, 0,1,'prolus','ICNafp');
INSERT INTO taxon (taxon_id, scientific_name, trivial_epithet, authorship, display_name, parent_id, parentage, taxontreedefitem_id, rank_id) VALUES (1,'Life','','','<strong>Life</strong>',null,'/1',1,1);

-- changeset chicoreus:163
INSERT INTO ctjournaltitletype (title_type) VALUES ('title');
INSERT INTO ctjournaltitletype (title_type) VALUES ('title variant');
INSERT INTO ctjournaltitletype (title_type) VALUES ('abbreviation');
INSERT INTO ctjournaltitletype (title_type) VALUES ('title variant(2)');
INSERT INTO ctjournaltitletype (title_type) VALUES ('title variant(3)');
INSERT INTO ctjournalidentifiertype (identifier_type) VALUES ('ISSN');
INSERT INTO ctjournalidentifiertype (identifier_type) VALUES ('OCLC');  
INSERT INTO ctjournalidentifiertype (identifier_type) VALUES ('TL2');   -- For botanical journals
INSERT INTO ctjournalidentifiertype (identifier_type) VALUES ('LC Control Number');  -- See:  https://lccn.loc.gov/lccnperm-faq.html
INSERT INTO ctpublicationidentifiertype (identifier_type) VALUES ('ISBN');
INSERT INTO ctpublicationidentifiertype (identifier_type) VALUES ('LC Control Number');  -- See:  https://lccn.loc.gov/lccnperm-faq.html
-- changeset chicoreus:164
INSERT INTO ctcatnumseriespolicy (policy) VALUES ('inactive, complete');  -- All known numbers in this series have been assigned and databased, issue no new numbers.
INSERT INTO ctcatnumseriespolicy (policy) VALUES ('inactive, manual');  -- Retrospective capture of existing cataloged items only, don't autoassign numbers.
INSERT INTO ctcatnumseriespolicy (policy) VALUES ('active, manual');  -- Active, assigning numbers for new material, allow users to provide the number.
INSERT INTO ctcatnumseriespolicy (policy) VALUES ('active, automatic');  -- Active, assigning numbers for new material, provide numbers for users.
-- changeset chicoreus:165
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (6001, 'Date Type','eventdate','date_type');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (6001,1,'date','date');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (6001,2,'interval','interval');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (6001,3,'year','year');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (6001,4,'year/month','year/month');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (6001,5,'date time','date time');
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
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (160, 'loan type','loan','loan_type');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (160,1,'returnable','returnable');  -- returnable in whole or in part
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (160,2,'consumable','consumable'); -- entirely consumable, only data is expected to be returned.
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (160,3,'exhibition','exhibition'); -- loan of valuable material for exhibition with additional standard conditions 
INSERT INTO picklist (picklist_id, name, table_name, field_name) VALUES (180, 'borrow type','borrow','borrow_type');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (180,1,'returnable','returnable');  -- returnable in whole or in part
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (180,2,'consumable','consumable'); -- entirely consumable, only data is expected to be returned.
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (180,3,'exhibition','exhibition'); -- loan of valuable material for exhibition with additional standard conditions 
INSERT INTO picklist (picklist_id, name, table_name, field_name, read_only) VALUES (100, 'agent type','agent','agent_type',1);
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (100,1,'individual','individual');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (100,2,'team','team');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (100,3,'organization','organization');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (100,4,'software agent','software agent');
INSERT INTO picklist (picklist_id, name, table_name, field_name, read_only) VALUES (101, 'agent living','agent','living',1);
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (101,1,'Yes','Yes');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (101,2,'No','No');
INSERT INTO picklistitem (picklist_id, ordinal, title, value) VALUES (101,3,'?','?');
-- changeset chicoreus:166
INSERT INTO ctrelationshiptype (relationship, inverse, collective) VALUES ('child of', 'parent of', 'children');
INSERT INTO ctrelationshiptype (relationship, inverse, collective) VALUES ('student of', 'teacher of', 'students');
INSERT INTO ctrelationshiptype (relationship, inverse, collective) VALUES ('spouse of', 'spouse of', 'married to');
INSERT INTO ctrelationshiptype (relationship, inverse, collective) VALUES ('could be', 'confused with', 'confused with');  -- to accompany nototherwisespecified 
INSERT INTO ctrelationshiptype (relationship, inverse, collective) VALUES ('successor of', 'predecessor of', 'sucessors');  -- to relate organizations 
-- changeset chicoreus:167
INSERT INTO ctagentnametype (type, ordinal) VALUES ('full name',1);
INSERT INTO ctagentnametype (type, ordinal) VALUES ('standard abbreviation',2);
INSERT INTO ctagentnametype (type, ordinal) VALUES ('standard botanical abbreviation',3);
INSERT INTO ctagentnametype (type, ordinal) VALUES ('also known as',4);
INSERT INTO ctagentnametype (type, ordinal) VALUES ('initials last name',5);  -- expected form for second and subseqent authors.
INSERT INTO ctagentnametype (type, ordinal) VALUES ('last name, initials',5);  -- expected form for first author.
INSERT INTO ctagentnametype (type, ordinal) VALUES ('first initials last',5);
INSERT INTO ctagentnametype (type, ordinal) VALUES ('first last',5);
-- changeset chicoreus:168
INSERT INTO ctlengthunit (lengthunit) VALUES ('meters');
INSERT INTO ctlengthunit (lengthunit) VALUES ('centimeters');
INSERT INTO ctlengthunit (lengthunit) VALUES ('milimeters');
INSERT INTO ctmassunit (massunit) VALUES ('grams');
INSERT INTO ctmassunit (massunit) VALUES ('kilograms');
INSERT INTO ctmassunit (massunit) VALUES ('miligrams');
INSERT INTO ctageclass (ageclass) VALUES ('unknown');
INSERT INTO ctageclass (ageclass) VALUES ('adult');
INSERT INTO ctageclass (ageclass) VALUES ('juvenile');
INSERT INTO ctageclass (ageclass) VALUES ('pup');
INSERT INTO ctageclass (ageclass) VALUES ('chick');
INSERT INTO ctageclass (ageclass) VALUES ('nestling');
INSERT INTO ctageclass (ageclass) VALUES ('subadult');
INSERT INTO ctageclass (ageclass) VALUES ('immature');
INSERT INTO ctageclass (ageclass) VALUES ('egg');
-- changeset chicoreus:169
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','pup',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','chick',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','nestling',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','subadult',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','immature',5);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctageclass','egg',5);
-- changeset chicoreus:170
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
-- changeset chicoreus:171
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','standard length',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','body length',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','disk length',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','fork length',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','head length',4);
-- changeset chicoreus:172
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
-- changeset chicoreus:173
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
-- changeset chicoreus:174
INSERT INTO ctbiologicalattributetype (name,unitscodetable) VALUES ('total length','ctlengthunit');
-- changeset chicoreus:175
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','total length',3);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','total length',4);
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','total length',5);
-- changeset chicoreus:176
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
-- changeset chicoreus:177
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
-- changeset chicoreus:177a
INSERT INTO ctbiologicalattributetype (name) VALUES ('caste');
INSERT INTO scopect (ct_table_name,key_name,scope_id) VALUES ('ctbiologicalattributetype','caste',9);
-- changeset chicoreus:178
INSERT INTO ctencumberancetype (encumberance_type) VALUES ('mask record'); -- Do not show the encumbered record (e.g. hide a media record).
INSERT INTO ctencumberancetype (encumberance_type) VALUES ('redact locality');  -- Redact coordinate, georeference, elevation, and detailed locality information associated with this record.  
INSERT INTO ctencumberancetype (encumberance_type) VALUES ('mask record and relations'); -- Do not show the encumbered record or related data object (e.g. for a taxon, hide units that use this taxon in an identificaiton; or for a media record hide the meida record and associated unit data).
-- changeset chicoreus:179
INSERT INTO ctelectronicaddresstype (typename) VALUES ('phone');
INSERT INTO ctelectronicaddresstype (typename) VALUES ('fax');
INSERT INTO ctelectronicaddresstype (typename) VALUES ('email');
-- changeset chicoreus:180
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('utm/ups','utm');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('decimal degrees','ddg');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('degrees minutes seconds','dms');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('degrees decimal minutes','ddm');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('mgrs','grid');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('osgb','grid');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('rikets nät, rt 90','xy');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('swiss grid','xy');
INSERT INTO ctcoordinatetype (coordinatetype, fieldprefix) VALUES ('public land survey system (township section range)','plss');

-- changeset chicoreus:181
INSERT INTO geographytreedef (geographytreedef_id,full_name_direction,name) VALUES (1,-1,'geopolitical heirarchy');
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (1,', ',1,0,'root',0,null,null,null,'root',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (2,', ',0,0,'continent',100,null,null,null,'continent',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (3,', ',0,0,'region',150,null,null,null,'region',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (4,', ',0,0,'island group',160,null,null,null,'island group',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (5,', ',0,0,'island',170,null,null,null,'island',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (6,':' ,0,1,'country',200,null,null,null,'country',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (7,', ',0,0,'land',210,null,null,null,'land',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (8,', ',0,0,'territory',220,null,null,null,'territory',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (9,', ',0,0,'subcontinent island(s)',230,null,null,null,'subcontinent island(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (10,', ',0,0,'continent subregion',250,null,null,null,'continent subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (11,', ',0,0,'country subregion',260,null,null,null,'country subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (12,', ',0,0,'straights',270,null,null,null,'straights',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (13,', ',0,0,'subcountry island(s)',280,null,null,null,'subcountry island(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (14,':' ,0,1,'state/province',300,null,null,null,'state/province',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (15,', ',0,0,'peninsula',310,null,null,null,'peninsula',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (16,', ',0,0,'substate island(s)',320,null,null,null,'substate island(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (19,', ',0,0,'state subregion',380,null,null,null,'state subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (20,', ',0,1,'county',400,null,null,null,'county',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (21,', ',0,0,'mountain(s)',410,null,null,null,'mountain(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (22,', ',0,0,'river',420,null,null,null,'river',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (23,', ',0,0,'forest',430,null,null,null,'forest',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (24,', ',0,0,'valley',440,null,null,null,'valley',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (25,', ',0,0,'island(s)',450,null,null,null,'island(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (26,', ',0,0,'hill(s)',460,null,null,null,'hill(s)',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (27,', ',0,0,'canyon',470,null,null,null,'canyon',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (28,', ',0,0,'lake',480,null,null,null,'lake',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (29,', ',0,1,'county subregion',490,null,null,null,'county subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (30,', ',0,1,'muncipality',500,null,null,null,'muncipality',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (31,', ',0,0,'city subregion',510,null,null,null,'city subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (32,':' ,0,1,'ocean',100,null,null,null,'ocean',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (33,':' ,0,1,'ocean region',150,null,null,null,'ocean region',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (34,', ',0,0,'ocean subregion',250,null,null,null,'ocean subregion',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (35,', ',0,0,'exclusive economic zone',260,null,null,null,'maritime eez',1);
INSERT INTO geographytreedefitem (geographytreedefitem_id, full_name_separator, is_enforced, is_in_full_name, name, rank_id, remarks, text_after, text_before, title, geographytreedef_id) VALUES (36,', ',0,0,'state/province coastal waters',380,null,null,null,'off the coast of {state/province}',1);

-- changeset chicoreus:182
INSERT INTO geologictimeperiodtreedef (geologictimeperiodtreedef_id,full_name_direction,name) VALUES (1,-1,"Geochronologic tree");
INSERT INTO geologictimeperiodtreedef (geologictimeperiodtreedef_id,full_name_direction,name) VALUES (2,-1,"Lithostratigraphic tree");
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (1,1,':',0,'Eon',100);
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (2,1,':',1,'Era',200);
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (3,1,':',1,'Period',300);
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (4,1,':',1,'Epoch',400); -- e.g.  If not named (e.g. Llandovery), uses time related Early/Middle/Late divisions of Period, e.g.  Late Devonian (not position terms, e.g. not Upper Devonian).
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (5,1,':',1,'Age',500);
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (6,1,':',1,'Subage',500);
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (100, 2,':',0,'Supergroup',100);
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (101, 2,':',0,'Group',200);  
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (102, 2,':',0,'Formation',300);
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (103, 2,':',0,'Member',400);
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (104, 2,':',0,'Bed',500);
INSERT INTO geologictimeperiodtreedefitem (geologictimeperiodtreedefitem_id, geologictimeperiodtreedef_id, full_name_separator,is_in_full_name,name,rank_id) VALUES (105, 2,':',0,'Flow',500);  -- for named volcanic flows

-- changeset chicoreus:183
INSERT INTO agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath) VALUES (2,'Linnaeus','https://viaf.org/viaf/34594730',1707,1778);
INSERT INTO agentname(agent_id, type, name) VALUES (2,'full name','Carl von Linné');
INSERT INTO agentname(agent_id, type, name) VALUES (2,'also known as','Carl Linnaeus');
INSERT INTO agentname(agent_id, type, name) VALUES (2,'standard botanical abbreviation','L.');
INSERT INTO agentname(agent_id, type, name) VALUES (2,'standard abbreviation','Linné');
INSERT INTO agentlink (agent_id, type, link, text) VALUES (2,'wiki','https://en.wikipedia.org/wiki/Carl_Linnaeus','Wikipedia entry');

--  The last liquibase changeset in this document was number 183

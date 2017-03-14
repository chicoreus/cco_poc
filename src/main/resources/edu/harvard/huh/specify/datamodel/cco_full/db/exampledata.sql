-- liquibase formatted sql

-- Example data illustrating the use of the cco_full schema.

-- changeset chicoreus:exampleAgents

-- Real agents (authors, collectors) used in the example data.

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (3,'Mason Ellsworth Hale, Jr.','https://viaf.org/viaf/310661352',1928,1990,'Hale','','Jr.','Mason','Ellsworth','Hale');
insert into agentname(agent_id, type, name) values (3,'full name','Mason Ellsworth Hale, Jr.');
insert into agentname(agent_id, type, name) values (3,'also known as','Mason Hale Jr.');
insert into agentname(agent_id, type, name) values (3,'standard botanical abbreviation','Hale');
insert into agentlink (agent_id, type, link, text) values (3,'wiki','https://en.wikipedia.org/wiki/Mason_Ellsworth_Hale','Wikipedia entry');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (4,'Jakob Friedrich Ehrhart','https://viaf.org/viaf/3221377',1742,1795,'Ehrh.','','','Jakob','Friedrich','Ehrhart');
insert into agentname(agent_id, type, name) values (4,'full name','Jakob Friedrich Ehrhart');
insert into agentname(agent_id, type, name) values (4,'also known as','Friedrich Ehrhart');
insert into agentname(agent_id, type, name) values (4,'standard botanical abbreviation','Ehrh.');
insert into agentlink (agent_id, type, link, text) values (4,'wiki','https://en.wikipedia.org/wiki/Ehrh.','Wikipedia entry');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (5,'Erik Acharius','https://viaf.org/viaf/51806870',1757,1819,'Ach.','','','Erik','','Acharius');
insert into agentname(agent_id, type, name) values (5,'full name','Erik Acharius');
insert into agentname(agent_id, type, name) values (5,'standard botanical abbreviation','Ach.');
insert into agentlink (agent_id, type, link, text) values (5,'wiki','https://en.wikipedia.org/wiki/Ach.','Wikipedia entry');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (6,'Edward Tuckerman','https://viaf.org/viaf/59861375',1817,1886,'Tuckerman','','','Edward','','Tuckerman');
insert into agentname(agent_id, type, name) values (6,'full name','Edward Tuckerman');
insert into agentname(agent_id, type, name) values (6,'standard botanical abbreviation','Tuckerman');
insert into agentlink (agent_id, type, link, text) values (6,'wiki','https://en.wikipedia.org/wiki/Edward_Tuckerman','Wikipedia entry');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (7,'Johann Leonhard Frisch','http://viaf.org/viaf/132112889',1737,1795,'Frisch','','','Johann','Leonhard','Frisch');
insert into agentname(agent_id, type, name) values (7,'full name','Johann Leonhard Frisch');
insert into agentname(agent_id, type, name) values (7,'last name, initials','Frisch, J.L.');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (8,'Charles Bixler Heiser','http://viaf.org/viaf/91708870',1920,2010,'Heiser','','','Charles','Bixler','Heiser');
insert into agentname(agent_id, type, name) values (8,'full name','Charles Bixler Heiser');
insert into agentname(agent_id, type, name) values (8,'last name, initials','Heiser, C.B.');
insert into agentname(agent_id, type, name) values (8,'standard botanical abbreviation','Heiser');


insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (9,'A.F.M. Glaziou',null,null,null,'Glaziou','','','A.','F. M.','Glaziou');
insert into agentname(agent_id, type, name) values (9,'last name, initials','Glaziou, A.F.M.');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (10,'C. F. P. von Martius',null,null,null,'Mart.','von','','C.','F. P.','Martius');
insert into agentname(agent_id, type, name) values (10,'last name, initials','Martius, C.F.P');
insert into agentname(agent_id, type, name) values (10,'full name','Carl Friedrich Philipp von Martius');
insert into agentname(agent_id, type, name) values (10,'also known as','Karl Friedrich Philipp von Martius');
insert into agentname(agent_id, type, name) values (10,'initials last name','C.F.P. Martius');
insert into agentname(agent_id, type, name) values (10,'standard botanical abbreviation','Mart.');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (11,'Odoardo Beccari',null,null,null,'Becc.','','','O.','','Beccari');
insert into agentname(agent_id, type, name) values (11,'last name, initials','Beccari, O.');
insert into agentname(agent_id, type, name) values (11,'full name','Odoardo Beccari');
insert into agentname(agent_id, type, name) values (11,'standard botanical abbreviation','Becc.');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (12,'Ruth D. Turner','http://viaf.org/viaf/85255758',1914,2000,'R.D. Turner','','','Ruth','Dixon','Turner');
insert into agentname(agent_id, type, name) values (12,'last name, initials','Turner, R.D.');
insert into agentname(agent_id, type, name) values (12,'full name','Ruth Dixon Turner');
insert into agentname(agent_id, type, name) values (12,'also known as','Ruth D. Turner');
insert into agentname(agent_id, type, name) values (12,'initials last name','R.D. Turner');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string) 
       values (13,'[no agent data]',null,null,null,'[no agent data]');
insert into agentname(agent_id, type, name) values (13,'full name','[no agent data]');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (14,'Harry A. Tolman',null,null,null,'H.A. Tolman','','','Harry','A.','Tolman');
insert into agentname(agent_id, type, name) values (14,'last name, initials','Tolman, H.A.');
insert into agentname(agent_id, type, name) values (14,'also known as','Harry A. Tolman');
insert into agentname(agent_id, type, name) values (14,'initials last name','H. A. Tolman');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (15,'S.P. Cover',null,null,null,'S.P. Cover','','','S.','P.','Cover');
insert into agentname(agent_id, type, name) values (15,'last name, initials','Cover, S.P.');
insert into agentname(agent_id, type, name) values (15,'initials last name','S.P. Cover');

insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (16,'M.G. Basset',null,null,null,'M.G. Basset','','','Michael','G.','Basset');
insert into agentname(agent_id, type, name) values (16,'last name, initials','Basset, M.G.');
insert into agentname(agent_id, type, name) values (16,'initials last name','M.G. Basset');
insert into agent(agent_id, preferred_name_string,sameas_guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (17,'Catherine Bryant',null,null,null,'C. Bryant','','','Catherine','','Bryant');
insert into agentname(agent_id, type, name) values (17,'last name, initials','Bryant, C.');
insert into agentname(agent_id, type, name) values (17,'full name','Catherine Bryant');

-- Real taxa used in the example data

-- changeset chicoreus:exampleTaxa
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (2, 'Fungi', 'Fungi','Fungi', 1, 2, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (3, 'Animalia', 'Animalia','Animalia', 1, 2, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (4, 'Plantae', 'Plantae','Plantae', 1, 2, 'ICNafp');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (5, 'Parmeliaceae', 'Parmeliaceae','Parmeliaceae', 2, 14, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (6, 'Xanthoparmelia', '<em>Xanthoparmelia</em>', 'Xanthoparmelia', 5, 17, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (7, 'Lichen', '<em>Lichen</em>','Lichen', 2, 17, 'ICNafp');

insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, parauthor_agent_id, parexauthor_agent_id, author_agent_id, year_published, nomenclator_guid) 
       values (8, 'Xanthoparmelia conspersa', '(Ehrh. ex Ach.) Hale', '<em>Xanthoparmelia conspersa</em> (Ehrh. ex Ach.) Hale','conspersa', 6, 19, 'ICNafp',4,5,3, '(1974)', 'urn:lsid:indexfungorum.org:names:343884');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, author_agent_id, exauthor_agent_id, year_published, accepted_taxon_id, nomenclator_guid) 
       values (9, 'Lichen conspersus', 'Ehrh. ex Ach.', '<em>Lichen conspersus</em> Ehrh. ex Ach.','conspersus', 7, 19, 'ICNafp',4,5,'1799 [1798]',7, 'urn:lsid:indexfungorum.org:names:393893');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (10, 'Fagaceae', 'Fagaceae', 'Fagaceae',  4,  23, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (11, 'Quercus', '<em>Quercus</em>', 'Quercus', 10, 17, 'ICNafp');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, author_agent_id, year_published, nomenclator_guid) 
       values (12, 'Quercus alba', 'L.', '<em>Quercus alba</em> L.','alba', 11, 19, 'ICNafp',2,'1753','urn:lsid:ipni.org:names:295763-1:1.2.2.1.1.3');


insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (13, 'Mollusca', 'Mollusca', 'Mollusca', 3,  4, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (14, 'Gastropoda', 'Gastropoda', 'Gastropoda', 13,  7, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (15, 'Littorinidae', 'Littorinidae', 'Littorinidae', 14,  14, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (16, 'Littorina', 'Littorina', 'Littorina', 15,  17, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, parauthor_agent_id, year_published, nomenclator_guid) 
       values (17, 'Littorina littorea', '(Linnaeus, 1758)', '<em>Littorina littorea</em> (Linnaeus, 1758)', 'littorea', 16,  19, 'ICZN',2,'1758','urn:lsid:marinespecies.org:taxname:140262');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (18, 'Chordata', 'Chordata', 'Chordata', 3,  4, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (19, 'Mammalia', 'Mammalia', 'Mammalia', 18,  7, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (20, 'Cannidae', 'Canidae', 'Canidae', 19,  14, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code, authorship, author_agent_id, year_published,remarks,nomenclator_guid)
       values (21, 'Vulpes', 'Vulpes', 'Vulpes', 20,  17, 'ICZN','Frisch, 1775',7,'1775','While Frisch (1775) is a rejected work (ICZN Opinion 258, 1954), Vulpes has been retained (ICZN Opinion 1129, 1979).  Have not confirmed that Frisch, Johann Leonhard 1737-1795 is the Johann Leonhard Frisch who authored this work, but, but this work (Das Natur-System der Vierfußigen Thiere) is not in the biographical record of Frisch, Johann Leonhard, 1666-1743 from Berlin-Brandenburgische Akademie der Wissenschaften Akademiebibliothek.','urn:lsid:marinespecies.org:taxname:404129');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, parauthor_agent_id, year_published, nomenclator_guid) 
       values (22, 'Vulpes vulpes', 'Linnaeus, 1758', '<em>Vulpes vulpes</em> Linnaeus, 1758', 'vulpes', 21,  19, 'ICZN',2,'1758','http://www.departments.bucknell.edu/biology/resources/msw3/browse.asp?s=y&id=14000892');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (23, 'Angiospermae', 'Angiospermae', 'Angiospermae', 4,  7, 'ICNafp');


insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (24, 'Arecaceae', 'Arecaceae', 'Arecaceae', 23,  14, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (25, 'Cocos', '<em>Cocos</em>', 'Cocos', 24, 17, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (26, 'Syagrus', '<em>Syagrus</em>', 'Syagrus', 24, 17, 'ICNafp');

-- 27 Syagrus oleracea (Martius) Beccari
-- Syagrus oleracea (Martius 10) Beccari 11
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, author_agent_id, parauthor_agent_id, year_published, nomenclator_guid) 
       values (27, 'Syagrus oleracea', '(Mart.) Becc.', '<em>Syagrus oleracea</em> (Mart.) Becc.','oleracea', 26, 19, 'ICNafp',11, 10,'','urn:lsid:ipni.org:names:1177502-2:1.3');

-- 28  Cocos oleracea Martius
-- Cocos oleracea Martius 10
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, author_agent_id, year_published, nomenclator_guid) 
       values (28, 'Cocos oleracea', 'Mart.', '<em>Cocos oleracea</em> Mart.','oleracea', 25, 19, 'ICNafp',10,'','urn:lsid:ipni.org:names:62615-2:1.2');

-- Janthinidae 
-- Janthina janthina (Linnaeus, 1758)  urn:lsid:marinespecies.org:taxname:140155
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (29, 'Janthinidae', 'Janthinidae', 'Janthinidae', 14,  14, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (30, 'Janthina', 'Janthina', 'Janthina', 29,  17, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, parauthor_agent_id, year_published, nomenclator_guid) 
       values (31, 'Janthina janthina', '(Linnaeus, 1758)', '<em>Janthina janthina</em> (Linnaeus, 1758)', 'janthina', 16,  19, 'ICZN',2,'1758','urn:lsid:marinespecies.org:taxname:140155');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (32, 'Arthropoda', 'Arthropoda', 'Arthropoda', 3,  4, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (33, 'Formicidae', 'Formicidae', 'Formicidae', 32,  14, 'ICZN');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (34, 'Pogonomyrmex', 'Pogonomyrmex', 'Pogonomyrmex', 33,  17, 'ICZN');

-- Pogonomyrmex colei, inquiline in Pogonomyrmex rugosus nests
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, year_published, nomenclator_guid) 
       values (35, 'Pogonomyrmex rugosus', 'Emery, 1895', '<em>Pogonomyrmex rugosus</em> Emery, 1895', 'rugosus', 34,  19, 'ICZN','1895',null);
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, year_published, nomenclator_guid) 
       values (36, 'Pogonomyrmex colei', 'Emery, 1982', '<em>Pogonomyrmex colei</em> Emery, 1982', 'colei', 34,  19, 'ICZN','1895',null);

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (37, 'Brachiopoda', 'Brachiopoda', 'Brachiopoda', 3,  4, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (38, 'Rhynchonellata', 'Rhynchonellata', 'Rhynchonellata', 37,  7, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (39, 'Strophomenata', 'Strophomenata', 'Strophomenata', 37,  7, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (40, 'Rhipidomellidae', 'Rhipidomellidae', 'Rhipidomellidae', 38,  14, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (41, 'Rhipidomella', 'Rhipidomella', 'Rhipidomella', 37,  17, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, year_published, nomenclator_guid) 
       values (42, 'Rhipidomella michelini', '(Léveilé, 1835)', '<em>Rhipidomella michelini</em> (Léveilé, 1835)', 'michelini', 41,  19, 'ICZN','1895',null);

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (43, 'Rugosochonetidae', 'Rugosochonetidae', 'Rugosochonetidae', 39,  14, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (44, 'Rugosochonetes', 'Rugosochonetes', 'Rugosochonetes', 43,  17, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, year_published, nomenclator_guid) 
       values (45, 'Rugosochonetes vaughani', 'Muir-Wood, 1962', '<em>Rugosochonetes vaughani</em> Muir-Wood, 1962', 'vaughani', 44,  19, 'ICZN','1895',null);

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (46, 'Pulsiidae', 'Pulsiidae', 'Pulsiidae', 39,  14, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (47, 'Schellwienella', 'Schellwienella', 'Schellwienella', 46,  17, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, year_published, nomenclator_guid) 
       values (48, 'Schellwienella cheuma', 'Basset & Bryant, 2006', '<em>Schellwienella cheuma</em> Basset & Bryant, 2006', 'cheuma', 47,  19, 'ICZN','1895',null);

insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, parauthor_agent_id, author_agent_id, year_published, nomenclator_guid) 
       values (49, 'Xanthoparmelia diadeta','(Hale) Hale', '<em>Xanthoparmelia diadeta</em> (Hale) Hale','diadeta', 6, 19, 'ICNafp',3,3, '(1974)', 'urn:lsid:indexfungorum.org:names:343890');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (50, 'Parmelia', '<em>Parmelia</em>', 'Parmelia', 5, 17, 'ICNafp');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (51, 'Actinopterygii', 'Actinopterygii','Actinopterygii', 18, 7, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (52, 'Perciformes', 'Perciformes','Perciformes', 51, 10, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (53, 'Callionymidae', 'Callionymidae','Callionymidae', 52, 14, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (54, 'Callionymus', 'Callionymus','Callionymus', 53, 17, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, parauthor_agent_id, year_published, nomenclator_guid) 
       values (55, 'Callionymus lyra', 'Linnaeus, 1758', '<em>Callionymus lyra</em> Linnaeus, 1758', 'lyra', 54,  19, 'ICZN',2,'1758','urn:lsid:marinespecies.org:taxname:126792');


insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, taxontreedefitem_id, nomenclatural_code) 
       values (56, 'Fagus', '<em>Fagus</em>', 'Fagus', 10, 17, 'ICNafp');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, taxontreedefitem_id, nomenclatural_code, author_agent_id, year_published, nomenclator_guid) 
       values (57, 'Fagus grandiflora', 'Ehrh.', '<em>Fagus grandiflora</em> Ehrh.','grandiflora', 56, 19, 'ICNafp',4,'1788','urn:lsid:ipni.org:names:30060661-2:1.1.2.1');

-- Force population of taxon parentage by after update trigger.  
update taxon set parentage = '1';

-- Real geographies used in the example data 

-- changeset chicoreus:exampleGeographies
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (1, 'Earth', 'Earth', null, '/1', 'http://sws.geonames.org/6295630/',1,1);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (2, 'Europe', 'Europe', 1, '/1/2', 'http://vocab.getty.edu/tgn/1000003',1,2);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (3, 'United Kingdom', 'United Kingdom', 2, '/1/2/3', 'http://sws.geonames.org/2635167/',1,6);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (4, 'Wales', 'Wales', 3, '/1/2/3/4', 'http://sws.geonames.org/2634895/',1,11);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (5, 'Cardiff', 'Wales: Cardiff', 4, '/1/2/3/4/5','http://sws.geonames.org/2653822',1,30);

insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (6, 'North America', 'North and Central America', 1, '/1/6', 'http://vocab.getty.edu/tgn/1000001',1,2);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (7, 'United States', 'United States', 6, '/1/6/7', 'http://www.geonames.org/6252001',1,6);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (8, 'New Hampshire', 'US: New Hampshire', 7, '/1/6/7/8', 'http://www.geonames.org/5090174',1,14);

insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (9, 'Atlantic', 'Atlantic Ocean', 1, '/1/9', 'http://www.geonames.org/',1,32);

insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (10, 'South America', 'South America', 1, '/1/10', '',1,2);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (11, 'Brazil', 'Brazil', 6, '/1/10/11', '',1,6);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (12, 'Maine', 'US: Maine', 7, '/1/6/7/12', '',1,14);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (13, 'High Seas', 'High Seas', 1, '/1/13', '',1,6);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (14, 'US Exclusive Economic Zone', 'US: EEZ', 7, '/1/6/7/14', '',1,35);

insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (15, 'North Atlantic', 'North Atlantic Ocean', 9, '/1/9/15', 'http://www.geonames.org/',1,33);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (16, 'Gulf of Maine', 'Gulf of Maine', 9, '/1/9/15', 'http://www.geonames.org/',1,34);
insert into geography (geography_id, name, full_name, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (17, 'Arizona', 'US: Arizona', 7, '/1/6/7/17', '',1,14);

-- Example catalog number series and collections used in the example data.

-- changeset chicoreus:187
insert into catalognumberseries (catalognumberseries_id, name) values (1,'Example:Botany Accession Numbers');
insert into catalognumberseries (catalognumberseries_id, name) values (2,'Example:Zoology Catalog Numbers');
insert into catalognumberseries (catalognumberseries_id, name) values (3,'Example:Cryogenic Catalog Numbers');

insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (1,'Example:Botany Department','example.com','example.com','Botany Department','http://example.com/',7);
insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (2,'Example:Mammalogy Department','example.com','example.com','Mammalogy Department','http://example.com/',3);
insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (3,'Example:Paleontology Department','example.com','example.com','Paleontology Department','http://example.com/',6);
insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (4,'Example:Malacology Department','example.com','example.com','Malacology Department','http://example.com/',2);
insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (5,'Example:Cryogenic Collection','example.com','example.com','Cryogenic collection','http://example.com/',1);
insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (6,'Example:Entomology Department','example.com','example.com','Entomology Department','http://example.com/',9);
insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (7,'Example:Ichthyology Department','example.com','example.com','Ichthyology Department','http://example.com/', 4);

insert into catnumseriescollection (catalognumberseries_id, collection_id) values (1,1);
-- Example of a catalognumberseries that spans more than one department.
insert into catnumseriescollection (catalognumberseries_id, collection_id) values (2,2);
insert into catnumseriescollection (catalognumberseries_id, collection_id) values (2,3);
insert into catnumseriescollection (catalognumberseries_id, collection_id) values (2,4);
insert into catnumseriescollection (catalognumberseries_id, collection_id) values (3,5);

insert into accession (accession_id, accessionnumber, remarks, scope_id) values (1,'1','Example default accession',1);

-- changeset chicoreus:examplegeology

-- Some minimal geological context information for examples
insert into rocktimeunit (rocktimeunit_id, name, parent_id, parentage, full_name, rocktimeunittreedefitem_id) values (1,'All Time',null,'/1','',1);
insert into rocktimeunit (rocktimeunit_id, name, parent_id, parentage, full_name, rocktimeunittreedefitem_id) values (2,'Phanerozoic',1,'/1/2','Phanerozoic',2);
insert into rocktimeunit (rocktimeunit_id, name, parent_id, parentage, full_name, rocktimeunittreedefitem_id) values (3,'Proterozoic',2,'/1/2/3','Proterozoic',3);
insert into rocktimeunit (rocktimeunit_id, name, parent_id, parentage, full_name, rocktimeunittreedefitem_id) values (4,'Carboniferous',3,'/1/2/3/4','Carboniferous',3);
insert into rocktimeunit (rocktimeunit_id, name, parent_id, parentage, full_name, rocktimeunittreedefitem_id) values (5,'Lower',4,'/1/2/3/4/5','Lower Carboniferous',3);
insert into rocktimeunit (rocktimeunit_id, name, parent_id, parentage, full_name, rocktimeunittreedefitem_id) values (6,'Tournaisian',5,'/1/2/3/4/5/6','Tournaisian',3);

insert into rocktimeunit (rocktimeunit_id, name, parent_id, parentage, full_name, rocktimeunittreedefitem_id) values (7,'All Rocks',null,'/7','',99);
insert into rocktimeunit (rocktimeunit_id, name, parent_id, parentage, full_name, rocktimeunittreedefitem_id) values (8,'Point Limestone',7,'/7/8','Point Limestone Formation',102);

-- The Examples: 

-- changeset chicoreus:exampleCase0SimpleSheet
-- Case 1, simple case, one unit, one organism, one part, one preparation.
-- This corresponds to: Test Case 0 – Several specimens on a sheet, one collecting event, one catalog number (a lot).
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (1, 'Mt. Monadnock','Mount Monadnock', 'Example Locality',8,8);
insert into collector (collector_id, verbatim_collector, etal, remarks) values (1, 'Tuckerman','et al.','Example collector');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (1,'10 Jan, 1880','1880-01-10','1800-01-01');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (1,1,1,1);
insert into unit (unit_id,collectingevent_id,unit_field_number,modified_by_agent_id) values (1,1,'Ex-999',1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (1,1,'001',1,1);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid,remarks) values (1,1,1,1,'urn:uuid:41f908ba-d112-11e6-ac8b-0015c5c8a550', 'TC0 This corresponds to: Test Case 0 – Several (one) specimens on a sheet, one collecting event, one catalog number (a lot). (Simple herbarium sheet example)');
insert into preparation (preparation_id,preparation_type,preservation_type,status) values (1,'sheet','dried','in collection');
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (1,1,1,'branch',1);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (36,'[date not recorded]','1800-01-01','2015-12-31');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (12,1,1,1,36,1); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (2,'15 Jan, 1880','1880-01-15','1880-01-15');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (12,1,0,6,2,0); 

-- SELECT for Case 1 as single row for flat darwin core:
-- select * from identifiableitem ii left join unit u on ii.unit_id = u.unit_id left join part p on ii.identifiableitem_id = p.identifiableitem_id left join preparation pr on p.preparation_id = pr.preparation_id left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id left join locality l on ce.locality_id = l.locality_id left join geography g on l.geopolitical_geography_id = g.geography_id left join identification id on ii.identifiableitem_id = id.identifiableitem_id left join taxon t on id.taxon_id = t.taxon_id left join collector col on ce.collector_id = col.collector_id left join catalogeditem ci on ii.catalogeditem_id = ci.catalogeditem_id left join collection on ci.collection_id = collection.collection_id left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id where catalog_number = '001' and id.is_current = 1;
-- Alternatively:
-- select getHigherGeographyAtRank(l.geopolitical_geography_id,200) as country, g.name, l.specificlocality, coll.preferred_name_string as recordedBy, unit_field_number, dcol.iso_date as dateCollected, getHigherTaxonAtRank(getCurrentIdentTaxonId(ii.identifiableitem_id),140) as family, cco_full.getCurrentIdentification(ii.identifiableitem_id), did.iso_date as dateIdentified, occurrence_guid, institution_code, collection_code, concat(catalognumber_prefix,catalog_number) as catalogNumber, part_name, lot_count, preparation_type, preservation_type from identifiableitem ii left join unit u on ii.unit_id = u.unit_id left join part p on ii.identifiableitem_id = p.identifiableitem_id left join preparation pr on p.preparation_id = pr.preparation_id left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id left join locality l on ce.locality_id = l.locality_id left join geography g on l.geopolitical_geography_id = g.geography_id left join collector col on ce.collector_id = col.collector_id left join catalogeditem ci on ii.catalogeditem_id = ci.catalogeditem_id left join collection on ci.collection_id = collection.collection_id left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id left join eventdate dcol on ce.date_collected_eventdate_id = dcol.eventdate_id left join identification id on ii.identifiableitem_id = id.identifiableitem_id left join eventdate did on id.date_determined_eventdate_id = did.eventdate_id left join agent coll on col.agent_id = coll.agent_id where catalog_number = '001' and id.identification_id = getCurrentIdentId(ii.identifiableitem_id) ;

-- changeset chicoreus:exampleCase0lotofsnails
-- This corresponds to: Test Case 0 – Several specimens on a sheet, one collecting event, one catalog number (a lot).
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (9, '30 miles SE of Mt Desert Island','Off the Coast of Maine; 30 miles Southeast of Mt Desert Island.', 'Example marine Locality',14,16);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (23,'8-10 62','1962-08-10','1962-08-10');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (9, null, 'A. Jones','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (9,9,9,23);
insert into unit (unit_id,collectingevent_id,unit_field_number,modified_by_agent_id) values (9,9,'62-500',1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (11,2,'00234',1,4);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid,remarks) values (10,9,11,45,'urn:uuid:0880242c-05ce-47f2-a666-0f3add191c2b', 'TC0Z This corresponds to: Test Case 0 – Several specimens on a sheet, one collecting event, one catalog number (a lot). (Marine mollusk example)');
insert into preparation (preparation_id,preparation_type,preservation_type,status) values (10,'shells','dry','in collection');
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (13,10,10,'shell',45);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (24,'15 Feb, 2004','2004-02-15','2004-02-15');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id,date_determined_eventdate_id,is_filed_under) values (31,10,1,1,24,1); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (25,'18 Feb, 1983','1983-02-18','1983-02-18');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (31,10,0,12,25,0); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, is_filed_under) values (31,10,0,13,0); 


-- SELECT for Case 2 as two rows (one per dwc:occurrenceId) for flat DarwinCore.
-- select getHigherGeographyAtRank(l.geopolitical_geography_id,200) as country, g.name, l.specificlocality, coll.preferred_name_string as recordedBy, unit_field_number, dcol.iso_date as dateCollected, getHigherTaxonAtRank(getCurrentIdentTaxonId(ii.identifiableitem_id),140) as family, cco_full.getCurrentIdentification(ii.identifiableitem_id) as scientificName, cco_full.getCurrentIdentDateIdentified(ii.identifiableitem_id) as dateIdentified,  trim(concat(individual_count, ' ', ifnull(individual_count_modifier,''))) as numberOfIndividuals, occurrence_guid as occurrenceId, institution_code, collection_code, cco_full.getCatalogNumbers(ii.identifiableitem_id) as catalogNumber, cco_full.getparts(ii.identifiableitem_id) as parts, cco_full.getPreparations(ii.identifiableitem_id) as preparations from identifiableitem ii left join unit u on ii.unit_id = u.unit_id left join part p on ii.identifiableitem_id = p.identifiableitem_id left join preparation pr on p.preparation_id = pr.preparation_id left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id left join locality l on ce.locality_id = l.locality_id left join geography g on l.geopolitical_geography_id = g.geography_id left join collector col on ce.collector_id = col.collector_id left join catalogeditem ci on pr.catalogeditem_id = ci.catalogeditem_id left join collection on ci.collection_id = collection.collection_id left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id left join eventdate dcol on ce.date_collected_eventdate_id = dcol.eventdate_id left join identification id on ii.identifiableitem_id = id.identifiableitem_id left join agent coll on col.agent_id = coll.agent_id where catalog_number = '002' and ci.catalognumberseries_id = 1 and id.identification_id = getCurrentIdentId(ii.identifiableitem_id);


-- changeset chicoreus:exampleCase1ComparativeSpecCat
-- Test Case 1 – Several specimens on a sheet, each cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, each with a catalog number.
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (4, 'Mt. Greylock','Mount Greylock', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (8,'July 15, 83','1883-07-15','1883-07-15');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (4, 6, 'Tuckerman','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (4,4,4,8);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (4,4,'Ex-99904','TC1 This corresponds to one specimen from: Test Case 1 – Comparative Mount (specimen cataloged): Several specimens on a sheet, each cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, each with a catalog number. (first specimen)',1);
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (5, 'Mt. Washignton','Mount Washington', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (9,'July 5, 1882','1882-07-05','1882-07-05');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (5, 6, 'Tuckerman','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (5,5,5,9);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (5,5,'Ex-88804','TC1 This corresponds to one specimen from: Test Case 1 – Comparative Mount (specimen cataloged): Several specimens on a sheet, each cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, each with a catalog number. (second specimen)',1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (5,1,'004-a',1,1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (6,1,'004-b',1,1);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (5,4,5,1,'urn:uuid:abffe64d-a1b2-4f70-9916-186397345a13');
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (6,5,6,1,'urn:uuid:70657b0b-ef91-4b5e-b0c6-14039e6b3366');
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (5,'sheet','dried','in collection',null);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (6,5,5,'dried plant',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (7,6,5,'dried plant',1);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date,end_date) values (10,'1884','1884','1884-01-01','1884-12-31');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date,end_date) values (11,'1884','1884','1884-01-01','1884-12-31');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (12,'15 Mar, 2006','2006-03-15','2006-03-15');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (13,'15 Mar. 2006','2006-03-15','2006-03-15');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) 
    values (12,5,1,1,12,1); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) 
    values (12,5,0,6,10,1); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) 
    values (12,6,1,1,13,1); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) 
    values (12,6,0,6,11,1); 

-- changeset chicoreus:exampleCase2ComparativeSheetCat
-- Test Case 2 –Several specimens on a sheet, sheet cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, under a single catalog number.
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (6, 'Mt. Greylock','Mount Greylock', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (14,'Aug 15, 83','1983-08-15','1983-08-15');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (6, 8, 'Heiser','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (6,6,6,14);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (6,6,'Ex-99905','TC2 This corresponds to one specimen from: Test Case 2 – Comparative Mount (sheet cataloged): Several specimens on a sheet, sheet cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, under a single catalog number. (first specimen)',1);
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (7, 'Mt. Washignton','Mount Washington', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (15,'July 5, 1881','1881-07-05','1881-07-05');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (7, 6, 'Tuckerman','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (7,7,7,15);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (7,7,'Ex-88805','TC2 This corresponds to one specimen from: Test Case 2 – Comparative Mount (sheet cataloged) Several specimens on a sheet, sheet cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, under a single catalog number. (second specimen)',1);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (7,6,null,1,'urn:uuid:c91c0242-6cc4-4865-b139-c443266e71cd');
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (8,7,null,1,'urn:uuid:7860e7ea-7eca-4e12-80de-09c2b9ae0bf8');
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (7,1,'005',1,1);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (6,'sheet','dried','in collection',7);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (8,7,6,'dried plant',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (9,8,6,'dried plant',1);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date,end_date) values (16,'1884','1884','1884-01-01','1884-12-31');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date,end_date) values (17,'1884','1884','1884-01-01','1884-12-31');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (18,'15 Mar, 2006','2006-03-15','2006-03-15');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (19,'15 Mar. 2006','2006-03-15','2006-03-15');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) 
    values (12,7,1,1,18,1); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) 
    values (12,7,0,8,16,1); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) 
    values (12,8,1,1,19,1); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) 
    values (12,8,0,6,17,1); 

-- changeset chicoreus:exampleCase3SpecimenMultipleSheets
-- Test Case 3 –One biological individual in several specimens on several sheets, each sheet cataloged.  One biological individual, several cataloged, loanable preparations of the same type, each with a catalog number.
-- Palm leaves that span multiple sheets.

insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (8, 'Passeio publico','Rio de Janeiro; Passeio Publico [public park]', 'Example Locality', 11, 11);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (20,'10/4/1875','1875-10-04','1875-10-04');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (8, 9, 'A.F.M. Glaziou','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (8,8,8,20);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (8,8,'8063','TC3 This corresponds to Test Case 3 – One biological individual in several specimens on several sheets, each sheet cataloged.  One biological individual, several cataloged, loanable preparations of the same type, each with a catalog number.  (Leaves from a palm tree spread across several sheets)',1);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (9,8,null,1,'urn:uuid:2535a8b8-a7bc-40a5-b0d7-38614c67291e');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date,end_date) values (21,'1875','1875','1875-01-10','1875-12-31');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (22,'15 Mar. 2006','2006-03-15','2006-03-15');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) 
    values (27,9,1,1,22,1); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) 
    values (28,9,0,9,21,0); 
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (8,1,'006',1,1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (9,1,'007',1,1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (10,1,'008',1,1);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (7,'sheet','dried','in collection',8);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (8,'sheet','dried','in collection',9);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (9,'sheet','dried','in collection',10);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (10,9,7,'dried plant',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (11,9,8,'dried plant',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (12,9,9,'dried plant',1);

-- changeset chicoreus:exampleCase3aLotPrepsCataloged
-- Case 3, lot of one organism but two preparations (with the preparations cataloged)
-- This corresponds to: Test Case 3a –One biological individual in several specimens of several different preparation types, each preparation cataloged.  One biological individual, several cataloged, loanable preparations of different types, each with a catalog number (potentially in different catalog number series or even collections).
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id,geographic_geography_id) values (3, 'Cardiff Bay','Cardiff Bay', 'Example Locality',5,9);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (6,'4-10 62','1962-04-10','1962-04-10');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (3, null, 'A. Jones','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (3,3,3,6);
insert into unit (unit_id,collectingevent_id,unit_field_number,modified_by_agent_id) values (3,3,'62-153',1);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid,remarks) values (4,3,null,30,'urn:uuid:900d240e-5d85-4b5b-b8c2-b9e97db34c51','TC3a This corresponds to: Test Case 3a –One biological individual in several specimens of several different preparation types, each preparation cataloged.  One biological individual, several cataloged, loanable preparations of different types, each with a catalog number.');
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (3,2,'Z0001',1,4);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (4,2,'Z0002',1,4);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (3,'tray','dry','in collection',3);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (4,'jar','70% ethanol','in collection',4);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (4,4,3,'shell',30);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (5,4,4,'viscera',1);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date,end_date) values (7,'1980','1980','1980-01-01','1980-12-31');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (17,4,1,6,7,1); 
-- SELECT for Case 3 as one row for flat DarwinCore.
-- select distinct getHigherGeographyAtRank(l.geopolitical_geography_id,200) as country, g.name, l.specificlocality, ifnull(coll.preferred_name_string,verbatim_collector) as recordedBy, unit_field_number, dcol.iso_date as dateCollected, getHigherTaxonAtRank(getCurrentIdentTaxonId(ii.identifiableitem_id),140) as family, cco_full.getCurrentIdentification(ii.identifiableitem_id) as scientificName,  trim(concat(individual_count, ' ', ifnull(individual_count_modifier,''))) as numberOfIndividuals, did.iso_date as dateIdentified, occurrence_guid, institution_code, collection_code, cco_full.getCatalogNumbers(ii.identifiableitem_id) as catalogNumber, cco_full.getparts(ii.identifiableitem_id) as parts, cco_full.getPreparations(ii.identifiableitem_id) as preparations from identifiableitem ii left join unit u on ii.unit_id = u.unit_id left join part p on ii.identifiableitem_id = p.identifiableitem_id left join preparation pr on p.preparation_id = pr.preparation_id left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id left join locality l on ce.locality_id = l.locality_id left join geography g on l.geopolitical_geography_id = g.geography_id left join collector col on ce.collector_id = col.collector_id left join catalogeditem ci on pr.catalogeditem_id = ci.catalogeditem_id left join collection on ci.collection_id = collection.collection_id left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id left join eventdate dcol on ce.date_collected_eventdate_id = dcol.eventdate_id left join identification id on ii.identifiableitem_id = id.identifiableitem_id left join eventdate did on id.date_determined_eventdate_id = did.eventdate_id left join agent coll on col.agent_id = coll.agent_id where ( catalog_number = 'Z0001' or catalog_number = 'Z0002' ) and id.identification_id = getCurrentIdentId(ii.identifiableitem_id) and ci.catalognumberseries_id = 2;

-- SELECT for Case 3 as two rows (one per preparation, sharing the same dwc:occurrenceId), needs reduction for flat DarwinCore.
-- select * from identifiableitem ii left join unit u on ii.unit_id = u.unit_id left join part p on ii.identifiableitem_id = p.identifiableitem_id left join preparation pr on p.preparation_id = pr.preparation_id left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id left join locality l on ce.locality_id = l.locality_id left join geography g on l.geopolitical_geography_id = g.geography_id left join identification id on ii.identifiableitem_id = id.identifiableitem_id left join taxon t on id.taxon_id = t.taxon_id left join collector col on ce.collector_id = col.collector_id left join catalogeditem ci on pr.catalogeditem_id = ci.catalogeditem_id left join collection on ci.collection_id = collection.collection_id left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id where ( catalog_number = 'Z0001' or catalog_number = 'Z0002' ) and ci.catalognumberseries_id = 2;

-- changeset chicoreus:exampleCase4SpecimenMultiplePreps
-- Test Case 4 – Series of derived preparations.  One biological individual, several cataloged, loanable preparations of different types,  some sharing a catalog number, others with different numbers.

-- TODO: Derived preparation (DNA Extract) isn't listed in preparations retrieved with function.

insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (10, 'Near Richmond','Near Richmond, NH', 'Example locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (26,'22 Dec, 98','1998-12-22','1998-12-22');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (10, 14, 'H. Tolman','and students');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (10,10,10,26);
insert into unit (unit_id,collectingevent_id,unit_field_number,modified_by_agent_id) values (10,10,'35',1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (12,2,'00532',1,2);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (13,2,'00533',1,2);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (14,3,'7539365',1,5);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (15,3,'7539733',1,5);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (16,2,'00534',1,2);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid,remarks) values (11,10,null,1,'urn:uuid:2ec1860d-112a-465f-ab39-1e0ec754923e', 'TC4 This corresponds to: Test Case 4 – Series of derived preparations.  One biological individual, several cataloged, loanable preparations of different types,  some sharing a catalog number, others with different numbers, includes a derived preparation. (Mammology/Cryogenic example (part of animal cataloged in one collection, part in another)).');
insert into preparation (preparation_id,preparation_type,preservation_type,status,catalogeditem_id) values (11,'partial animal','dry','in collection',12);
insert into preparation (preparation_id,preparation_type,preservation_type,status,catalogeditem_id) values (13,'partial animal','70% ethanol','in collection',13);
insert into preparation (preparation_id,preparation_type,preservation_type,status,catalogeditem_id) values (14,'frozen tissue','liquid nitrogen','in collection',14);
insert into preparation (preparation_id,preparation_type,preservation_type,status,catalogeditem_id) values (15,'hide','dry','in collection',16);
insert into preparation (preparation_id,preparation_type,preservation_type,status,catalogeditem_id,parent_preparation_id) values (16,'DNA Extract','liquid nitrogen','in collection',15,14);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (14,11,11,'skull',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (15,11,11,'partial postcranial skeleton',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (16,11,15,'hide',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (17,11,13,'forelimb',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (18,11,14,'liver tissue',1);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (27,'15 Feb, 2005','2005-02-15','2005-02-15');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id,date_determined_eventdate_id,is_filed_under) values (22,11,1,13,27,1); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (28,'18 Feb, 1999','1999-02-18','1999-02-18');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (22,11,0,14,28,0); 
insert into biologicalattribute (name,value,identifiableitem_id) values ('sex','female',11);

-- changset chicoreus:exampleCase5MixedCollectionAnts
-- Test case for an ethanol vial and a set of pinned ants from one ant hill with an associated species (inquiline ant) along with an ant on one of the pins.

insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (11, 'Near Tuscon AZ','Near Tuscon', 'Example Locality',17,17); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (29,'10 Feb, 2002','2002-02-10','2002-02-10');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (11, 15, 'SP Cover','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (11,11,11,29);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (11,11,'SPC9999','TC5 Zoo. This corresponds to: Test Case 5 – Mixed Collection with a single catalog number.  Multiple biological individuals of different species, single physical loanable preparation.  Single catalog number on the preparation. (Ant and other species on a pin) Extended to include additional cataloged items from the same unit.',1);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (12,11,null,30,'urn:uuid:99342b96-425e-46b0-a562-4fd784dab81d'); -- The ants from the nest
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid,remarks) values (13,11,null,1,'urn:uuid:112d6f77-3e1e-4bbb-ae74-f0362242c228','inquiline'); -- The inquilline ant
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (17,2,'06031',1,6);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (18,2,'30031',1,6);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (19,2,'30032',1,6);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (17,'vial','70% ethanol','in collection',17);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (18,'pin','dried','in collection',18);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (19,'pin','dried','in collection',19);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,remarks) values (19,12,17,'whole organism',27,'vial of unsorted ants from nest');
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,remarks) values (20,12,18,'whole organism',1,'queen');
insert into biologicalattribute (name,value,part_id) values ('caste','queen',20);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,remarks) values (21,12,18,'whole organism',1,'worker');
insert into biologicalattribute (name,value,part_id) values ('caste','worker',21);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,remarks) values (22,12,19,'whole organism',1,'worker'); -- ant pinned with inquilline
insert into biologicalattribute (name,value,part_id) values ('caste','worker',22);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,remarks) values (23,13,19,'whole organism',1,'inquiline'); -- inquiline pinned with ant
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (30,'15 Mar, 2005','2005-03-15','2005-03-15');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (31,'15 Mar, 2005','2005-03-15','2005-03-15');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (35,12,1,15,29,1); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (36,13,1,15,30,0); 

-- changeset chicoreus:exampleCase5MixedCollPrepCataloged
-- Case [2], packet with two organisms (lichen on bark in packet), with the packet being the cataloged object,
-- thus (one catalog number and two occurrences).
-- This corresponds to: Test Case 5 – Mixed Collection with a single catalog number.  Multiple biological individuals of different species, one physical loanable preparation.  Single catalog number on the preparation.
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (2, 'Mt. Adams','Mount Adams', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (3,'10 Feb, 1882','1882-02-10','1882-02-10');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (2, 6, 'Tuckerman','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (2,2,2,3);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (2,2,'Ex-9999','TC5 Bot. This corresponds to: Test Case 5 – Mixed Collection with a single catalog number.  Multiple biological individuals of different species, one physical loanable preparation.  Single catalog number on the preparation.',1);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (2,2,null,1,'urn:uuid:32dfd81a-b2af-416c-b797-d610281ca15a');
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (3,2,null,1,'urn:uuid:1d3c8962-8dbe-4255-89e0-3828fb30827a');
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (2,1,'002',1,1);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (2,'packet','dried','in collection',2);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (2,2,2,'whole organism',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (3,3,2,'bark fragment',1);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (4,'10 Feb, 1882','1882-02-10','1882-02-10');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (5,'10 Feb, 1882','1882-02-10','1882-02-10');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (8,2,1,6,4,1); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (12,3,1,6,5,0); 
-- changeset chicoreus:exampleCase5aMixedCollSpecCataloged
-- Test Case 5a – Mixed Collection with multiple catalog numbers Multiple biological individuals of different species, each with a catalog number, one physical loanable preparation (fossil slab with several cataloged specimens).

insert into paleocontext (paleocontext_id, verbatim_geologic_context, verbatim_lithology, lithology, is_float, earlyest_geochronologic_unit_id, latest_geochronologic_unit_id, lithostratigraphic_unit_id) values (1,'Point Ls, Carb.','Dolomite','Dolomite','No', 6,6,8);
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id,geographic_geography_id,paleocontext_id) values (12, 'Ty nant quarry, NW of Cardiff','Ty-nant Quarry, NW of Cardiff', 'Example fossil Locality',5,5,1);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (32,'12/12/04','2004-12-12','2004-12-12');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (12, 16, 'M. Basset','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (12,12,12,32);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (12,12,'04352','TC5a This corresponds to: - Test Case 5a – Mixed Collection with multiple catalog numbers Multiple biological individuals of different species, each with a catalog number, one physical loanable preparation (fossil slab with several cataloged specimens).',1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (20,2,'634636',1,3);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (21,2,'634637',1,3);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (22,2,'634638',1,3);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (14,12,20,3,'urn:uuid:f1aa99b8-1eb0-48b1-b5c1-3a57c83b65ff'); 
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (15,12,21,1,'urn:uuid:5f13b184-4f8a-4b17-b498-b01e44c8860f'); 
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (16,12,22,1,'urn:uuid:2125aa36-b301-44d1-b326-0e34888cdf85');
insert into preparation (preparation_id,preparation_type,preservation_type,status,catalogeditem_id) values (20,'slab','in tray','in collection',null);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,remarks) values (24,14,20,'impression',1,'');
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,remarks) values (25,14,20,'fragment',2,'');
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,remarks) values (26,15,20,'impression',1,'');
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,remarks) values (27,16,20,'impression',1,'');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (33,'12/12/06','2006-12-12','2006-12-12');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (34,'12/12/06','2006-12-12','2006-12-12');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (35,'12/12/06','2006-12-12','2006-12-12');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (42,14,1,17,33,0); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (45,15,1,17,34,0); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (48,16,1,17,35,1); 


-- changeset chicoreus:exampleCase6MixedCollectionWithPreps
-- Test Case 6 – Mixed Collection with derivatives.  Multiple biological individuals of different species, more than one physical loanable preparation (a mixed collection in a packet, with a slide that has been prepared from one of the taxa present in the mixed collection)
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (13, 'SE slopes of Mt. Adams','SE slopes of Mount Adams', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (37,'11 Feb, 1882','1882-02-11','1882-02-11');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (13, 6, 'Tuckerman','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (13,13,13,37);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (13,13,'Ex-19999','TC6 This corresponds to: - Test Case 6 – Mixed Collection with derivatives.  Multiple biological individuals of different species, more than one physical loanable preparation (a mixed collection in a packet, with a slide that has been prepared from one of the taxa present in the mixed collection)',1);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (17,13,null,1,'urn:uuid:4fcd294f-f04b-4dd1-b01e-20062a1f1ecb');
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (18,13,null,1,'urn:uuid:b2da61f3-5a22-4c59-bd31-b82d3d3c9d19');
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (19,13,null,1,'urn:uuid:bac560b7-9808-4f1a-8b60-bf3edf5a92b8');
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (23,1,'52523',1,1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (24,1,'7234',1,1);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (21,'packet','dried','in collection',23);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (22,'slide','glycerine','in collection',24);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (28,17,21,'whole organism',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (29,17,22,'fragment',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (30,18,21,'bark fragment',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (31,19,21,'whole organism',1);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (38,'10 Feb, 1882','1882-02-10','1882-02-10');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (39,'10 Feb, 1882','1882-02-10','1882-02-10');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (40,'10 Feb, 1882','1882-02-10','1882-02-10');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (50,17,0,6,38,0); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (12,18,1,6,39,0); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (50,19,0,6,40,0); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (41,'10 Feb, 2002','2002-02-10','2002-02-10');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (42,'10 Feb, 2002','2002-02-10','2002-02-10');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (8,17,1,1,41,1); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (49,19,1,1,42,0); 

-- changeset chicoreus:exampleDina1FishLotDetOnOneSpec

-- Case from DINA TC Call 2017 Jan 24
-- Jar of 10 fish
-- Set of 10 frozen tissue samples
-- One frozen tissue sample has had identification made based on sequence.
-- One fish has identificaiton made on sequence
-- Other 9 fish have indentification infered from sequence
-- All 10 fish live in the same jar (one preparation)
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (14, '51:13:31.4N 033:05:01.3W','North Atlantic: 51.2254,-330837', 'Example high seas Locality',13,15);  -- high seas, north atlantic
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (43,'04/VII/2016','2016-07-04','2016-07-04');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (14, null, 'K. Hartel','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (14,14,14,43);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (14,14,'T45070434','TCDina1 This corresponds to: - Test Case DINA-1 – Single lot with individuals subsampled and indentified with different means. (Jar of 10 fish, one subsampled and identified based on sequence).',1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (25,2,'75643',1,7);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (26,2,'75644',1,7);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (27,2,'75644.a',1,7);  
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (20,14,25,9,'urn:uuid:18feed16-a5fc-4c3c-8251-85bf9b464ca1');
-- If we treat this as the same occurrence, then queries to get flat darwin core get much more complex than if we treat this as a separate occurrence.
-- It isn't really a separate occurrence, what differs is the evidence behind the identification.
-- insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (21,14,26,1,'urn:uuid:18feed16-a5fc-4c3c-8251-85bf9b464ca1');
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (21,14,26,1,'urn:uuid:02fc0f5f-1d3c-4216-92a2-9b194e4b6f27');
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (23,'jar','70% Ethanol','in collection',null);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (24,'cryovial','frozen','in collection',27);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (32,20,23,'whole organism',9);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (33,21,23,'whole organism',1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (34,21,24,'tissue',1);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (44,'10 May, 2015','2015-05-10','2015-05-10');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (45,'10 May, 2015','2015-05-10','2015-05-10');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under,method,remarks) values (55,20,1,1,45,1,'Morphology','Inferred from sequence of 75644.a'); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under,method) values (55,21,1,1,44,0,'Sequence'); 

-- changeset chicoreus:exampleDina2ResampledIndividual

-- Case from DINA TC Call 2017 Jan 24

-- One tree, resampled multiple times, one herbarium sheet for each resampling event.  
-- In essence, three herbarium sheets, collections at different times, three occurrences, three preparations, 
-- but all from the same locality, and all linked to the same biological individual.
-- CCO_FULL can model this with the addition of a biological individual entity linked to part.  
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (15, 'WS4 HB LTER','Tree Core Plot, Watershed 4, Hubbard Brook LTER', 'Example Locality',8,8); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (46,'04/7 86','1986-07-04','1986-07-04');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (15, null, 'B. Herb','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (15,15,15,46);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (47,'04//7 1996','1996-07-04','1996-07-04');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (16,15,15,47);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (48,'2016/07/04','2016-07-04','2016-07-04');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (16, null, 'E. Denny','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (17,15,16,48);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (15,15,'ST1-TR1-a','TCDina2 This corresponds to: - Test Case DINA-2, repeated sampling of the same biological individual over time. (first sampling)',1);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (16,16,'ST1-TR1-b','TCDina2 This corresponds to: - Test Case DINA-2, repeated sampling of the same biological individual over time. (second sampling)',1);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks,modified_by_agent_id) values (17,17,'ST1-TR1-c','TCDina2 This corresponds to: - Test Case DINA-2, repeated sampling of the same biological individual over time. (third sampling)',1);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (28,1,'0091516',1,1);  
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (29,1,'0151553',1,1);  
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (30,1,'0835219',1,1);  
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (22,15,28,1,'urn:uuid:300c5131-b1a6-4fd6-8a78-8b8276c6472c');
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (23,16,29,1,'urn:uuid:e4153484-ab26-493c-a5dc-85cbec9d3dab');
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (24,17,23,1,'urn:uuid:36aa7cb8-3ee1-40bb-b086-4456bf962dd1');
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (25,'sheet','dried','in collection',null);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (26,'sheet','dried','in collection',null);
insert into preparation (preparation_id,preparation_type,preservation_type,status, catalogeditem_id) values (27,'sheet','dried','in collection',null);
-- all looking like three different gatherings of the same taxon from the same locality, until here, all are linked to one biological individual.
insert into biologicalindividual(biologicalindividual_id, biologicalindividual_guid, name) values (1,'urn:uuid:c09c0024-77a9-4873-b01e-33719ebfb2d3','ST1-TR1');
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,biologicalindividual_id) values (35,22,25,'branch',1,1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,biologicalindividual_id) values (36,23,26,'branch',1,1);
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count,biologicalindividual_id) values (37,24,27,'branch',1,1);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (49,'04/7 86','1986-07-04','1986-07-04');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (57,22,1,1,49,1); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (50,'04//7 1996','1996-07-04','1996-07-04');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (57,23,1,1,50,1); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (51,'2016/07/04','2016-07-04','2016-07-04');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (57,24,1,1,51,1); 

-- Retrieve all examples as flat DarwinCore
select distinct 
    getHigherGeographyAtRank(l.geopolitical_geography_id,200) as country, 
    g.name, 
    l.specificlocality, 
    cco_full.getCollector(ce.collector_id) as recordedBy, 
    unit_field_number, 
    dcol.iso_date as dateCollected, 
    getHigherTaxonAtRank(getCurrentIdentTaxonId(ii.identifiableitem_id),140) as family, 
    cco_full.getCurrentIdentification(ii.identifiableitem_id) as scientificName, 
    cco_full.getCurrentIdentDateIdentified(ii.identifiableitem_id) as dateIdentified, 
    trim(concat(individual_count, ' ', ifnull(individual_count_modifier,''))) as numberOfIndividuals, 
    occurrence_guid as occurrenceId, 
    cco_full.getInstitutionCode(ii.identifiableitem_id) as institutionCode,
    cco_full.getCollectionCode(ii.identifiableitem_id) as collectionCode, 
    cco_full.getCatalogNumbers(ii.identifiableitem_id) as catalogNumber, 
    cco_full.getparts(ii.identifiableitem_id) as parts, 
    cco_full.getPreparations(ii.identifiableitem_id) as preparations, 
    concat(ifnull(u.remarks,''), ifnull(ii.remarks,'')) as remarks 
from identifiableitem ii 
     left join unit u on ii.unit_id = u.unit_id 
     -- left join part p on ii.identifiableitem_id = p.identifiableitem_id 
     -- left join preparation pr on p.preparation_id = pr.preparation_id 
     left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id 
     left join locality l on ce.locality_id = l.locality_id 
     left join geography g on l.geopolitical_geography_id = g.geography_id 
     -- left join collector col on ce.collector_id = col.collector_id 
     -- left join catalogeditem ci on pr.catalogeditem_id = ci.catalogeditem_id 
     -- left join collection on ci.collection_id = collection.collection_id 
     -- left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id 
     left join eventdate dcol on ce.date_collected_eventdate_id = dcol.eventdate_id 
     -- left join identification id on ii.identifiableitem_id = id.identifiableitem_id 
     -- left join agent coll on col.agent_id = coll.agent_id;
order by remarks;

-- The last liquibase changeset in this file was number 196

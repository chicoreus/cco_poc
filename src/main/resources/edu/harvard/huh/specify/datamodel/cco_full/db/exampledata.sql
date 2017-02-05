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
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (2, 'Fungi', 'Fungi','Fungi', 1, '/1/2',2, 10, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (3, 'Animalia', 'Animalia','Animalia', 1, '/1/3',2, 10, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (4, 'Plantae', 'Plantae','Plantae', 1, '/1/4',2, 10, 'ICNafp');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (5, 'Parmeliaceae', 'Parmeliaceae','Parmeliaceae', 2, '/1/2/5',14, 140, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (6, 'Xanthoparmelia', '<em>Xanthoparmelia</em>', 'Xanthoparmelia', 5, '/1/2/5/6',17, 180, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (7, 'Lichen', '<em>Lichen</em>','Lichen', 2, '/1/2/7',17, 180, 'ICNafp');

insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, parauthor_agent_id, parexauthor_agent_id, author_agent_id, year_published, nomenclator_guid) 
       values (8, 'Xanthoparmelia conspersa', '(Ehrh. ex Ach.) Hale', '<em>Xanthoparmelia conspersa</em> (Ehrh. ex Ach.) Hale','conspersa', 6, '/1/2/5/6/8',19, 220, 'ICNafp',4,5,3, '(1974)', 'urn:lsid:indexfungorum.org:names:343884');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, author_agent_id, exauthor_agent_id, year_published, accepted_taxon_id, nomenclator_guid) 
       values (9, 'Lichen conspersus', 'Ehrh. ex Ach.', '<em>Lichen conspersus</em> Ehrh. ex Ach.','conspersus', 7, '/1/2/7/9',19, 220, 'ICNafp',4,5,'1799 [1798]',7, 'urn:lsid:indexfungorum.org:names:393893');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (10, 'Fagaceae', 'Fagaceae', 'Fagaceae',  4, '/1/4/10',14, 140, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (11, 'Quercus', '<em>Quercus</em>', 'Quercus', 10, '/1/4/10/11',17, 180, 'ICNafp');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, author_agent_id, year_published, nomenclator_guid) 
       values (12, 'Quercus alba', 'L.', '<em>Quercus alba</em> L.','alba', 11, '/1/4/10/11/12',19, 220, 'ICNafp',2,'1753','urn:lsid:ipni.org:names:295763-1:1.2.2.1.1.3');


insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (13, 'Mollusca', 'Mollusca', 'Mollusca', 3, '/1/3/13', 4, 30, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (14, 'Gastropoda', 'Gastropoda', 'Gastropoda', 13, '/1/3/13/14', 7, 60, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (15, 'Littorinidae', 'Littorinidae', 'Littorinidae', 14, '/1/3/13/14/15', 14, 140, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (16, 'Littorina', 'Littorina', 'Littorina', 15, '/1/3/13/14/15/16', 17, 180, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, parauthor_agent_id, year_published, nomenclator_guid) 
       values (17, 'Littorina littorea', '(Linnaeus, 1758)', '<em>Littorina littorea</em> (Linnaeus, 1758)', 'littorea', 16, '/1/3/13/14/15/16/17', 19, 220, 'ICZN',2,'1758','urn:lsid:marinespecies.org:taxname:140262');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (18, 'Chordata', 'Chordata', 'Chordata', 3, '/1/3/18', 4, 30, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (19, 'Mammalia', 'Mammalia', 'Mammalia', 18, '/1/3/18/19', 7, 60, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (20, 'Cannidae', 'Canidae', 'Canidae', 19, '/1/3/18/19/20', 14, 140, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, authorship, author_agent_id, year_published,remarks,nomenclator_guid)
       values (21, 'Vulpes', 'Vulpes', 'Vulpes', 20, '/1/3/18/19/20/21', 17, 180, 'ICZN','Frisch, 1775',7,'1775','While Frisch (1775) is a rejected work (ICZN Opinion 258, 1954), Vulpes has been retained (ICZN Opinion 1129, 1979).  Have not confirmed that Frisch, Johann Leonhard 1737-1795 is the Johann Leonhard Frisch who authored this work, but, but this work (Das Natur-System der Vierfußigen Thiere) is not in the biographical record of Frisch, Johann Leonhard, 1666-1743 from Berlin-Brandenburgische Akademie der Wissenschaften Akademiebibliothek.','urn:lsid:marinespecies.org:taxname:404129');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, parauthor_agent_id, year_published, nomenclator_guid) 
       values (22, 'Vulpes vulpes', 'Linnaeus, 1758', '<em>Vulpes vulpes</em> Linnaeus, 1758', 'vulpes', 21, '/1/3/18/19/20/21/22', 19, 220, 'ICZN',2,'1758','http://www.departments.bucknell.edu/biology/resources/msw3/browse.asp?s=y&id=14000892');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (23, 'Angiospermae', 'Angiospermae', 'Angiospermae', 4, '/1/4/23', 7, 60, 'ICNafp');

update taxon set parent_id = 23, parentage = '/1/4/23/10' where taxon_id = 10;
update taxon set parentage = '/1/4/23/10/11' where taxon_id = 11;
update taxon set parentage = '/1/4/23/10/11' where taxon_id = 11;

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (24, 'Arecaceae', 'Arecaceae', 'Arecaceae', 23, '/1/4/23/24', 14, 140, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (25, 'Cocos', '<em>Cocos</em>', 'Cocos', 24, '/1/4/23/24/25',17, 180, 'ICNafp');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (26, 'Syagrus', '<em>Syagrus</em>', 'Syagrus', 24, '/1/4/23/24/26',17, 180, 'ICNafp');

-- 27 Syagrus oleracea (Martius) Beccari
-- Syagrus oleracea (Martius 10) Beccari 11
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, author_agent_id, parauthor_agent_id, year_published, nomenclator_guid) 
       values (27, 'Syagrus oleracea', '(Mart.) Becc.', '<em>Syagrus oleracea</em> (Mart.) Becc.','oleracea', 26, '/1/4/23/24/26/27',19, 220, 'ICNafp',11, 10,'','urn:lsid:ipni.org:names:1177502-2:1.3');

-- 28  Cocos oleracea Martius
-- Cocos oleracea Martius 10
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, author_agent_id, year_published, nomenclator_guid) 
       values (28, 'Cocos oleracea', 'Mart.', '<em>Cocos oleracea</em> Mart.','oleracea', 25, '/1/4/23/24/25/28',19, 220, 'ICNafp',10,'','urn:lsid:ipni.org:names:62615-2:1.2');

-- Janthinidae 
-- Janthina janthina (Linnaeus, 1758)  urn:lsid:marinespecies.org:taxname:140155
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (29, 'Janthinidae', 'Janthinidae', 'Janthinidae', 14, '/1/3/13/14/29', 14, 140, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (30, 'Janthina', 'Janthina', 'Janthina', 29, '/1/3/13/14/29/30', 17, 180, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, parauthor_agent_id, year_published, nomenclator_guid) 
       values (31, 'Janthina janthina', '(Linnaeus, 1758)', '<em>Janthina janthina</em> (Linnaeus, 1758)', 'janthina', 16, '/1/3/13/14/29/30/31', 19, 220, 'ICZN',2,'1758','urn:lsid:marinespecies.org:taxname:140155');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (32, 'Arthropoda', 'Arthropoda', 'Arthropoda', 3, '/1/3/32', 4, 30, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (33, 'Formicidae', 'Formicidae', 'Formicidae', 32, '/1/3/32/33', 14, 140, 'ICZN');

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (34, 'Pogonomyrmex', 'Pogonomyrmex', 'Pogonomyrmex', 33, '/1/3/32/33/34', 17, 180, 'ICZN');

-- Pogonomyrmex colei, inquiline in Pogonomyrmex rugosus nests
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, year_published, nomenclator_guid) 
       values (35, 'Pogonomyrmex rugosus', 'Emery, 1895', '<em>Pogonomyrmex rugosus</em> Emery, 1895', 'rugosus', 34, '/1/3/32/33/34/35', 19, 220, 'ICZN','1895',null);
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, year_published, nomenclator_guid) 
       values (36, 'Pogonomyrmex colei', 'Emery, 1982', '<em>Pogonomyrmex colei</em> Emery, 1982', 'colei', 34, '/1/3/32/33/34/36', 19, 220, 'ICZN','1895',null);

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (37, 'Brachiopoda', 'Brachiopoda', 'Brachiopoda', 3, '/1/3/37', 4, 30, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (38, 'Rhynchonellata', 'Rhynchonellata', 'Rhynchonellata', 37, '/1/3/37/38', 7, 60, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (39, 'Strophomenata', 'Strophomenata', 'Strophomenata', 37, '/1/3/37/39', 7, 60, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (40, 'Rhipidomellidae', 'Rhipidomellidae', 'Rhipidomellidae', 38, '/1/3/37/38/40', 14, 140, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (41, 'Rhipidomella', 'Rhipidomella', 'Rhipidomella', 37, '/1/3/37/38/40/41', 17, 180, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, year_published, nomenclator_guid) 
       values (42, 'Rhipidomella michelini', '(Léveilé, 1835)', '<em>Rhipidomella michelini</em> (Léveilé, 1835)', 'michelini', 41, '/1/3/37/38/40/41/42', 19, 220, 'ICZN','1895',null);

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (43, 'Rugosochonetidae', 'Rugosochonetidae', 'Rugosochonetidae', 39, '/1/3/37/39/43', 14, 140, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (44, 'Rugosochonetes', 'Rugosochonetes', 'Rugosochonetes', 43, '/1/3/37/39/43/44', 17, 180, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, year_published, nomenclator_guid) 
       values (45, 'Rugosochonetes vaughani', 'Muir-Wood, 1962', '<em>Rugosochonetes vaughani</em> Muir-Wood, 1962', 'vaughani', 44, '/1/3/37/39/43/44/45', 19, 220, 'ICZN','1895',null);

insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (46, 'Pulsiidae', 'Pulsiidae', 'Pulsiidae', 39, '/1/3/37/39/46', 14, 140, 'ICZN');
insert into taxon (taxon_id, scientific_name, trivial_epithet, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (47, 'Schellwienella', 'Schellwienella', 'Schellwienella', 46, '/1/3/37/39/46/47', 17, 180, 'ICZN');
insert into taxon (taxon_id, scientific_name, authorship, display_name, trivial_epithet, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, year_published, nomenclator_guid) 
       values (48, 'Schellwienella cheuma', 'Basset & Bryant, 2006', '<em>Schellwienella cheuma</em> Basset & Bryant, 2006', 'cheuma', 47, '/1/3/37/39/46/47/48', 19, 220, 'ICZN','1895',null);

-- Real geographies used in the example data 

-- changeset chicoreus:exampleGeographies
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (1, 'Earth', 'Earth', 0, null, '/1', 'http://sws.geonames.org/6295630/',1,1);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (2, 'Europe', 'Europe', 100, 1, '/1/2', 'http://vocab.getty.edu/tgn/1000003',1,2);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (3, 'United Kingdom', 'United Kingdom', 200, 2, '/1/2/3', 'http://sws.geonames.org/2635167/',1,6);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (4, 'Wales', 'Wales', 260, 3, '/1/2/3/4', 'http://sws.geonames.org/2634895/',1,11);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (5, 'Cardiff', 'Wales: Cardiff', 500, 4, '/1/2/3/4/5','http://sws.geonames.org/2653822',1,30);

insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (6, 'North America', 'North and Central America', 100, 1, '/1/6', 'http://vocab.getty.edu/tgn/1000001',1,2);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (7, 'United States', 'United States', 200, 6, '/1/6/7', 'http://www.geonames.org/6252001',1,6);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (8, 'New Hampshire', 'US: New Hampshire', 300, 7, '/1/6/7/8', 'http://www.geonames.org/5090174',1,14);

insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (9, 'Atlantic', 'Atlantic Ocean', 100, 1, '/1/9', 'http://www.geonames.org/',1,32);

insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (10, 'South America', 'South America', 100, 1, '/1/10', '',1,2);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (11, 'Brazil', 'Brazil', 200, 6, '/1/10/11', '',1,6);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (12, 'Maine', 'US: Maine', 300, 7, '/1/6/7/12', '',1,14);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (13, 'High Seas', 'High Seas', 200, 1, '/1/13', '',1,6);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (14, 'US Exclusive Economic Zone', 'US: EEZ', 260, 7, '/1/6/7/14', '',1,35);

insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (15, 'North Atlantic', 'North Atlantic Ocean', 150, 9, '/1/9/15', 'http://www.geonames.org/',1,33);
insert into geography (geography_id, name, full_name, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (16, 'Gulf of Maine', 'Gulf of Maine', 250, 9, '/1/9/15', 'http://www.geonames.org/',1,34);

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
insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (6,'Example:Entomology Department','example.com','example.com','Entomology Department','http://example.com/',2);

insert into catnumseriescollection (catalognumberseries_id, collection_id) values (1,1);
-- Example of a catalognumberseries that spans more than one department.
insert into catnumseriescollection (catalognumberseries_id, collection_id) values (2,2);
insert into catnumseriescollection (catalognumberseries_id, collection_id) values (2,3);
insert into catnumseriescollection (catalognumberseries_id, collection_id) values (2,4);
insert into catnumseriescollection (catalognumberseries_id, collection_id) values (3,5);

insert into accession (accession_id, accessionnumber, remarks, scope_id) values (1,'1','Example default accession',1);

-- The Examples: 

-- changeset chicoreus:188
-- Case 1, simple case, one unit, one organism, one part, one preparation.
-- This corresponds to: Test Case 0 – Several specimens on a sheet, one collecting event, one catalog number (a lot).
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (1, 'Mt. Monadnock','Mount Monadnock', 'Example Locality',8,8);
insert into collector (collector_id, verbatim_collector, etal, remarks) values (1, 'Tuckerman','et al.','Example collector');
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (1,'10 Jan, 1880','1880-01-10','1800-01-01');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (1,1,1,1);
insert into unit (unit_id,collectingevent_id,unit_field_number) values (1,1,'Ex-999');
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (1,1,'001',1,1);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid,remarks) values (1,1,1,1,'urn:uuid:41f908ba-d112-11e6-ac8b-0015c5c8a550', 'This corresponds to: Test Case 0 – Several (one) specimens on a sheet, one collecting event, one catalog number (a lot). (Simple herbarium sheet example)');
insert into preparation (preparation_id,preparation_type,preservation_type,status) values (1,'sheet','dried','in collection');
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (1,1,1,'branch',1);
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id,is_filed_under) values (12,1,1,1,1); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (2,'15 Jan, 1880','1880-01-15','1880-01-15');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (12,1,0,6,2,0); 

-- SELECT for Case 1 as single row for flat darwin core:
-- select * from identifiableitem ii left join unit u on ii.unit_id = u.unit_id left join part p on ii.identifiableitem_id = p.identifiableitem_id left join preparation pr on p.preparation_id = pr.preparation_id left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id left join locality l on ce.locality_id = l.locality_id left join geography g on l.geopolitical_geography_id = g.geography_id left join identification id on ii.identifiableitem_id = id.identifiableitem_id left join taxon t on id.taxon_id = t.taxon_id left join collector col on ce.collector_id = col.collector_id left join catalogeditem ci on ii.catalogeditem_id = ci.catalogeditem_id left join collection on ci.collection_id = collection.collection_id left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id where catalog_number = '001' and id.is_current = 1;
-- Alternatively:
-- select getHigherGeographyAtRank(l.geopolitical_geography_id,200) as country, g.name, l.specificlocality, coll.preferred_name_string as recordedBy, unit_field_number, dcol.iso_date as dateCollected, getHigherTaxonAtRank(getCurrentIdentTaxonId(ii.identifiableitem_id),140) as family, cco_full.getCurrentIdentification(ii.identifiableitem_id), did.iso_date as dateIdentified, occurrence_guid, institution_code, collection_code, concat(catalognumber_prefix,catalog_number) as catalogNumber, part_name, lot_count, preparation_type, preservation_type from identifiableitem ii left join unit u on ii.unit_id = u.unit_id left join part p on ii.identifiableitem_id = p.identifiableitem_id left join preparation pr on p.preparation_id = pr.preparation_id left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id left join locality l on ce.locality_id = l.locality_id left join geography g on l.geopolitical_geography_id = g.geography_id left join collector col on ce.collector_id = col.collector_id left join catalogeditem ci on ii.catalogeditem_id = ci.catalogeditem_id left join collection on ci.collection_id = collection.collection_id left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id left join eventdate dcol on ce.date_collected_eventdate_id = dcol.eventdate_id left join identification id on ii.identifiableitem_id = id.identifiableitem_id left join eventdate did on id.date_determined_eventdate_id = did.eventdate_id left join agent coll on col.agent_id = coll.agent_id where catalog_number = '001' and id.identification_id = getCurrentIdentId(ii.identifiableitem_id) ;

-- changeset chicoreus:189
-- Case 2, packet with two organisms (lichen on bark in packet), with the packet being the cataloged object,
-- thus (one catalog number and two occurrences).
-- This corresponds to: Test Case 5 – Mixed Collection with a single catalog number.  Multiple biological individuals of different species, one physical loanable preparation.  Single catalog number on the preparation.
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (2, 'Mt. Adams','Mount Adams', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (3,'10 Feb, 1882','1882-02-10','1882-02-10');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (2, 6, 'Tuckerman','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (2,2,2,3);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks) values (2,2,'Ex-9999','This corresponds to: Test Case 5 – Mixed Collection with a single catalog number.  Multiple biological individuals of different species, one physical loanable preparation.  Single catalog number on the preparation.'
);
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

-- SELECT for Case 2 as two rows (one per dwc:occurrenceId) for flat DarwinCore.
-- select getHigherGeographyAtRank(l.geopolitical_geography_id,200) as country, g.name, l.specificlocality, coll.preferred_name_string as recordedBy, unit_field_number, dcol.iso_date as dateCollected, getHigherTaxonAtRank(getCurrentIdentTaxonId(ii.identifiableitem_id),140) as family, cco_full.getCurrentIdentification(ii.identifiableitem_id) as scientificName, cco_full.getCurrentIdentDateIdentified(ii.identifiableitem_id) as dateIdentified,  trim(concat(individual_count, ' ', ifnull(individual_count_modifier,''))) as numberOfIndividuals, occurrence_guid as occurrenceId, institution_code, collection_code, cco_full.getCatalogNumbers(ii.identifiableitem_id) as catalogNumber, cco_full.getparts(ii.identifiableitem_id) as parts, cco_full.getPreparations(ii.identifiableitem_id) as preparations from identifiableitem ii left join unit u on ii.unit_id = u.unit_id left join part p on ii.identifiableitem_id = p.identifiableitem_id left join preparation pr on p.preparation_id = pr.preparation_id left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id left join locality l on ce.locality_id = l.locality_id left join geography g on l.geopolitical_geography_id = g.geography_id left join collector col on ce.collector_id = col.collector_id left join catalogeditem ci on pr.catalogeditem_id = ci.catalogeditem_id left join collection on ci.collection_id = collection.collection_id left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id left join eventdate dcol on ce.date_collected_eventdate_id = dcol.eventdate_id left join identification id on ii.identifiableitem_id = id.identifiableitem_id left join agent coll on col.agent_id = coll.agent_id where catalog_number = '002' and ci.catalognumberseries_id = 1 and id.identification_id = getCurrentIdentId(ii.identifiableitem_id);


-- changeset chicoreus:190
-- Case 3, lot of one organism but two preparations (with the preparations cataloged)
-- This corresponds to: Test Case 3a –One biological individual in several specimens of several different preparation types, each preparation cataloged.  One biological individual, several cataloged, loanable preparations of different types, each with a catalog number (potentially in different catalog number series or even collections).
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id,geographic_geography_id) values (3, 'Cardiff Bay','Cardiff Bay', 'Example Locality',5,9);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (6,'4-10 62','1962-04-10','1962-04-10');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (3, null, 'A. Jones','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (3,3,3,6);
insert into unit (unit_id,collectingevent_id,unit_field_number) values (3,3,'62-153');
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid,remarks) values (4,3,null,30,'urn:uuid:900d240e-5d85-4b5b-b8c2-b9e97db34c51','This corresponds to: Test Case 3a –One biological individual in several specimens of several different preparation types, each preparation cataloged.  One biological individual, several cataloged, loanable preparations of different types, each with a catalog number.');
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

-- changeset chicoreus:191
-- Test Case 1 – Several specimens on a sheet, each cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, each with a catalog number.
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (4, 'Mt. Greylock','Mount Greylock', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (8,'July 15, 83','1883-07-15','1883-07-15');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (4, 6, 'Tuckerman','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (4,4,4,8);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks) values (4,4,'Ex-99904','This corresponds to one specimen from: Test Case 1 – Several specimens on a sheet, each cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, each with a catalog number.');
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (5, 'Mt. Washignton','Mount Washington', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (9,'July 5, 1882','1882-07-05','1882-07-05');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (5, 6, 'Tuckerman','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (5,5,5,9);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks) values (5,5,'Ex-88804','This corresponds to one specimen from: Test Case 1 – Several specimens on a sheet, each cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, each with a catalog number.');
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

-- changeset chicoreus:192
-- Test Case 2 –Several specimens on a sheet, sheet cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, under a single catalog number.
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (6, 'Mt. Greylock','Mount Greylock', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (14,'Aug 15, 83','1983-08-15','1983-08-15');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (6, 8, 'Heiser','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (6,6,6,14);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks) values (6,6,'Ex-99905','This corresponds to one specimen from: Test Case 2 – Several specimens on a sheet, sheet cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, under a single catalog number.');
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (7, 'Mt. Washignton','Mount Washington', 'Example Locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (15,'July 5, 1881','1881-07-05','1881-07-05');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (7, 6, 'Tuckerman','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (7,7,7,15);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks) values (7,7,'Ex-88805','This corresponds to one specimen from: Test Case 2 – Several specimens on a sheet, sheet cataloged.  One physical, loanable preparation, containing several different biological individuals collected in separate collecting events, under a single catalog number.');
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

-- changeset chicoreus:193
-- Test Case 3 –One biological individual in several specimens on several sheets, each sheet cataloged.  One biological individual, several cataloged, loanable preparations of the same type, each with a catalog number.
-- Palm leaves that span multiple sheets.

insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (8, 'Passeio publico','Rio de Janeiro; Passeio Publico [public park]', 'Example Locality', 11, 11);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (20,'10/4/1875','1875-10-04','1875-10-04');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (8, 9, 'A.F.M. Glaziou','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (8,8,8,20);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks) values (8,8,'8063','This corresponds to Test Case 3 – One biological individual in several specimens on several sheets, each sheet cataloged.  One biological individual, several cataloged, loanable preparations of the same type, each with a catalog number.  (Leaves from a palm tree spread across several sheets)');
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

-- changeset chicoreus:lotofsnails
-- This corresponds to: Test Case 0 – Several specimens on a sheet, one collecting event, one catalog number (a lot).
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (9, '30 miles SE of Mt Desert Island','Off the Coast of Maine; 30 miles Southeast of Mt Desert Island.', 'Example marine Locality',14,16);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (23,'8-10 62','1962-08-10','1962-08-10');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (9, null, 'A. Jones','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (9,9,9,23);
insert into unit (unit_id,collectingevent_id,unit_field_number) values (9,9,'62-500');
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (11,2,'00234',1,4);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid,remarks) values (10,9,11,45,'urn:uuid:0880242c-05ce-47f2-a666-0f3add191c2b', 'This corresponds to: Test Case 0 – Several specimens on a sheet, one collecting event, one catalog number (a lot). (Marine mollusk example)');
insert into preparation (preparation_id,preparation_type,preservation_type,status) values (10,'shells','dry','in collection');
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lot_count) values (13,10,10,'shell',45);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (24,'15 Feb, 2004','2004-02-15','2004-02-15');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id,date_determined_eventdate_id,is_filed_under) values (31,10,1,1,24,1); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (25,'18 Feb, 1983','1983-02-18','1983-02-18');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id,is_filed_under) values (31,10,0,12,25,0); 
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, is_filed_under) values (31,10,0,13,0); 


-- changeset chicoreus:194
-- Test Case 4 – Series of derived preparations.  One biological individual, several cataloged, loanable preparations of different types,  some sharing a catalog number, others with different numbers.

-- TODO: Because this is cataloged in two collections it returns two rows in flat Darwn Core query which don't clarify material in collection.
-- TODO: Derived preparation isn't listed in preparations retrieved with function.

insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (10, 'Near Richmond','Near Richmond, NH', 'Example locality',8,8);
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (26,'22 Dec, 98','1998-12-22','1998-12-22');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (10, 14, 'H. Tolman','and students');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (10,10,10,26);
insert into unit (unit_id,collectingevent_id,unit_field_number) values (10,10,'35');
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (12,2,'00532',1,4);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (13,2,'00533',1,4);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (14,3,'7539365',1,5);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (15,3,'7539733',1,5);
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (16,2,'00534',1,4);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid,remarks) values (11,10,null,1,'urn:uuid:2ec1860d-112a-465f-ab39-1e0ec754923e', ' This corresponds to: Test Case 4 – Series of derived preparations.  One biological individual, several cataloged, loanable preparations of different types,  some sharing a catalog number, others with different numbers, includes a derived preparation. (Mammology/Cryogenic example (part of animal cataloged in one collection, part in another)).');
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

-- changset chicoreus:testcase5ant
-- Test case for an ethanol vial and a set of pinned ants from one ant hill with an associated species (inquiline ant) along with an ant on one of the pins.

insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id, geographic_geography_id) values (11, 'Mt. Adams','Mount Adams', 'Example Locality (not the right one for this taxon)',8,8); 
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (29,'10 Feb, 2002','2002-02-10','2002-02-10');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (11, 15, 'SP Cover','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (11,11,11,29);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks) values (11,11,'SPC9999','This corresponds to: Test Case 5 – Mixed Collection with a single catalog number.  Multiple biological individuals of different species, single physical loanable preparation.  Single catalog number on the preparation. (Ant and other species on a pin) Extended to include additional cataloged items from the same unit.'
);
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

-- changeset chicoreus:195
-- Test Case 5a – Mixed Collection with multiple catalog numbers Multiple biological individuals of different species, each with a catalog number, one physical loanable preparation (fossil slab with several cataloged specimens).

insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id,geographic_geography_id) values (12, 'Ty nant quarry, NW of Cardiff','Ty-nant Quarry, NW of Cardiff', 'Example fossil Locality (Point Limestone Fm, Carboniferous)',5,5);
-- TODO: Geological context
-- Ty-nant Quarry, Point Limestone Fm
-- Tournaisian
-- Lower Carboniferous
insert into eventdate (eventdate_id, verbatim_date, iso_date,start_date) values (32,'12/12/04','2004-12-12','2004-12-12');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (12, 16, 'M. Basset','');
insert into collectingevent (collectingevent_id, locality_id,collector_id,date_collected_eventdate_id) values (12,12,12,32);
insert into unit (unit_id,collectingevent_id,unit_field_number,remarks) values (12,12,'04352','This corresponds to: - Test Case 5a – Mixed Collection with multiple catalog numbers Multiple biological individuals of different species, each with a catalog number, one physical loanable preparation (fossil slab with several cataloged specimens).');
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


-- changeset chicoreus:196
-- Test Case 6 – Mixed Collection with derivatives.  Multiple biological individuals of different species, more than one physical loanable preparation (a mixed collection in a packet, with a slide that has been prepared from one of the taxa present in the mixed collection)
select 'TODO: case 9';



-- Case from DINA TC Call 2017 Jan 24
select 'TODO: case xx';

-- Jar of 10 fish
-- Set of 10 frozen tissue samples
-- One frozen tissue sample has had identification made based on sequence.
-- One fish has identificaiton made on sequence
-- Other 9 fish have indentification infered from sequence
-- All 10 fish live in the same jar (one preparation)


-- Case from DINA TC Call 2017 Jan 24
select 'TODO: case yy';

-- One tree, resampled multiple times, one herbarium sheet for each resampling event.
-- Unclear if CCO_full can model this case (heriarchical model clearly can)

-- Retrieve all examples as flat DarwinCore
select distinct getHigherGeographyAtRank(l.geopolitical_geography_id,200) as country, g.name, l.specificlocality, coll.preferred_name_string as recordedBy, unit_field_number, dcol.iso_date as dateCollected, getHigherTaxonAtRank(getCurrentIdentTaxonId(ii.identifiableitem_id),140) as family, cco_full.getCurrentIdentification(ii.identifiableitem_id) as scientificName, cco_full.getCurrentIdentDateIdentified(ii.identifiableitem_id) as dateIdentified,  trim(concat(individual_count, ' ', ifnull(individual_count_modifier,''))) as numberOfIndividuals, occurrence_guid as occurrenceId, institution_code, collection_code, cco_full.getCatalogNumbers(ii.identifiableitem_id) as catalogNumber, cco_full.getparts(ii.identifiableitem_id) as parts, cco_full.getPreparations(ii.identifiableitem_id) as preparations, concat(ifnull(u.remarks,''), ifnull(ii.remarks,'')) as remarks from identifiableitem ii left join unit u on ii.unit_id = u.unit_id left join part p on ii.identifiableitem_id = p.identifiableitem_id left join preparation pr on p.preparation_id = pr.preparation_id left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id left join locality l on ce.locality_id = l.locality_id left join geography g on l.geopolitical_geography_id = g.geography_id left join collector col on ce.collector_id = col.collector_id left join catalogeditem ci on pr.catalogeditem_id = ci.catalogeditem_id left join collection on ci.collection_id = collection.collection_id left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id left join eventdate dcol on ce.date_collected_eventdate_id = dcol.eventdate_id left join identification id on ii.identifiableitem_id = id.identifiableitem_id left join agent coll on col.agent_id = coll.agent_id;

-- The last liquibase changeset in this file was number 196

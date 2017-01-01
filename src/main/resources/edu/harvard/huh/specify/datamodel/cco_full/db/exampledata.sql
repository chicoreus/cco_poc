
insert into agent(agent_id, preferred_name_string,guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (3,'Mason Ellsworth Hale, Jr.','https://viaf.org/viaf/310661352',1928,1990,'Hale','','Jr.','Mason','Ellsworth','Hale');
insert into agentname(agent_id, type, name) values (3,'full name','Mason Ellsworth Hale, Jr.');
insert into agentname(agent_id, type, name) values (3,'also known as','Mason Hale Jr.');
insert into agentname(agent_id, type, name) values (3,'standard botanical abbreviation','Hale');
insert into agentlink (agent_id, type, link, text) values (3,'wiki','https://en.wikipedia.org/wiki/Mason_Ellsworth_Hale','Wikipedia entry');

insert into agent(agent_id, preferred_name_string,guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (4,'Jakob Friedrich Ehrhart','https://viaf.org/viaf/3221377',1742,1795,'Ehrh.','','','Jakob','Friedrich','Ehrhart');
insert into agentname(agent_id, type, name) values (4,'full name','Jakob Friedrich Ehrhart');
insert into agentname(agent_id, type, name) values (4,'also known as','Friedrich Ehrhart');
insert into agentname(agent_id, type, name) values (4,'standard botanical abbreviation','Ehrh.');
insert into agentlink (agent_id, type, link, text) values (4,'wiki','https://en.wikipedia.org/wiki/Ehrh.','Wikipedia entry');

insert into agent(agent_id, preferred_name_string,guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (5,'Erik Acharius','https://viaf.org/viaf/51806870',1742,1795,'Ach.','','','Erik','','Erik Acharius');
insert into agentname(agent_id, type, name) values (5,'full name','Erik Acharius');
insert into agentname(agent_id, type, name) values (5,'standard botanical abbreviation','Ach.');
Cinsert into agentlink (agent_id, type, link, text) values (5,'wiki','https://en.wikipedia.org/wiki/Ach.','Wikipedia entry');

insert into taxon (taxon_id, scientific_name, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (2, 'Fungi', 'Fungi', 1, '/1/2',2, 10, 'ICNafp');
insert into taxon (taxon_id, scientific_name, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (3, 'Animalia', 'Animalia', 1, '/1/3',2, 10, 'ICZN');
insert into taxon (taxon_id, scientific_name, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (4, 'Plantae', 'Plantae', 1, '/1/4',2, 10, 'ICNafp');

insert into taxon (taxon_id, scientific_name, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (5, 'Parmeliaceae', 'Parmeliaceae', 2, '/1/2/5',14, 140, 'ICNafp');
insert into taxon (taxon_id, scientific_name, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (6, 'Xanthoparmelia', '<em>Xanthoparmelia</em>', 5, '/1/2/5/6',17, 180, 'ICNafp');
insert into taxon (taxon_id, scientific_name, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (7, 'Lichen', '<em>Lichen</em>', 2, '/1/2/7',17, 180, 'ICNafp');

insert into taxon (taxon_id, scientific_name, authorship, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, parauthor_agent_id, parexauthor_agent_id, author_agent_id, year_published, nomenclator_guid) 
       values (8, 'Xanthoparmelia conspersa', '(Ehrh. ex Ach.) Hale', '<em>Xanthoparmelia conspersa</em> (Ehrh. ex Ach.) Hale', 6, '/1/2/5/6/8',19, 220, 'ICNafp',4,5,3, '(1974)', 'urn:lsid:indexfungorum.org:names:343884');
insert into taxon (taxon_id, scientific_name, authorship, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, author_agent_id, exauthor_agent_id, year_published, accepted_taxon_id, nomenclator_guid) 
       values (9, 'Lichen conspersus', 'Ehrh. ex Ach.', '<em>Lichen conspersus</em> Ehrh. ex Ach.', 7, '/1/2/7/9',19, 220, 'ICNafp',4,5,'1799 [1798]',7, 'urn:lsid:indexfungorum.org:names:393893');

insert into taxon (taxon_id, scientific_name, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (10, 'Fagaceae', 'Fagaceae', 4, '/1/4/10',14, 140, 'ICNafp');
insert into taxon (taxon_id, scientific_name, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code) 
       values (11, 'Quercus', '<em>Quercus</em>', 10, '/1/4/10/11',17, 180, 'ICNafp');
insert into taxon (taxon_id, scientific_name, authorship, display_name, parent_id, parentage, taxontreedefitem_id, rank_id, nomenclatural_code, author_agent_id, year_published, nomenclator_guid) 
       values (12, 'Quercus alba', 'L.', '<em>Quercus alba</em> L.', 11, '/1/4/10/11/12',19, 220, 'ICNafp',2,'1753','urn:lsid:ipni.org:names:295763-1:1.2.2.1.1.3');

insert into geography (geography_id, name, fullname, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (1, 'Earth', 'Earth', 0, null, '/1', 'http://sws.geonames.org/6295630/',1,1);
insert into geography (geography_id, name, fullname, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (2, 'Europe', 'Europe', 100, 1, '/1/2', 'http://vocab.getty.edu/tgn/1000003',1,2);
insert into geography (geography_id, name, fullname, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (3, 'United Kingdom', 'United Kingdom', 200, 2, '/1/2/3', 'http://sws.geonames.org/2635167/',1,6);
insert into geography (geography_id, name, fullname, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (4, 'Wales', 'Wales', 260, 3, '/1/2/3/4', 'http://sws.geonames.org/2634895/',1,11);
insert into geography (geography_id, name, fullname, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (5, 'Cardiff', 'Wales: Cardiff', 500, 4, '/1/2/3/4/5',1,30);

-- Case 1, simple case, one unit, one organism, one part, one preparation.

-- insert into locality (locality_id, verbatim_locality, specificlocality, geopolitical_geography_id) values (1, 'Cardiff','Cardiff',5);
-- insert into collectingevent (collectingevent_id, locality_id) values (1,1);
-- insert into collector (collector_id,locality_id) values (1,1);
-- insert into unit (unit_id,collecting_event_id) values (1,1);
-- insert into identifiableitem (identifiableitem_id) values (1);
-- insert into catalogeditem (catalogeditem_id, preparation_id) values (1,1);
-- insert into part (part_id, identifiableitem_id, preparation_id) values (1,1,1);
-- insert into preparation (preparation_id) values (1);
-- insert into determination (taxon_id, identifiableitem_id) values (8,1); 
-- insert into determination (taxon_id, identifiableitem_id) values (8,1); 



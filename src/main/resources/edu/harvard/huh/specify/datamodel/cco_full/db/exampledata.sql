
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
       values (5,'Erik Acharius','https://viaf.org/viaf/51806870',1757,1819,'Ach.','','','Erik','','Acharius');
insert into agentname(agent_id, type, name) values (5,'full name','Erik Acharius');
insert into agentname(agent_id, type, name) values (5,'standard botanical abbreviation','Ach.');
insert into agentlink (agent_id, type, link, text) values (5,'wiki','https://en.wikipedia.org/wiki/Ach.','Wikipedia entry');

insert into agent(agent_id, preferred_name_string,guid,yearofbirth,yearofdeath,abbreviated_name_string,prefix,suffix,first_name,middle_names,family_names) 
       values (6,'Edward Tuckerman','https://viaf.org/viaf/59861375',1817,1886,'Tuckerman','','','Edward','','Tuckerman');
insert into agentname(agent_id, type, name) values (6,'full name','Edward Tuckerman');
insert into agentname(agent_id, type, name) values (6,'standard botanical abbreviation','Tuckerman');
insert into agentlink (agent_id, type, link, text) values (6,'wiki','https://en.wikipedia.org/wiki/Edward_Tuckerman','Wikipedia entry');

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
       values (5, 'Cardiff', 'Wales: Cardiff', 500, 4, '/1/2/3/4/5','http://sws.geonames.org/2653822',1,30);

insert into geography (geography_id, name, fullname, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (6, 'North America', 'North and Central America', 100, 1, '/1/6', 'http://vocab.getty.edu/tgn/1000001',1,2);
insert into geography (geography_id, name, fullname, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (7, 'United States', 'United States', 200, 6, '/1/6/7', 'http://www.geonames.org/6252001',1,6);
insert into geography (geography_id, name, fullname, rank_id, parent_id, parentage, guid, geographytreedef_id, geographytreedefitem_id) 
       values (8, 'New Hampshire', 'US: New Hampshire', 300, 7, '/1/6/7/8', 'http://www.geonames.org/5090174',1,14);

insert into catalognumberseries (catalognumberseries_id, name) values (1,'Example:Botany Accession Numbers');
insert into catalognumberseries (catalognumberseries_id, name) values (2,'Example:Zoology Catalog Numbers');

insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (1,'Example:Botany Department','example.com','example.com','Botany Department','http://example.com/',7);
insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (2,'Example:Mammalogy Department','example.com','example.com','Mammalogy Department','http://example.com/',3);
insert into collection(collection_id, collection_name, institution_guid, institution_code, collection_code, website_iri, scope_id) values (3,'Example:Paleontology Department','example.com','example.com','Paleontology Department','http://example.com/',6);

insert into catnumseriescollection (catalognumberseries_id, collection_id) values (1,1);
-- Example of a catalognumberseries that spans more than one department.
insert into catnumseriescollection (catalognumberseries_id, collection_id) values (2,2);
insert into catnumseriescollection (catalognumberseries_id, collection_id) values (2,3);

insert into accession (accession_id, accessionnumber, remarks, scope_id) values (1,'1','Example default accession',1);

-- Case 1, simple case, one unit, one organism, one part, one preparation.
insert into locality (locality_id, verbatim_locality, specificlocality, remarks, geopolitical_geography_id) values (1, 'Mt. Monadnock','Mount Monadnock', 'Example Locality',5);
insert into collector (collector_id, verbatim_collector, etal, remarks) values (1, 'Tuckerman','et al.','Example collector');
insert into eventdate (eventdate_id, verbatim_date, iso_date) values (1,'10 Jan, 1880','1880-01-10');
insert into collectingevent (collectingevent_id, locality_id,collector_id,verbatim_date,date_collected_eventdate_id) values (1,1,1,'1880',1);
insert into unit (unit_id,collectingevent_id,unit_field_number) values (1,1,'Ex-999');
insert into catalogeditem (catalogeditem_id, catalognumberseries_id, catalog_number, accession_id, collection_id) values (1,1,'001',1,1);
insert into identifiableitem (identifiableitem_id,unit_id,catalogeditem_id,individual_count,occurrence_guid) values (1,1,1,1,'urn:uuid:41f908ba-d112-11e6-ac8b-0015c5c8a550');
insert into preparation (preparation_id,preparation_type,preservation_type,status) values (1,'sheet','dried','in collection');
insert into part (part_id, identifiableitem_id, preparation_id,part_name, lotcount) values (1,1,1,'branch',1);
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id) values (12,1,1,1); 
insert into eventdate (eventdate_id, verbatim_date, iso_date) values (2,'15 Jan, 1880','1880-01-15');
insert into identification (taxon_id, identifiableitem_id,is_current,determiner_agent_id, date_determined_eventdate_id) values (12,1,0,6,2); 

-- select * from identifiableitem ii left join unit u on ii.unit_id = u.unit_id left join part p on ii.identifiableitem_id = p.identifiableitem_id left join preparation pr on p.preparation_id = pr.preparation_id left join collectingevent ce on u.collectingevent_id = ce.collectingevent_id left join locality l on ce.locality_id = l.locality_id left join geography g on l.geopolitical_geography_id = g.geography_id left join identification id on ii.identifiableitem_id = id.identifiableitem_id left join taxon t on id.taxon_id = t.taxon_id left join collector col on ce.collector_id = col.collector_id left join catalogeditem ci on ii.catalogeditem_id = ci.catalogeditem_id left join collection on ci.collection_id = collection.collection_id left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id limit 1;

-- Case 2, packet with two organisms (lichen on bark).
-- insert into locality (locality_id) values (2) 
insert into eventdate (eventdate_id, verbatim_date, iso_date) values (3,'10 Feb, 1882','1882-02-10');
insert into collector (collector_id, agent_id, verbatim_collector, etal) values (2, 6, 'Tuckerman','');
-- insert into unit (unit_id,collecting_event_id) values (2,2);
-- insert into identifiableitem (identifiableitem_id, unit_id) values (2,2);
-- insert into identifiableitem (identifiableitem_id, unit_id) values (3,2);
-- insert into catalogeditem (catalogeditem_id, preparation_id) values (2,2);
-- insert into part (part_id, identifiableitem_id, preparation_id) values (2,2,2);
-- insert into preparation (preparation_id) values (2);  
-- insert into determination (taxon_id, identifiableitem_id) values (8,2); 
-- insert into determination (taxon_id, identifiableitem_id) values (12,2); 

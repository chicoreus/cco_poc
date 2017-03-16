-- liquibase formatted sql

-- changeset chicoreus:149 dbms:mysql

drop function if exists cco_full.extractFromString;

-- Extract on element from a string that contains a delimited list of strings.  Limited to a 
-- input string of length up to 2000 characters.
--
-- @param deliimiter, the delimiter used to separate elements in the list in the input string.
-- @param string, the input string containing a delimited list
-- @param position, the position of the element in the list to extract
--
-- @return a string extracted from the positionth element in the delimited list in the input string.
--
-- @{@example
--    select extractFromString('/', '/1/5/29/53/2600', 3);
-- }
create function cco_full.extractFromString(delimiter varchar(10), string varchar(2000), position int)
returns varchar(2000) deterministic
RETURN replace( substring(substring_index(string, delimiter, position), length(substring_index(string, delimiter, position-1))+1), delimiter, ''); 

-- changeset chicoreus:150 dbms:mysql

drop function if exists cco_full.getHigherTaxonAtRank;


-- changeset chicoreus:151 dbms:none
delimiter |
-- changeset chicoreus:152 endDelimiter:\| dbms:mysql

-- If Recursive functions get support, then this should work: 
-- create function cco_full.getTaxonParentage(taxonid INT) 
-- returns varchar(2000)
-- READS SQL DATA
-- begin 
--    declare parentage varchar(2000);
--    declare parentid bigint;
--    select parent_id into parentid from taxon where taxon_id = taxonid;
--    if parentid is null then 
--       return concat('/',cast(taxonid as CHAR)); 
--    else 
--       return getTaxonParentage(parentid);
--    end if;
-- end |

-- Obtain the parentage from the current node to root for a taxon.  
-- Implementation limited to a tree depth of 24.
-- @param taxonid the taxon.taxon_id for which to obtain the parentage.
-- @return the parentage as a / delimited string, starting with / and 
-- ending with the taxon_id of the requested node.  
create function cco_full.getTaxonParentage(taxonid INT) 
 returns varchar(2000)
 READS SQL DATA
 begin 
    declare parentage varchar(2000);
    select concat_ws('/',
           z.parent_id, y.parent_id, x.parent_id, w.parent_id, v.parent_id, u.parent_id,
           t.parent_id, s.parent_id, r.parent_id, q.parent_id, p.parent_id, o.parent_id,
           n.parent_id, m.parent_id, l.parent_id, k.parent_id, j.parent_id, i.parent_id,
           h.parent_id, g.parent_id, f.parent_id, e.parent_id, d.parent_id, c.parent_id,
           b.parent_id, a.parent_id, a.taxon_id) into parentage
        from taxon a left join taxon b on a.parent_id = b.taxon_id 
                     left join taxon c on b.parent_id = c.taxon_id 
                     left join taxon d on c.parent_id = d.taxon_id 
                     left join taxon e on d.parent_id = e.taxon_id 
                     left join taxon f on e.parent_id = f.taxon_id 
                     left join taxon g on f.parent_id = g.taxon_id 
                     left join taxon h on g.parent_id = h.taxon_id 
                     left join taxon i on h.parent_id = i.taxon_id 
                     left join taxon j on i.parent_id = j.taxon_id 
                     left join taxon k on j.parent_id = k.taxon_id 
                     left join taxon l on k.parent_id = l.taxon_id 
                     left join taxon m on l.parent_id = m.taxon_id 
                     left join taxon n on m.parent_id = n.taxon_id 
                     left join taxon o on n.parent_id = o.taxon_id 
                     left join taxon p on o.parent_id = p.taxon_id 
                     left join taxon q on p.parent_id = q.taxon_id 
                     left join taxon r on q.parent_id = r.taxon_id 
                     left join taxon s on r.parent_id = s.taxon_id 
                     left join taxon t on s.parent_id = t.taxon_id 
                     left join taxon u on t.parent_id = u.taxon_id 
                     left join taxon v on u.parent_id = v.taxon_id 
                     left join taxon w on v.parent_id = w.taxon_id 
                     left join taxon x on w.parent_id = x.taxon_id 
                     left join taxon y on x.parent_id = y.taxon_id 
                     left join taxon z on y.parent_id = x.taxon_id 
        where a.taxon_id = taxonid;
    return concat('/',parentage); 
 end |

-- Obtain the parentage from the current node to root for a geography.  
-- Implementation limited to a tree depth of 24.
-- @param geographyid the geography.geography_id for which to obtain the parentage.
-- @return the parentage as a / delimited string, starting with / and 
-- ending with the geography_id of the requested node.  
create function cco_full.getGeogParentage(geographyid INT) 
 returns varchar(2000)
 READS SQL DATA
 begin 
    declare parentage varchar(2000);
    select concat_ws('/',
           z.parent_id, y.parent_id, x.parent_id, w.parent_id, v.parent_id, u.parent_id,
           t.parent_id, s.parent_id, r.parent_id, q.parent_id, p.parent_id, o.parent_id,
           n.parent_id, m.parent_id, l.parent_id, k.parent_id, j.parent_id, i.parent_id,
           h.parent_id, g.parent_id, f.parent_id, e.parent_id, d.parent_id, c.parent_id,
           b.parent_id, a.parent_id, a.geography_id) into parentage
        from geography a left join geography b on a.parent_id = b.geography_id 
                     left join geography c on b.parent_id = c.geography_id 
                     left join geography d on c.parent_id = d.geography_id 
                     left join geography e on d.parent_id = e.geography_id 
                     left join geography f on e.parent_id = f.geography_id 
                     left join geography g on f.parent_id = g.geography_id 
                     left join geography h on g.parent_id = h.geography_id 
                     left join geography i on h.parent_id = i.geography_id 
                     left join geography j on i.parent_id = j.geography_id 
                     left join geography k on j.parent_id = k.geography_id 
                     left join geography l on k.parent_id = l.geography_id 
                     left join geography m on l.parent_id = m.geography_id 
                     left join geography n on m.parent_id = n.geography_id 
                     left join geography o on n.parent_id = o.geography_id 
                     left join geography p on o.parent_id = p.geography_id 
                     left join geography q on p.parent_id = q.geography_id 
                     left join geography r on q.parent_id = r.geography_id 
                     left join geography s on r.parent_id = s.geography_id 
                     left join geography t on s.parent_id = t.geography_id 
                     left join geography u on t.parent_id = u.geography_id 
                     left join geography v on u.parent_id = v.geography_id 
                     left join geography w on v.parent_id = w.geography_id 
                     left join geography x on w.parent_id = x.geography_id 
                     left join geography y on x.parent_id = y.geography_id 
                     left join geography z on y.parent_id = x.geography_id 
        where a.geography_id = geographyid;
    return concat('/',parentage); 
 end |

-- Obtain the parentage from the current node to root for a storage.  
-- Implementation limited to a tree depth of 24.
-- @param storageid the storage.storage_id for which to obtain the parentage.
-- @return the parentage as a / delimited string, starting with / and 
-- ending with the storage_id of the requested node.  
create function cco_full.getStorageParentage(storageid INT) 
 returns varchar(2000)
 READS SQL DATA
 begin 
    declare parentage varchar(2000);
    select concat_ws('/',
           z.parent_id, y.parent_id, x.parent_id, w.parent_id, v.parent_id, u.parent_id,
           t.parent_id, s.parent_id, r.parent_id, q.parent_id, p.parent_id, o.parent_id,
           n.parent_id, m.parent_id, l.parent_id, k.parent_id, j.parent_id, i.parent_id,
           h.parent_id, g.parent_id, f.parent_id, e.parent_id, d.parent_id, c.parent_id,
           b.parent_id, a.parent_id, a.storage_id) into parentage
        from storage a left join storage b on a.parent_id = b.storage_id 
                     left join storage c on b.parent_id = c.storage_id 
                     left join storage d on c.parent_id = d.storage_id 
                     left join storage e on d.parent_id = e.storage_id 
                     left join storage f on e.parent_id = f.storage_id 
                     left join storage g on f.parent_id = g.storage_id 
                     left join storage h on g.parent_id = h.storage_id 
                     left join storage i on h.parent_id = i.storage_id 
                     left join storage j on i.parent_id = j.storage_id 
                     left join storage k on j.parent_id = k.storage_id 
                     left join storage l on k.parent_id = l.storage_id 
                     left join storage m on l.parent_id = m.storage_id 
                     left join storage n on m.parent_id = n.storage_id 
                     left join storage o on n.parent_id = o.storage_id 
                     left join storage p on o.parent_id = p.storage_id 
                     left join storage q on p.parent_id = q.storage_id 
                     left join storage r on q.parent_id = r.storage_id 
                     left join storage s on r.parent_id = s.storage_id 
                     left join storage t on s.parent_id = t.storage_id 
                     left join storage u on t.parent_id = u.storage_id 
                     left join storage v on u.parent_id = v.storage_id 
                     left join storage w on v.parent_id = w.storage_id 
                     left join storage x on w.parent_id = x.storage_id 
                     left join storage y on x.parent_id = y.storage_id 
                     left join storage z on y.parent_id = x.storage_id 
        where a.storage_id = storageid;
    return concat('/',parentage); 
 end |

-- Obtain the parentage from the current node to root for a rocktimeunit.  
-- Implementation limited to a tree depth of 24.
-- @param rocktimeunitid the rocktimeunit.rocktimeunit_id for which to obtain the parentage.
-- @return the parentage as a / delimited string, starting with / and 
-- ending with the rocktimeunit_id of the requested node.  
create function cco_full.getRockTimeParentage(rocktimeunitid INT) 
 returns varchar(2000)
 READS SQL DATA
 begin 
    declare parentage varchar(2000);
    select concat_ws('/',
           z.parent_id, y.parent_id, x.parent_id, w.parent_id, v.parent_id, u.parent_id,
           t.parent_id, s.parent_id, r.parent_id, q.parent_id, p.parent_id, o.parent_id,
           n.parent_id, m.parent_id, l.parent_id, k.parent_id, j.parent_id, i.parent_id,
           h.parent_id, g.parent_id, f.parent_id, e.parent_id, d.parent_id, c.parent_id,
           b.parent_id, a.parent_id, a.rocktimeunit_id) into parentage
        from rocktimeunit a left join rocktimeunit b on a.parent_id = b.rocktimeunit_id 
                     left join rocktimeunit c on b.parent_id = c.rocktimeunit_id 
                     left join rocktimeunit d on c.parent_id = d.rocktimeunit_id 
                     left join rocktimeunit e on d.parent_id = e.rocktimeunit_id 
                     left join rocktimeunit f on e.parent_id = f.rocktimeunit_id 
                     left join rocktimeunit g on f.parent_id = g.rocktimeunit_id 
                     left join rocktimeunit h on g.parent_id = h.rocktimeunit_id 
                     left join rocktimeunit i on h.parent_id = i.rocktimeunit_id 
                     left join rocktimeunit j on i.parent_id = j.rocktimeunit_id 
                     left join rocktimeunit k on j.parent_id = k.rocktimeunit_id 
                     left join rocktimeunit l on k.parent_id = l.rocktimeunit_id 
                     left join rocktimeunit m on l.parent_id = m.rocktimeunit_id 
                     left join rocktimeunit n on m.parent_id = n.rocktimeunit_id 
                     left join rocktimeunit o on n.parent_id = o.rocktimeunit_id 
                     left join rocktimeunit p on o.parent_id = p.rocktimeunit_id 
                     left join rocktimeunit q on p.parent_id = q.rocktimeunit_id 
                     left join rocktimeunit r on q.parent_id = r.rocktimeunit_id 
                     left join rocktimeunit s on r.parent_id = s.rocktimeunit_id 
                     left join rocktimeunit t on s.parent_id = t.rocktimeunit_id 
                     left join rocktimeunit u on t.parent_id = u.rocktimeunit_id 
                     left join rocktimeunit v on u.parent_id = v.rocktimeunit_id 
                     left join rocktimeunit w on v.parent_id = w.rocktimeunit_id 
                     left join rocktimeunit x on w.parent_id = x.rocktimeunit_id 
                     left join rocktimeunit y on x.parent_id = y.rocktimeunit_id 
                     left join rocktimeunit z on y.parent_id = x.rocktimeunit_id 
        where a.rocktimeunit_id = rocktimeunitid;
    return concat('/',parentage); 
 end |


-- Obtain the name of a higher storage at a particular rank from an entry in the storage tree.
-- For example, obtain the family into which some species is placed.
-- 
-- @param taxonid the taxon_id for the taxon for which the higher taxon is to be looked up.
-- @param rankid the rank_id for the higher taxon.
--
-- @return the scientific name of the higher taxon, if one is defined in the parentage of the
-- taxon at the provided rank.
--
create function cco_full.getHigherTaxonAtRank(taxonid INT, rankid INT)
returns VARCHAR(255)
READS SQL DATA
BEGIN
   declare sci_name varchar(255);
   select scientific_name into sci_name from taxon 
      left join taxontreedefitem on taxon.taxontreedefitem_id = taxontreedefitem.taxontreedefitem_id
      where taxon_id in ( 
      select extractFromString('/',parentage,2) from taxon where taxon_id = taxonid
      union 
      select extractFromString('/', parentage,3) from taxon where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,4) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,5) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,6) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,7) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,8) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,9) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,10) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,11) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,12) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,13) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,14) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,15) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,16) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,17) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,18) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,19) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,20) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,21) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,22) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,23) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,24) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,25) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,26) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,27) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,28) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,29) from taxon  where taxon_id = taxonid
      union  
      select extractFromString('/',parentage,30) from taxon  where taxon_id = taxonid
   ) and rank_id = rankid limit 1;
   return sci_name;
END |

-- changeset chicoreus:153  dbms:none
delimiter ;
-- changeset chicoreus:153 endDelimiter:; dbms:mysql

drop function if exists cco_full.getHigherGeographyAtRank;

-- changeset chicoreus:154 dbms:none
delimiter |

-- changeset chicoreus:154 endDelimiter:\| dbms:mysql

-- Obtain the name of a higher geography at a particular rank from an entry in the geography tree.
-- For example, obtain the family into which some species is placed.
-- 
-- @param geographyid the geography_id for the geography for which the higher geography is to be looked up.
-- @param rankid the rank_id for the higher geography.
--
-- @return the name of the higher geography, if one is defined in the parentage of the
-- geography at the provided rank.
--
create function cco_full.getHigherGeographyAtRank(geographyid INT, rankid INT)
returns VARCHAR(255)
READS SQL DATA
BEGIN
   declare geog_name varchar(255);
   select geography.name into geog_name from geography 
      left join geographytreedefitem on geography.geographytreedefitem_id = geographytreedefitem.geographytreedefitem_id
   where geography_id in ( 
      select extractFromString('/',parentage,2) from geography where geography_id = geographyid
      union 
      select extractFromString('/', parentage,3) from geography where geography_id = geographyid
      union  
      select extractFromString('/',parentage,4) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,5) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,6) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,7) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,8) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,9) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,10) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,11) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,12) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,13) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,14) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,15) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,16) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,17) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,18) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,19) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,20) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,21) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,22) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,23) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,24) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,25) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,26) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,27) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,28) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,29) from geography  where geography_id = geographyid
      union  
      select extractFromString('/',parentage,30) from geography  where geography_id = geographyid
   ) and rank_id = rankid limit 1;
   return geog_name;
END |

-- changeset chicoreus:155 dbms:none
delimiter ;
-- changeset chicoreus:155 endDelimiter:; dbms:mysql

drop function if exists cco_full.getCollector;

drop function if exists cco_full.getCurrentIdentification;
drop function if exists cco_full.getCurrentIdentID;
drop function if exists cco_full.getCurrentIdentDateIdentified;
drop function if exists cco_full.getCurrentIdentTaxonID;

drop function if exists cco_full.getPreparations;
drop function if exists cco_full.getParts;
drop function if exists cco_full.getCatalogNumbers;
drop function if exists cco_full.getCollection;
drop function if exists cco_full.getCollectionCode;
drop function if exists cco_full.getInstitutionCode;

-- changeset chicoreus:156 dbms:none
delimiter |
-- changeset chicoreus:156 endDelimiter:\| dbms:mysql

create function cco_full.getCollector(collectorId INT)
returns VARCHAR(255)
READS SQL DATA
BEGIN
   declare collector varchar(900);
   select trim(concat(ifnull(preferred_name_string, verbatim_collector), ' ', etal)) collector 
   from collector left join agent on collector.agent_id = agent.agent_id
   where collector.collector_id = collectorId
      limit 1 into collector;
   return collector;
END |

create function cco_full.getCurrentIdentification(identifiableitemid INT)
returns VARCHAR(255)
READS SQL DATA
BEGIN
   declare scientificName varchar(255);
   select trim(concat(scientific_name, ' ', authorship, ' ', ifnull(qualifier,''))) 
      from identification i 
         left join taxon t on i.taxon_id = t.taxon_id
         left join eventdate on i.date_determined_eventdate_id = eventdate.eventdate_id 
      where identifiableitem_id = identifiableitemid 
      order by is_current desc, start_date
      limit 1 into scientificName;
   return scientificName;
END |

create function cco_full.getCurrentIdentId(identifiableitemid INT)
returns BIGINT
READS SQL DATA
BEGIN
   declare identId bigint;
   select identification_id
      from identification i 
         left join eventdate on i.date_determined_eventdate_id = eventdate.eventdate_id 
      where identifiableitem_id = identifiableitemid 
      order by is_current desc, start_date
      limit 1 into identId;
   return identId;
END |

create function cco_full.getCurrentIdentDateIdentified(identifiableitemid INT)
returns VARCHAR(255)
READS SQL DATA
BEGIN
   declare dateIdentified varchar(255);
   declare verbatimDate varchar(255);
   select iso_date, verbatim_date 
      from identification i 
         left join taxon t on i.taxon_id = t.taxon_id
         left join eventdate on i.date_determined_eventdate_id = eventdate.eventdate_id 
      where identifiableitem_id = identifiableitemid 
      order by is_current desc, start_date
      limit 1 into dateIdentified, verbatimDate;
   if substring(verbatimDate,1,1)='[' then 
      SET dateIdentified=verbatimDate;
   end if;
   return dateIdentified;
END |

create function cco_full.getCurrentIdentTaxonId(identifiableitemid INT)
returns BIGINT
READS SQL DATA
BEGIN
   declare taxonid bigint;
   select taxon_id
      from identification i 
         left join eventdate on i.date_determined_eventdate_id = eventdate.eventdate_id 
      where identifiableitem_id = identifiableitemid 
      order by is_current desc, start_date
      limit 1 into taxonid;
   return taxonid;
END |

create function cco_full.getPreparations(identifiableitemid INT) 
returns varchar(2000)
READS SQL DATA 
BEGIN
   declare result varchar(2000) default '';
   declare prep varchar(255);
   declare ct varchar(255);
   declare sep varchar(2) default '';
   declare done int default 0;
   declare cur cursor for 
      select concat(preparation_type, ' (', preservation_type, ')') prep, count(*) ct from part left join preparation on part.preparation_id = preparation.preparation_id where identifiableitem_id = identifiableitemid group by concat(preparation_type, ' (', preservation_type, ')'); 
   declare continue handler for not found set done = 1;
   open cur;
   getpreps: LOOP
      fetch cur into prep, ct;
      if done = 1 then
        LEAVE getpreps;
      end if;
      if ct > 1 then 
         SET result = concat(result,sep,prep,'(',ct,')');
      else 
         SET result = concat(result,sep,prep);
      end if;
      SET sep = "|";
   END LOOP;
   return result;
END |

create function cco_full.getParts(identifiableitemid INT) 
returns varchar(2000)
READS SQL DATA 
BEGIN
   declare result varchar(2000) default '';
   declare part varchar(255);
   declare sep varchar(2) default '';
   declare done int default 0;
   declare cur cursor for 
      select distinct concat(part_name, ' (', lot_count, lot_count_modifier, ')') from part where identifiableitem_id = identifiableitemid;
   declare continue handler for not found set done = 1;
   open cur;
   getparts: LOOP
      fetch cur into part;
      if done = 1 then
        LEAVE getparts;
      end if;
      SET result = concat(result,sep,part);
      SET sep = "|";
   END LOOP;
   return result;
END |

create function cco_full.getCatalogNumbers(identifiableitemid INT) 
returns varchar(2000)
READS SQL DATA 
BEGIN
   declare result varchar(2000) default '';
   declare num varchar(255);
   declare sep varchar(2) default '';
   declare done int default 0;
   declare cur cursor for 
       select concat(catalognumber_prefix, catalog_number) catnum 
       from identifiableitem ii
          left join catalogeditem ci on ii.catalogeditem_id = ci.catalogeditem_id
          left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id 
       where ii.identifiableitem_id = identifiableitemid and catalog_number is not null
       union 
       select concat(catalognumber_prefix, catalog_number) catnum 
       from identifiableitem ii
          left join part on ii.identifiableitem_id = part.identifiableitem_id 
          left join preparation prep on part.preparation_id = prep.preparation_id 
          left join catalogeditem ci on prep.catalogeditem_id = ci.catalogeditem_id
          left join catalognumberseries cns on ci.catalognumberseries_id = cns.catalognumberseries_id 
       where ii.identifiableitem_id = identifiableitemid and catalog_number is not null
       ;
   declare continue handler for not found set done = 1;
   open cur;
   getnums: LOOP
      fetch cur into num;
      if done = 1 then
        LEAVE getnums;
      end if;
      SET result = concat(result,sep,num);
      SET sep = "|";
   END LOOP;
   return result;
END |

create function cco_full.getCollection(identifiableitemid INT) 
returns varchar(2000)
-- Given an identifiable item, return the list of collections within which it is cataloged.
READS SQL DATA 
BEGIN
   declare result varchar(2000) default '';
   declare name varchar(255);
   declare sep varchar(2) default '';
   declare done int default 0;
   declare cur cursor for 
       select distinct collection_name from (
       select distinct  collection_name
       from identifiableitem ii
          left join catalogeditem ci on ii.catalogeditem_id = ci.catalogeditem_id
          left join collection col on ci.collection_id = col.collection_id
       where ii.identifiableitem_id = identifiableitemid and catalog_number is not null
       union
       select distinct collection_name
       from identifiableitem ii
          left join part on ii.identifiableitem_id = part.identifiableitem_id
          left join preparation prep on part.preparation_id = prep.preparation_id
          left join catalogeditem ci on prep.catalogeditem_id = ci.catalogeditem_id
          left join collection col on ci.collection_id = col.collection_id
       where ii.identifiableitem_id = identifiableitemid and catalog_number is not null
       ) a
       ;
   declare continue handler for not found set done = 1;
   open cur;
   getnums: LOOP
      fetch cur into name;
      if done = 1 then
        LEAVE getnums;
      end if;
      SET result = concat(result,sep,name);
      SET sep = "|";
   END LOOP;
   return result;
END |

create function cco_full.getCollectionCode(identifiableitemid INT) 
returns varchar(2000)
-- Given an identifiable item, return the list of collection codes within which it is cataloged.
READS SQL DATA 
BEGIN
   declare result varchar(2000) default '';
   declare code varchar(255);
   declare sep varchar(2) default '';
   declare done int default 0;
   declare cur cursor for 
       select distinct collection_code from (
       select distinct  collection_code
       from identifiableitem ii
          left join catalogeditem ci on ii.catalogeditem_id = ci.catalogeditem_id
          left join collection col on ci.collection_id = col.collection_id
       where ii.identifiableitem_id = identifiableitemid and catalog_number is not null
       union
       select distinct collection_code
       from identifiableitem ii
          left join part on ii.identifiableitem_id = part.identifiableitem_id
          left join preparation prep on part.preparation_id = prep.preparation_id
          left join catalogeditem ci on prep.catalogeditem_id = ci.catalogeditem_id
          left join collection col on ci.collection_id = col.collection_id
       where ii.identifiableitem_id = identifiableitemid and catalog_number is not null
       ) a
       ;
   declare continue handler for not found set done = 1;
   open cur;
   getnums: LOOP
      fetch cur into code;
      if done = 1 then
        LEAVE getnums;
      end if;
      SET result = concat(result,sep,code);
      SET sep = "|";
   END LOOP;
   return result;
END |
create function cco_full.getInstitutionCode(identifiableitemid INT) 
returns varchar(2000)
-- Given an identifiable item, return the list of institution codes within which it is cataloged.
READS SQL DATA 
BEGIN
   declare result varchar(2000) default '';
   declare code varchar(255);
   declare sep varchar(2) default '';
   declare done int default 0;
   declare cur cursor for 
       select distinct institution_code from (
       select distinct  institution_code
       from identifiableitem ii
          left join catalogeditem ci on ii.catalogeditem_id = ci.catalogeditem_id
          left join collection col on ci.collection_id = col.collection_id
       where ii.identifiableitem_id = identifiableitemid and catalog_number is not null
       union
       select distinct institution_code
       from identifiableitem ii
          left join part on ii.identifiableitem_id = part.identifiableitem_id
          left join preparation prep on part.preparation_id = prep.preparation_id
          left join catalogeditem ci on prep.catalogeditem_id = ci.catalogeditem_id
          left join collection col on ci.collection_id = col.collection_id
       where ii.identifiableitem_id = identifiableitemid and catalog_number is not null
       ) a
       ;
   declare continue handler for not found set done = 1;
   open cur;
   getnums: LOOP
      fetch cur into code;
      if done = 1 then
        LEAVE getnums;
      end if;
      SET result = concat(result,sep,code);
      SET sep = "|";
   END LOOP;
   return result;
END |
-- changeset chicoreus:157 dbms:none
delimiter ;
-- changeset chicoreus:157 endDelimiter:; dbms:mysql
-- just a placeholder for the delimiter
select 'Changing delimiter';

--  The last liquibase changeset in this document was number 157

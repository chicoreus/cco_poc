-- liquibase formatted sql

-- changeset chicoreus:35 dbms:mysql

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

-- changeset chicoreus:36 dbms:mysql

drop function if exists cco_full.getHigherTaxonAtRank;


-- changeset chicoreus:37 dbms:none
delimiter |
-- changeset chicoreus:37 endDelimiter:\| dbms:mysql

-- Obtain the name of a higher taxon at a particular rank from an entry in the taxon tree.
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
   select scientific_name into sci_name from taxon  where taxon_id in ( 
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

-- changeset chicoreus:38  dbms:none
delimiter ;
-- changeset chicoreus:38 endDelimiter:; dbms:mysql

drop function if exists cco_full.getHigherGeographyAtRank;

-- changeset chicoreus:39 dbms:none
delimiter |

-- changeset chicoreus:39 endDelimiter:\| dbms:mysql

-- Obtain the name of a higher geography at a particular rank from an entry in the geography tree.
-- For example, obtain the family into which some species is placed.
-- 
-- @param geographyid the geography_id for the geography for which the higher geography is to be looked up.
-- @param rankid the rank_id for the higher geography.
--
-- @return the scientific name of the higher geography, if one is defined in the parentage of the
-- geography at the provided rank.
--
create function cco_full.getHigherGeographyAtRank(geographyid INT, rankid INT)
returns VARCHAR(255)
READS SQL DATA
BEGIN
   declare geog_name varchar(255);
   select name into geog_name from geography  where geography_id in ( 
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

-- changeset chicoreus:40 dbms:none
delimiter ;
-- changeset chicoreus:40 endDelimiter:; dbms:mysql

drop function if exists cco_full.getCurrentIdentification;
drop function if exists cco_full.getCurrentIdentID;
drop function if exists cco_full.getCurrentIdentTaxonID;

drop function if exists cco_full.getPreparations;

-- changeset chicoreus:41 dbms:none
delimiter |
-- changeset chicoreus:41 endDelimiter:\| dbms:mysql

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
   declare sep varchar(2) default '';
   declare done int default 0;
   declare cur cursor for 
      select distinct concat(preparation_type, ' (', preservation_type, ')') prep from part left join preparation on part.preparation_id = preparation.preparation_id where identifiableitem_id = identifiableitemid;
   declare continue handler for not found set done = 1;
   open cur;
   getpreps: LOOP
      fetch cur into prep;
      if done = 1 then
        LEAVE getpreps;
      end if;
      SET result = concat(result,sep,prep);
      SET sep = "|";
   END LOOP;
   return result;
END |


-- changeset chicoreus:42 dbms:none
delimiter ;
-- changeset chicoreus:42 endDelimiter:; dbms:mysql
-- just a placeholder for the delimiter
select 1;

--  The last liquibase changeset in this document was number 42

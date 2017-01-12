-- changeset chicoreus:35 

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
returns varchar(2000) 
deterministic
RETURN replace( substring(substring_index(string, delimiter, position), length(substring_index(string, delimiter, position-1))+1), delimiter, ''); 


drop function if exists cco_full.getHigherTaxonAtRank;


-- changeset chicoreus:37
-- endDelimiter | 

delimiter |
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

-- changeset chicoreus:38
-- endDelimiter ;
delimiter ;



drop function if exists cco_full.getHigherGeographyAtRank;

-- changeset chicoreus:39
-- endDelimiter |
delimiter |
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

-- changeset chicoreus:40
-- endDelimiter ;
delimiter ;

--  The last liquibase changeset in this document was number 40



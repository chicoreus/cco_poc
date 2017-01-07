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
   ) and rank_id = rankid limit 1;
   return sci_name;
END |

delimiter ;


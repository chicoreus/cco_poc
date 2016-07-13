
-- Optional constraints that may be desiarable for some 


-- To enforce a uniqueness constraint on catalog numbers within catalog number series, add this unique index.
-- This would not be suiatble for collections where historical material has duplicate catalog numbers and
-- policy or type status dictates that these cannot be recataloged. 
-- Note that duplicates in the same catalog number series could be handled by creating a new catalog number
-- series for duplicates.
create unique index idxu_catitem_catnum_cns on catalogeditem(catalog_number, catalog_number_series_id);

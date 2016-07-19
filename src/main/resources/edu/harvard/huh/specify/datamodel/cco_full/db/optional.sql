
-- Optional constraints that may be desireable for some situtations


-- To enforce a uniqueness constraint on catalog numbers within catalog number series, add this unique index.
-- This would not be suiatble for collections where historical material has duplicate catalog numbers and
-- policy or type status dictates that these cannot be recataloged. 
-- Note that duplicates in the same catalog number series could be handled by creating a new catalog number
-- series for duplicates.
create unique index idxu_catitem_catnum_cns on catalogeditem(catalog_number, catalog_number_series_id);


-- To support an object to image to ocr to data process that creates skeletal unit records with ocr information
-- an ocr field could be added to unit, and then constraints on units could be relaxed.
-- Alternatively, and probably more robustly, an OCR table could be created to hold raw ocr and metadata about the OCR process,
-- and then ocr text could be processed into collectingevent-unit-identifiableitem-preparation-catalogeditem records.
-- Lightweight ocr could be supported with
-- alter table unit add column ocr text default null;
-- which would probably require relaxing these not null constraints.
-- alter table unit change column collectingevent_id collectingevent_id bigint default null;
-- alter table identifiableitem change column unit_id unit_id bigint default null;

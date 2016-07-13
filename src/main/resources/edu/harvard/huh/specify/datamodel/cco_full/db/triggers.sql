-- add constraint, a preparation for which parent_preparation_id is not null is not allowed to have it's preparation_id present as the parent_preparation_id of any preparation.  needs a trigger.

delimiter //
create trigger tr_prep_const before update on preparation
for each row 
begin
   if new.parent_preparation_id is not null then
      select count(*) into @childcount from preparation where parent_preparation_id = new.parent_preparation_id;
      if  childcount > 0 then
--         update errorcantmakechildprep set nofield = nofield;
           signal sqlstate '45001' 
               set message_text = 'A preparation which is a child cannot itself have children.';
      end if;
   end if;
end;//
create trigger tr_prep_const before insert on preparation
for each row 
begin
   if new.parent_preparation_id is not null then
      select count(*) into @childcount from preparation where parent_preparation_id = new.parent_preparation_id;
      if  childcount > 0 then
--         update errorcantmakechildprep set nofield = nofield;
           signal sqlstate '45001' 
               set message_text = 'A preparation which is a child cannot itself have children.';
      end if;
   end if;
end;//
delimiter ;


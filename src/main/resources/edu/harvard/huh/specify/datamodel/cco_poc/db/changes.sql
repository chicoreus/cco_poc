-- liquibase formatted sql

-- changeset chicoreus:23

create table part ( 
  part_id bigint not null primary key auto_increment,
  item_id bigint not null,  
  preparation_id bigint not null,
  part_name varchar(50), 
  part_count number not null default 1,  -- number of items of part name, may be non-integral.
  part_count_modifier varchar(50),   --  ca., >, <
  remarks text
);


alter table item drop column preparation_id;



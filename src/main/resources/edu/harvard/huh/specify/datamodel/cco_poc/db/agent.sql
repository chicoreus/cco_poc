-- liquibase formatted sql

-- changeset chicoreus:22
-- Flesh out agents

alter table agents change column agent_type enum ('Individual','Team','Organization') default 'Individual';   --  foaf:Person,Group,Organization
-- semi-atomic parts of names of individuals.
alter table agents add column prefix varchar(32);  -- approximates foaf:title or honorificPrefix
alter table agents add column suffix varchar(32);
alter table agents add column first_name varchar(255);   --
alter table agents add column middle_names varchar(255);
alter table agents add column family_names varchar(255);
-- combined parts of names for individuals, name for organizations and teams.
alter table agents add column name_string text;     -- foaf:name xml:lang=en

--   Add fields to agents to add more metadata about the agent.
alter table agents add column guid varchar(900);  --  owl:sameAs  External GUID 
alter table agents add column uuid char(43);         --  rdf:about   GUID for this record
alter table agents add column biography text;        
alter table agents add column notes text;        
alter table agents add column taxonomic_groups varchar(900);
alter table agents add column collections_at varchar(900);
alter table agents add column curated boolean default false;
alter table agents add column not_otherwise_specified boolean default false;
alter table agents add column mbox_sha1sum char(40); -- foaf:mbox_sha1sum Note foaf spec, include mailto: prefix, but no trailing whitespace when computing.
alter table agents add column yearofbirth int;
alter table agents add column yearofbirthmodifier varchar(12) default '';
alter table agents add column yearofdeath int;
alter table agents add column yearofdeathmodifier varchar(12) default '';
alter table agents add column startyearactive int;
alter table agents add column endyearactive int;
alter table agents add column living enum('Y','N','?') not null default '?';

-- changeset chicoreus:23
-- add additional tables to support agents

create table ctrelationshiptypes (
   -- Types of relationships between pairs of agents.
   relationship varchar(50) not null primary key,
   inverse varchar(50),
   collective varchar(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into ctrelationshiptypes (relationship, inverse, collective) values ('Child of', 'Parent of', 'Children');
insert into ctrelationshiptypes (relationship, inverse, collective) values ('Student of', 'Teacher of', 'Students');
insert into ctrelationshiptypes (relationship, inverse, collective) values ('Spouse of', 'Spouse of', 'Married to');
insert into ctrelationshiptypes (relationship, inverse, collective) values ('Could be', 'Confused with', 'Confused with');  -- to accompany notOtherwiseSpecified 

create table ctnametypes (
   -- Types of agent names
   type varchar(32) not null primary key
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into ctnametypes (type) values ('Full Name');
insert into ctnametypes (type) values ('Initials Last Name');
insert into ctnametypes (type) values ('Last Name, Initials');
insert into ctnametypes (type) values ('First Initials Last');
insert into ctnametypes (type) values ('First Last');
insert into ctnametypes (type) values ('Standard Abbreviation');
insert into ctnametypes (type) values ('Standard DwC List');
insert into ctnametypes (type) values ('Also Known As');

create table agentteams (
   --  To allow agents to represent teams of individuals.
   agentteamid bigint not null primary key auto_increment,
   teamagentid bigint not null, 
   memberagentid bigint not null, 
   ordinal int,
   FOREIGN KEY (teamagentid) REFERENCES agents(agentid) ON DELETE NO ACTION ON UPDATE CASCADE,
   FOREIGN KEY (memberagentid) REFERENCES agents(agentid) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table agentnumberpattern (
   --  Machine and human redable descriptions of collector number patterns
   agentnumberpatternid bigint not null primary key auto_increment,
   agentid bigint not null,
   numbertype varchar(50) default 'Collector number',
   numberpattern varchar(255),  --  regular expression for numbers that conform with this pattern
   numberpatterndescription varchar(900),  -- human readable description of the number pattern
   startyear int, --  year for first known occurrence of this number pattern
   endyear int,   --  year for last knon occurrenc of this number pattern
   integerincrement int, -- does number have an integer increment 
   notes text, 
   FOREIGN KEY (agentid) REFERENCES agents(agentid) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table referenceagentlinks (
   --  Alowing links to references about collectors/agents (e.g. obituaries).
   refid int not null, 
   agentid int not null, 
   primary key (refid, agentid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table agentlinks (
   --  Supporting hyperlinks out to external sources of information about collectors/agents.
   agentlinksid bigint primary key not null auto_increment, 
   agentid int not null, 
   type varchar(50), 
   link varchar(900), 
   isprimarytopicof boolean not null default true,  --  link can be represented as foaf:primaryTopicOf
   text varchar(50), 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create table agentnames (
   --  Supporting multiple variant forms of names and names for a collector/agent
   agentnamesid bigint primary key not null auto_increment, 
   agentid int not null,  
   type varchar(32) not null default 'Full Name', 
   name  varchar(255), 
   language varchar(6) default 'en_us', 
   FOREIGN KEY (type) REFERENCES ctnametypes(type) ON DELETE NO ACTION ON UPDATE CASCADE,
   FOREIGN KEY (agentid)  REFERENCES agents(agentid)  ON DELETE CASCADE  ON UPDATE CASCADE,
   CONSTRAINT UNIQUE INDEX (agentid,type,name) --  Combination of recordedbyid, name, and type must be unique.
) ENGINE=MyISAM DEFAULT CHARSET=utf8;  -- to ensure support for fulltext index
create fulltext index ft_collectorname on agentnames(name);


create table agentrelations (
   --  Representing relationships (family,marrage,mentorship) amongst agents.
   agentrelationsid bigint not null primary key auto_increment, 
   fromagentid bigint not null,  --  parent agent in this relationship 
   toagentid bigint not null,    --  child agent in this relationship 
   relationship varchar(50) not null,  -- nature of relationship from ctrelationshiptypes 
   notes varchar(900),
   FOREIGN KEY (fromagentid) REFERENCES agents(agentid) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (toagentid) REFERENCES agents(agentid) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (relationship) REFERENCES ctrelationshiptypes(relationship) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


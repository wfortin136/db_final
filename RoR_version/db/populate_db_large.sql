#truncate table users;
#insert into locations values (null, null, null, null, null);

TRUNCATE TABLE promotions;
#1-4
INSERT INTO promotions VALUES (null,'UFC');
set @ufc = last_insert_id();
INSERT INTO promotions VALUES (null,'Strikeforce');
set @stf = last_insert_id();
INSERT INTO promotions VALUES (null,'Bellator');
set @bell = last_insert_id();
INSERT INTO promotions VALUES (null, 'Pride');
set @prid = last_insert_id();

TRUNCATE TABLE weightclasses;
#1-8
INSERT INTO weightclasses VALUES (null ,'Flyweight', 125);
set @fly = last_insert_id();
INSERT INTO weightclasses VALUES (null ,'Bantomweight', 135);
set @ban = last_insert_id();
INSERT INTO weightclasses VALUES (null ,'Featherweight', 145);
set @fet = last_insert_id();
INSERT INTO weightclasses VALUES (null ,'Lightweight', 155);
set @lit = last_insert_id();
INSERT INTO weightclasses VALUES (null ,'Welterweight', 170);
set @wel = last_insert_id();
INSERT INTO weightclasses VALUES (null ,'Middleweight', 185);
set @mid = last_insert_id();
INSERT INTO weightclasses VALUES (null ,'Light Heavyweight', 205);
set @lhw = last_insert_id();
INSERT INTO weightclasses VALUES (null ,'Heavyweight', 265);
set @hw = last_insert_id();

truncate table locations;
load data local infile 'data/locations.txt' into table locations
fields terminated by '::';

truncate table fighters;
load data local infile 'data/fighters.txt' into table fighters
fields terminated by '::';

truncate table judges;
load data local infile 'data/judges.txt' into table judges
fields terminated by '::';

truncate table fightcards;
load data local infile 'data/fightcards.txt' into table fightcards
fields terminated by '::';

truncate table fights;
load data local infile 'data/fights.txt' into table fights
fields terminated by '::';

truncate table fightstats;
load data local infile 'data/fightstats.txt' into table fightstats
fields terminated by '::';

truncate table judgescores;
load data local infile 'data/judgescores.txt' into table judgescores
fields terminated by '::';


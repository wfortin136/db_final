DROP TABLE IF EXISTS users;
create table users(
  id int PRIMARY KEY auto_increment,
  name varchar(15),
  email varchar(15),
  admin boolean,
  password_digest varchar(15));

DROP TABLE IF EXISTS locations;
create table locations(
  location_id int PRIMARY KEY auto_increment,
  city varchar(15),
  state varchar(15),
  country varchar(15));

DROP TABLE IF EXISTS promotions;
CREATE TABLE promotions(
  promotion_id int PRIMARY KEY auto_increment,
  name varchar(50));

DROP TABLE IF EXISTS weightclasses;
CREATE TABLE weightclasses(
  weightclass_id int PRIMARY KEY auto_increment,
  className varchar(50),
  weight int);

DROP TABLE IF EXISTS fightcards;
CREATE TABLE fightcards(
  fightcard_id int PRIMARY KEY auto_increment,
  promotion_id int,
  fightcardName varchar(90),
  location_id int,
  fightDate date);

DROP TABLE IF EXISTS fighters;
CREATE TABLE fighters(
  fighter_id int PRIMARY KEY auto_increment,
  fighterName varchar(20),
  wins int,
  losses int,
  draws int,
  nc int);

DROP TABLE IF EXISTS champhists;
CREATE TABLE champhists(
  champhist_id int PRIMARY KEY auto_increment,
  promomotion_id int,
  weightclass_id int, 
  fighter_id int,
  start date,
  end date);

DROP TABLE IF EXISTS fights;
CREATE TABLE fights(
  fight_id int PRIMARY KEY auto_increment,
  fightcard_id int,
  fightNum int,
  weightclass_id int,
  cardLevel int,
  championship boolean,
  fightTime int,
  method varchar(100));

DROP TABLE IF EXISTS fightstats;
CREATE TABLE fightstats(
  fightstats_id int PRIMARY KEY auto_increment,
  fight_id int,
  fighter_id int,
  round int,
  kd int,
  str_landed int,
  str_thrown int,
  td_att int,
  td_com int,
  sub_att int);

-- ALTER TABLE Fightstats DROP INDEX FS_fightID;
create index FS_fightID
on fightstats (fight_id);

DROP TABLE IF EXISTS fighterstats;
#CREATE TABLE fighterstats(
#  fighterstatID int PRIMARY KEY auto_increment,
#  fighterID int,
#  round int,
#  kd int,
#  str_landed int,
#  str_thrown int,
#  td_att int,
#  td_com int,
#  sub_att int);

DROP TABLE IF EXISTS judges;
CREATE TABLE judges(
  judge_id int PRIMARY KEY auto_increment,
  judgeName varchar(20));

DROP TABLE IF EXISTS scorecards;
#CREATE TABLE scorecards(
#  scorecardID int PRIMARY KEY auto_increment,
#  judgeID int,
#  fightID int,
#  fighterID int,
#  tot_score int);

DROP TABLE IF EXISTS judgescores;
CREATE TABLE judgescores(
  judgescore_id int PRIMARY KEY auto_increment,
  judge_id int,
  fight_id int,
  fighter_id int,
  round int,
  score int);

-- ALTER TABLE Judgescore DROP INDEX J_fightID;
create index J_fightID
on judgescores (fight_id);

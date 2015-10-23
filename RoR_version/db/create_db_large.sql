DROP TABLE IF EXISTS Location;
create table Location(
  location_id int PRIMARY KEY auto_increment,
  city varchar(15),
  state varchar(15),
  country varchar(15));

DROP TABLE IF EXISTS Promotion;
CREATE TABLE Promotion(
  promomotion_id int PRIMARY KEY auto_increment,
  name varchar(50));

DROP TABLE IF EXISTS Weightclass;
CREATE TABLE Weightclass(
  weightclass_id int PRIMARY KEY auto_increment,
  className varchar(50),
  weight int);

DROP TABLE IF EXISTS Fightcard;
CREATE TABLE Fightcard(
  fightcard_id int PRIMARY KEY auto_increment,
  promotion_id int,
  fightcardName varchar(20),
  location_id int,
  fightDate date);

DROP TABLE IF EXISTS Fighter;
CREATE TABLE Fighter(
  fighter_id int PRIMARY KEY auto_increment,
  fighterName varchar(20),
  wins int,
  losses int,
  draws int,
  nc int);

DROP TABLE IF EXISTS Champhist;
CREATE TABLE Champhist(
  champhist_id int PRIMARY KEY auto_increment,
  promomotion_id int,
  weightclass_id int, 
  fighter_id int,
  start date,
  end date);

DROP TABLE IF EXISTS Fight;
CREATE TABLE Fight(
  fight_id int PRIMARY KEY auto_increment,
  fightcard_id int,
  fightNum int,
  weightclass_id int,
  cardLevel int,
  championship boolean,
  fightTime int,
  method varchar(100));

DROP TABLE IF EXISTS Fightstats;
CREATE TABLE Fightstats(
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
on Fightstats (fight_id);

DROP TABLE IF EXISTS Fighterstats;
#CREATE TABLE Fighterstats(
#  fighterstatID int PRIMARY KEY auto_increment,
#  fighterID int,
#  round int,
#  kd int,
#  str_landed int,
#  str_thrown int,
#  td_att int,
#  td_com int,
#  sub_att int);

DROP TABLE IF EXISTS Judge;
CREATE TABLE Judge(
  judge_id int PRIMARY KEY auto_increment,
  judgeName varchar(20));

DROP TABLE IF EXISTS Scorecard;
#CREATE TABLE Scorecard(
#  scorecardID int PRIMARY KEY auto_increment,
#  judgeID int,
#  fightID int,
#  fighterID int,
#  tot_score int);

DROP TABLE IF EXISTS Judgescore;
CREATE TABLE Judgescore(
  judgescore_id int PRIMARY KEY auto_increment,
  judge_id int,
  fight_id int,
  fighter_id int,
  round int,
  score int);

-- ALTER TABLE Judgescore DROP INDEX J_fightID;
create index J_fightID
on Judgescore (fight_id);

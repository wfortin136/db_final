-- SET profiling = 1;
-- (1)
-- Show fightcard name, fighternames, and weightclass name
select fightcardName, F1.fighterName, F2.fighterName, C.className
from Fight F
natural join Fightcard
inner join Fightstats as A
on F.fightID = A.fightID
inner join Fightstats as B
on B.fightID = A.fightID
inner join Fighter as F1
on F1.fighterID = A.fighterID
inner join Fighter as F2
on F2.fighterID = B.fighterID
inner join Weightclass as C
on F.weightClass = C.classID
where A.fighterID > B.fighterID 
group by F.fightID, A.fighterID, B.fighterID;

-- (2)
-- Show everyone who has fought fighter 94
select F.fighterName as Fighter
from Fightstats B
join Fighter as F
using (fighterID)
where B.fighterID != 94 AND B.fightID in(
  select fightID
  from Fightstats A
  where A.fighterID = 94
  group by fightID)
group by Fighter;

-- check
select fightcardName, F1.fighterName, F2.fighterName, C.className
from Fight F
natural join Fightcard
inner join Fightstats as A
on F.fightID = A.fightID
inner join Fightstats as B
on B.fightID = A.fightID
inner join Fighter as F1
on F1.fighterID = A.fighterID
inner join Fighter as F2
on F2.fighterID = B.fighterID
inner join Weightclass as C
on F.weightClass = C.classID
where A.fighterID > B.fighterID and (A.fighterID = 94 or B.fighterID =94)
group by F.fightID, A.fighterID, B.fighterID;

-- (3)
-- Faster version of previous using join. This is much faster because it
-- is not using "in" within the where clause
select F.fighterName as Fighter
from Fightstats B
join Fighter as F
using (fighterID)
inner join Fightstats A
on B.fightID = A.fightID
where A.fighterID = 94 and B.fighterID != 94
group by Fighter;

-- (4) 
-- which fighter has had the most strikes landed against them per round
select F.fighterName, sum(B.str_landed)/count(*) str_received_per_round
from Fightstats A
inner join Fightstats B
on A.fightID = B.fightID
inner join Fighter F
on F.fighterID = A.fighterID
where A.fighterID <> B.fighterID and A.round = B.round
group by A.fighterID
order by str_received_per_round desc;

-- (5) 
-- ordered list of fighter takedown defense
select A.fighterID, (1-sum(B.td_com)/sum(B.td_att)) td_defense
from Fightstats A
inner join Fightstats B
on A.fightID = B.fightID
where A.fighterID <> B.fighterID and A.round = B.round
group by A.fighterID
order by td_defense desc;

-- (6)
-- Get a list of the top 10 fighters who have the most fights
-- without a title fight

select Fighter.fighterName, count(*) num_fights
from (
  -- output the fight and fighterid of all fighters with no title fights
  select FS.fightID fightID, FS.fighterID fighterID
  from Fightstats FS
  inner join(
    select nontitle_f fighterID
    from (
      -- get all fighters of non title fights
      select B.fighterID nontitle_f
      from Fight A
      join Fightstats B using (fightID)
      where championship is False
      group by B.fighterID) X
    left outer join (
      -- get all fighters of title fights
      select C.fighterID title_f
      from Fight D
      join Fightstats C using (fightID)
      where championship is True
      group by C.fighterID) Y
    on X.nontitle_f = Y.title_f
    -- only take fighters who have had no title fights
    where title_f is Null) NT_F
  on FS.fighterID = NT_F.fighterID
  group by FS.fightID, FS.fighterID) LIST
inner join Fighter on Fighter.fighterID = LIST.fighterID
group by LIST.fighterID
order by num_fights desc
limit 10;

-- (7)
-- get percentage of time a judge has not scored a 9 or 10
select count(*)/(select count(*) from Judgescore)
from Judgescore A 
  left outer join (
    select judgescoreID
    from Judgescore
    where score > 8) B 
  on A.judgescoreID = B.judgescoreID
where B.judgescoreID is Null;

-- check
select (select count(*) from Judgescore where score<9)/count(*)
from Judgescore A; 

-- (8)
-- Get name of fighter who judge scored round for. Even rounds will
-- not be returned
select distinct A.fightID, A.judgeID, A.round, A.fighterID
from Judgescore A
inner join Judgescore B on A.fightID = B.fightID and A.judgeID = B.judgeID
where A.score>B.score and A.round = B.round;

-- (9)
-- Get fighter who landed most punches and fighter who landed 
-- most takedowns in each round, equal values will return a null
select *
from(
  select distinct FS.fightID, FS.round, Y.fighterID Takedowns, X.fighterID Strikes
  from Fightstats FS
    inner join (
      select C.fightID fightID, C.round round, C.fighterID
      from Fightstats C
      inner join Fightstats D on D.fightID = C.fightID
      where C.td_com>D.td_com and C.round = D.round) Y
    on FS.fightID = Y.fightID and FS.round =Y.round
    left outer join (
      select A.fightID fightID, A.round round, A.fighterID
      from Fightstats A
      inner join Fightstats B on A.fightID = B.fightID
      where A.str_landed>B.str_landed and A.round = B.round) X
    on Y.fightID = X.fightID and Y.round =X.round
  union
  select distinct FS.fightID, FS.round, Y.fighterID Takedowns, X.fighterID Strikes
  from Fightstats FS
    inner join (
      select C.fightID fightID, C.round round, C.fighterID
      from Fightstats C
      inner join Fightstats D on D.fightID = C.fightID
      where C.str_landed>D.str_landed and C.round = D.round) Y
    on FS.fightID = Y.fightID and FS.round =Y.round
    left outer join (
      select A.fightID fightID, A.round round, A.fighterID
      from Fightstats A
      inner join Fightstats B on A.fightID = B.fightID
      where A.td_com>B.td_com and A.round = B.round) X
    on Y.fightID = X.fightID and Y.round =X.round) FINAL
order by 1;

-- (10)
-- combine query 9 and 10 to get the fighter the judge scored in favor of
-- for each round, and the actual stats of takedowns and strikes
-- This will show the fight, the judge, the round, who the judge scored for
-- and the most strikes landed and succeful takedowns from one of the fighters
-- in the fight. Null values represent equal number of strikes/takedowns

#SET profiling = 1;

select distinct Score.fightID, Score.judgeID, Score.round, Score.fighterID, Stats.Takedowns, Stats.Strikes
from (
  select distinct A.fightID, A.judgeID, A.round, A.fighterID
  from Judgescore A
  inner join Judgescore B on A.fightID = B.fightID and A.judgeID = B.judgeID
  where A.score>B.score and A.round = B.round) Score
  left outer join(
  select distinct FS.fightID, FS.round, Y.fighterID Takedowns, X.fighterID Strikes
  from Fightstats FS
    inner join (
      select C.fightID fightID, C.round round, C.fighterID
      from Fightstats C
      inner join Fightstats D on D.fightID = C.fightID
      where C.td_com>D.td_com and C.round = D.round) Y
    on FS.fightID = Y.fightID and FS.round =Y.round
    left outer join (
      select A.fightID fightID, A.round round, A.fighterID
      from Fightstats A
      inner join Fightstats B on A.fightID = B.fightID
      where A.str_landed>B.str_landed and A.round = B.round) X
    on Y.fightID = X.fightID and Y.round =X.round
  union
  select distinct FS.fightID, FS.round, Y.fighterID Takedowns, X.fighterID Strikes
  from Fightstats FS
    inner join (
      select C.fightID fightID, C.round round, C.fighterID
      from Fightstats C
      inner join Fightstats D on D.fightID = C.fightID
      where C.str_landed>D.str_landed and C.round = D.round) Y
    on FS.fightID = Y.fightID and FS.round =Y.round
    left outer join (
      select A.fightID fightID, A.round round, A.fighterID
      from Fightstats A
      inner join Fightstats B on A.fightID = B.fightID
      where A.td_com>B.td_com and A.round = B.round) X
    on Y.fightID = X.fightID and Y.round =X.round) Stats
  on Score.fightID = Stats.fightID and Score.round = Stats.round
order by Score.fightID, Score.judgeID, Score.round;
/*
-- TEMP TABLE from query 8
create temporary table Score
select distinct A.fightID, A.judgeID, A.round, A.fighterID
from Judgescore A
inner join Judgescore B on A.fightID = B.fightID and A.judgeID = B.judgeID
where A.score>B.score and A.round = B.round;

-- TEMP TABLE from query 9
create temporary table Stats
select distinct FS.fightID, FS.round, Y.fighterID Takedowns, X.fighterID Strikes
from Fightstats FS
  inner join (
    select C.fightID fightID, C.round round, C.fighterID
    from Fightstats C
    inner join Fightstats D on D.fightID = C.fightID
    where C.td_com>D.td_com and C.round = D.round) Y
  on FS.fightID = Y.fightID and FS.round =Y.round
  left outer join (
    select A.fightID fightID, A.round round, A.fighterID
    from Fightstats A
    inner join Fightstats B on A.fightID = B.fightID
    where A.str_landed>B.str_landed and A.round = B.round) X
  on Y.fightID = X.fightID and Y.round =X.round
union
select distinct FS.fightID, FS.round, Y.fighterID Takedowns, X.fighterID Strikes
from Fightstats FS
  inner join (
    select C.fightID fightID, C.round round, C.fighterID
    from Fightstats C
    inner join Fightstats D on D.fightID = C.fightID
    where C.str_landed>D.str_landed and C.round = D.round) Y
  on FS.fightID = Y.fightID and FS.round =Y.round
  left outer join (
    select A.fightID fightID, A.round round, A.fighterID
    from Fightstats A
    inner join Fightstats B on A.fightID = B.fightID
    where A.td_com>B.td_com and A.round = B.round) X
  on Y.fightID = X.fightID and Y.round =X.round;

select Score.fightID, Score.judgeID, Score.round, Score.fighterID, Stats.Takedowns, Stats.Strikes
from Score
left outer join Stats on Score.fightID = Stats.fightID and Score.round = Stats.round;
*/
# display the time for quesries to compare 
# temp table performance vs. nested queries
# show profiles;

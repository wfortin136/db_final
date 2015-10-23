#Derive Fighterstats table from Fightstats

create or replace view fighterstats as
select fighter_id, round, sum(kd) tot_kd, sum(str_landed) tot_str_landed, sum(str_thrown) tot_str_thrown, sum(td_att) tot_td_att,
        sum(td_com) tot_td_com, sum(sub_att) tot_sub_att
from fightstats
group by fighter_id, round;

#Derive Scorcards from Judgescore
#create or replace view Scorecard as
#select judgeID, fightID, fighterID, sum(score)
#from Judgescore
#group by judgeID, fightID, fighterID;

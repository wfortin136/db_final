select A.*, B.avg_score
from (select * from fighterstats where 15=fighter_id) A
inner join (
  select J.fighter_id ID, round, avg(score) avg_score
      from judgescores J
      inner join fights FI on J.fight_id = FI.fight_id
      inner join fightcards FC on FC.fightcard_id = FI.fightcard_id
      where J.fighter_id = 15
      group by J.fighter_id, round) B
on A.fighter_id = B.ID and A.round =B.round;

select A.*, B.avg_score
from (
  select fighter_id, sum(tot_kd), sum(tot_str_landed), 
      sum(tot_str_thrown), sum(tot_td_att), 
      sum(tot_td_com), sum(tot_sub_att) 
      from fighterstats where 15=fighter_id 
      group by fighter_id) A
inner join (
  select J.fighter_id ID, avg(score) avg_score
      from judgescores J
      inner join fights FI on J.fight_id = FI.fight_id
      inner join fightcards FC on FC.fightcard_id = FI.fightcard_id
      where J.fighter_id = 15
      group by J.fighter_id) B
on A.fighter_id = B.ID;

select judge_id, count(*)
from( 
  select judge_id, fight_id from judgescores
  group by judge_id, fight_id) A
group by judge_id;

#select JU.judgeName, FC.fightcardName, F1.fighterName, JS.round, JS.score, A.avg_score,
#    abs(JS.score - A.avg_score)
#    from judgescores JS
#      inner join (
#        select J.fight_id, J.fighter_id, J.round, avg(score) as avg_score
#        from judgescores J
#        inner join fighters F on F.fighter_id = J.fighter_id
#        group by J.fight_id, J.fighter_id, J.round) A
#      on A.fight_id = JS.fight_id and A.fighter_id = JS.fighter_id and A.round = JS.round
#      inner join fighters F1 on F1.fighter_id = JS.fighter_id
#      inner join fights FI on JS.fight_id = FI.fight_id
#      inner join fightcards FC on FC.fightcard_id = FI.fightcard_id
#      inner join judges JU on JU.judge_id = JS.judge_id;

select ONE.*, TWO.avg_dev
from (
  select judge_id, count(*)
  from( 
    select judge_id, fight_id from judgescores
    group by judge_id, fight_id) A
  group by judge_id) ONE
inner join (
  select A.j_id j_id, avg(A.dev) avg_dev
  from (
  select JS.judge_id j_id, JS.fighter_id f_id, JS.round round, abs(JS.score - A.avg_score) dev
      from judgescores JS
        inner join (
          select J.fight_id, J.fighter_id, J.round, avg(score) as avg_score
          from judgescores J
          inner join fighters F on F.fighter_id = J.fighter_id
          group by J.fight_id, J.fighter_id, J.round) A
        on A.fight_id = JS.fight_id and A.fighter_id = JS.fighter_id and 
        A.round = JS.round) A
  group by A.j_id) TWO
on ONE.judge_id = TWO.j_id;

select * 
from fightstats
where fight_id = 10
order by round, fighter_id;

select *
from judgescores
where fight_id = 10
order by round, fighter_id, judge_id;

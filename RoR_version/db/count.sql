-- Initial row count using estimates from information_schema. Not accurate

select TABLE_NAME, TABLE_ROWS
from information_schema.tables
where TABLE_SCHEMA = 'wjf136DB'
order by 2 desc;

-- Needed to increase max_len of group_concat in order to run querry below
SET SESSION group_concat_max_len = 1000000;

-- used this post as a reference to build accurate row count
-- https://www.periscopedata.com/blog/exact-row-counts-for-every-database-table.html

select
  concat('select * from(', 
    group_concat(
      concat(
      'select ', quote(tablename), ' _TABLENAME_, ' 'count(1) "_ROWCOUNT_" ' ,
      'from ', db, '.', tablename)
    separator ' union ')
  , ') t order by 2 desc')
into @sql
from (
select table_schema db, table_name tablename
from information_schema.tables 
where table_schema ='wjf136DB') t;

-- Execute @sql
prepare s from @sql; 
execute s; 
deallocate prepare s;

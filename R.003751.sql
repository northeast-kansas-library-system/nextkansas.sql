/*
R.003751

----------

Name: Date, datetime, and timestamp fields
Created by: George Williams

----------

Group: -
     -

Created on: 2023-08-11 14:30:56
Modified on: 2023-12-20 16:27:59
Date last run: 2023-12-29 15:18:17

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  tab.TABLE_SCHEMA AS database_schema,
  Concat_Ws('.', tab.TABLE_NAME, col.COLUMN_NAME) AS table_and_field,
  col.DATA_TYPE AS data_type,
  col.ORDINAL_POSITION AS column_id
FROM
  information_schema.TABLES AS tab 
  JOIN 
    information_schema.COLUMNS AS col ON col.TABLE_SCHEMA = tab.TABLE_SCHEMA AND
    col.TABLE_NAME = tab.TABLE_NAME
WHERE
  tab.TABLE_TYPE = 'BASE TABLE' AND
  tab.TABLE_SCHEMA NOT IN ('information_schema', 'mysql', 'performance_schema',
  'sys') AND
  col.DATA_TYPE IN ('date', 'time', 'datetime', 'year', 'timestamp')
ORDER BY
  col.TABLE_NAME,
  column_id


























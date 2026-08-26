/*
R.003677

----------

Name: Sandbox - withdrawn items
Created by: George Williams

----------

Group: -
     -

Created on: 2022-11-08 16:11:07
Modified on: 2026-08-26 00:30:01
Date last run: 2026-08-26 00:30:01

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
    saved_sql.id,
    Length(saved_sql.savedsql) AS original_length,
    Length(
        Replace(
            Replace(saved_sql.savedsql, '<', '<'),
            '*', '*'
        )
    ) AS processed_length,
    Length(
        SubString(
            Replace(
                Replace(saved_sql.savedsql, '<', '<'),
                '*', '*'
            )
            FROM 1 FOR 30000
        )
    ) AS part_one_length
FROM saved_sql
WHERE saved_sql.id = 3879


























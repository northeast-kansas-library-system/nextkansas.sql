/*
R.003538

----------

Name: GHW - Build report schedule links
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-07-30 11:10:44
Modified on: 2021-07-30 11:12:13
Date last run: 2021-07-30 11:12:16

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws("",
    "https://staff.nextkansas.org/cgi-bin/koha/tools/scheduler.pl?id=",
    saved_sql.id
  ) AS RAW_URL,
  Concat_Ws("", 
   "george@nekls.org --subject='", 
   SubString(saved_sql.report_name FROM 7), 
   "' --format=csv --csv-header -a"
  ) AS INFO
FROM
  saved_sql
WHERE
  saved_sql.report_subgroup = 'STAT_LM'
ORDER BY
  saved_sql.report_name DESC


























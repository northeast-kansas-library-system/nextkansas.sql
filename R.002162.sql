/*
R.002162

----------

Name: Fix Reports without New Target Option
Created by: Heather Braum

----------

Group: Administrative Reports
     Reports-admin

Created on: 2014-01-15 00:24:48
Modified on: 2014-08-09 00:35:48
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=',id,'&phase=Edit%20SQL\" target="_blank">',id,'</a>') AS "Edit Report" FROM saved_sql WHERE savedsql LIKE '%CONCAT%' and savedsql NOT LIKE '%target%' and savedsql LIKE '%/cgi-bin%'




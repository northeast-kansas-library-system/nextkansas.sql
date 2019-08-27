/*
R.002043

----------

Name: Reports missing Group category
Created by: Heather Braum

----------

Group: Administrative Reports
     Reports-admin

Created on: 2013-09-21 16:11:08
Modified on: 2014-08-09 00:36:14
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT report_name, notes, report_group, report_subgroup, CONCAT ('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=',id,'&phase=Edit%20SQL\" target="_blank">'"edit report"'</a>') AS "Edit Report", id, date_created, last_modified, CONCAT ('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=',id,'&phase=Run%20this%20report\" target="_blank">'"run report"'</a>') AS "Run Report" FROM saved_sql WHERE report_group IS NULL OR report_group = '' ORDER BY report_name




/*
R.003338

----------

Name: Debit Codes
Created by: Bywater bwssupport

----------

Group: -
     -

Created on: 2020-07-09 14:05:15
Modified on: 2020-07-09 14:05:43
Date last run: 2020-07-09 14:10:04

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=3337&phase=Run+this+report&param_name=Gimme+a+code&sql_params=', code ,'\">',code,'</a>') AS code,
	description
FROM account_debit_types




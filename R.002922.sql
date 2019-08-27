/*
R.002922

----------

Name: Checkouts & Renewals in Date Range
Created by: Bywater bwssupport

----------

Group: -
     -

Created on: 2017-03-09 12:12:53
Modified on: 2017-03-09 12:12:53
Date last run: 2018-08-30 13:29:00

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT type, count(datetime) AS count 
FROM statistics 
WHERE datetime BETWEEN <<Checked out BETWEEN (yyyy-mm-dd)|date>> 
      AND <<and (yyyy-mm-dd)|date>> AND type IN ('issue','renew') 
GROUP BY type




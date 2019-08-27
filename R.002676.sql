/*
R.002676

----------

Name: BWS test
Created by: Bywater bwssupport

----------

Group: -
     -

Created on: 2016-03-07 15:29:21
Modified on: 2016-03-07 15:30:11
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT * FROM message_queue WHERE date(time_queued)='2016-03-07' AND to_address LIKE 'patronupdat%@basehorlibrary.org'




/*
R.002677

----------

Name: Library overdue notices for patrons without email addresses
Created by: Bywater bwssupport

----------

Group: Administrative Reports
     Overdues-admin

Created on: 2016-03-08 09:05:39
Modified on: 2016-03-08 09:46:38
Date last run: 2017-10-13 09:30:48

----------

Public: 0
Expiry: 0

----------

Runs for current day 

----------
*/

SELECT branchname, time_queued, to_address, status, message_id, content
FROM message_queue 
LEFT JOIN branches ON branchemail = to_address
WHERE date(time_queued) = CURDATE() AND branchname IS NOT NULL AND to_address <> '' AND letter_code=''
ORDER BY branchcode
LIMIT 100




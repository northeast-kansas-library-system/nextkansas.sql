/*
R.001907

----------

Name: Notices Sent to a Specific Patron
Created by: Heather Braum

----------

Group: Notices
     -

Created on: 2013-06-11 15:32:54
Modified on: 2013-06-17 00:55:59
Date last run: -

----------

Public: 0
Expiry: 0

----------

Enter patron's borrowernumber (database number) to see all the messages sent to them by email or holds slips printed at the library.

----------
*/

SELECT borrowernumber, message_id, content FROM message_queue WHERE borrowernumber=<<patron borrowernumber>> GROUP BY message_id, borrowernumber




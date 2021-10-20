/*
R.001909

----------

Name: Message Queue table (all notices)
Created by: Heather Braum

----------

Group: Borrowers
     -

Created on: 2013-06-11 16:20:56
Modified on: 2013-06-11 16:20:56
Date last run: 2020-02-18 11:42:28

----------

Public: 0
Expiry: 300

----------

A list of all messages sent to patrons at a certain library (patrons who have email addresses, anyway). 

----------
*/



SELECT message_id, CONCAT('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',borrowernumber,'\" target="_blank">',borrowernumber,'</a>'), borrowernumber, borrowers.branchcode, subject, content, metadata, letter_code, message_transport_type, status, time_queued, to_address, from_address, content_type FROM message_queue LEFT JOIN borrowers USING (borrowernumber) WHERE borrowers.branchcode=<<choose branch|branches>> GROUP BY message_id ORDER BY time_queued DESC


























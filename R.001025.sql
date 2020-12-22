/*
R.001025

----------

Name: Show Pending Email Notices
Created by: -

----------

Group: Notices
     -

Created on: 2011-01-12 09:49:18
Modified on: 2013-06-21 13:49:26
Date last run: 2020-10-14 12:47:46

----------

Public: 0
Expiry: 0

----------

Shows Borrowernumber, subject, and time queued for email notices where the status = pending

----------
*/

select borrowernumber, borrowers.surname, borrowers.firstname, subject, time_queued from message_queue JOIN borrowers USING (borrowernumber) where borrowers.branchcode=<<branch|branches>> AND status = 'pending' and message_transport_type = 'email'





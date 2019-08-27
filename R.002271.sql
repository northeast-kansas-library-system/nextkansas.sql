/*
R.002271

----------

Name: Patrons who received Overdue Notice emails today at a library
Created by: Bywater bwssupport

----------

Group: Circulation
     Overdues

Created on: 2014-06-05 07:39:53
Modified on: 2014-06-05 12:33:00
Date last run: 2017-11-29 18:11:42

----------

Public: 0
Expiry: 0

----------



----------
*/

select b.firstname, b.surname, l.name, m.content from letter l, message_queue m, borrowers b WHERE l.code=m.letter_code AND m.borrowernumber=b.borrowernumber AND DATE(time_queued) = CURRENT_DATE(
) AND b.branchcode = <<Patron library|branches>> AND m.letter_code IN ('ATCH1','ATCH2','ATCH3','LATE','OVERDUE','FREEZE')




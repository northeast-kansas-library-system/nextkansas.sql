/*
R.001561

----------

Name: Pending Purchase Suggestions (by Branch)
Created by: Heather Braum

----------

Group: Acquisitions
     Purchase Requests

Created on: 2012-09-27 11:50:07
Modified on: 2018-07-02 09:32:01
Date last run: 2025-03-26 16:46:54

----------

Public: 0
Expiry: 0

----------

Limited by Branch. Edit requests directly from this report by clicking on the Answer Request link. #special

----------
*/



SELECT
  Concat('All Pending Suggestions') AS "All Pending Suggestions",
  Concat('Answer Request') AS Request,
  Concat('', borrowers.surname, ', ', borrowers.firstname, '') AS patron,
  suggestions.suggesteddate,
  suggestions.STATUS,
  suggestions.title,
  suggestions.author,
  suggestions.itemtype,
  suggestions.copyrightdate,
  suggestions.isbn,
  suggestions.note
FROM
  borrowers,
  suggestions
WHERE
  borrowers.borrowernumber = suggestions.suggestedby AND
  suggestions.branchcode LIKE &lt;&gt; AND
  suggestions.STATUS = 'ASKED'
ORDER BY
  suggestions.suggesteddate DESC


























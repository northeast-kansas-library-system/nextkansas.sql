/*
R.002801

----------

Name: GHW - Requests troubleshooting 005 - Patron requests history
Created by: George Williams

----------

Group: Holds-Reserves
     Holds troubleshooting

Created on: 2016-10-11 09:41:49
Modified on: 2024-01-21 10:39:28
Date last run: 2024-01-21 10:42:49

----------

Public: 0
Expiry: 0

----------

 
Identifies past requests made by a specific patron
Shows request history
on a patron you specify
sorted by the last activity on the request

Notes:

This report will not include data for titles that have been deleted from the catalog.

Report created to help troubleshoot problems with requested items (i.e. missing in transit, item on holds list not found, patron received e-mail but we can't find the request, etc.).


----------
*/



SELECT
  Concat_Ws('', 
    'View title' 
  ) AS VIEW_TITLE,
  old_reserves.timestamp,
  biblio.author,
  biblio.title,
  borrowers.cardnumber AS LIBRARY_CARD,
  old_reserves.branchcode,
  old_reserves.reservedate,
  old_reserves.waitingdate,
  old_reserves.cancellationdate,
  old_reserves.reservenotes,
  old_reserves.found
FROM
  old_reserves JOIN
  borrowers
    ON old_reserves.borrowernumber = borrowers.borrowernumber JOIN
  biblio
    ON old_reserves.biblionumber = biblio.biblionumber
WHERE
  borrowers.cardnumber LIKE Concat("%", &lt;&gt;)
ORDER BY
  old_reserves.timestamp
DESC


























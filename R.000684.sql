/*
R.000684

----------

Name: Current Items on Hold that aren't at your library
Created by:  Tongie Book Club

----------

Group: Acquisitions
     Collection Development

Created on: 2009-09-28 13:12:52
Modified on: 2018-07-02 09:44:38
Date last run: 2025-10-17 16:13:21

----------

Public: 0
Expiry: 0

----------

See holds by your patrons that are being filled OUTSIDE of your owned collection. A Collection Development Report tool. Enhanced.

virtually line by line identical to report 799 - merge two to make one report

----------
*/



SELECT
  biblio.title,
  items.itemcallnumber,
  items.ccode,
  items.holdingbranch,
  items.homebranch,
  items.barcode,
  issues.issuedate
FROM
  issues
  LEFT JOIN items ON issues.itemnumber = items.itemnumber
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
WHERE
  issues.branchcode = &lt;&gt; AND
  items.holdingbranch != items.homebranch
ORDER BY
  items.itemcallnumber,
  issues.issuedate,
  biblio.title


























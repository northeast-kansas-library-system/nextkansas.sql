/*
R.002799

----------

Name: GHW - Items paid for at a specified home branch
Created by: George H Williams

----------

Group: Fines/Fees
     -

Created on: 2016-10-10 09:36:41
Modified on: 2018-04-16 11:02:19
Date last run: 2019-06-24 18:24:27

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Lists items owned by a branch that have been marked as "Paid for" in Koha.</p>
<ul><li>Shows items currently in Koha</li>
<li>at the location (or locations) you specify</li>
<li>grouped and sorted by homebranch, shelving location, item type, collection code, call number, author, and title.</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Report created at the request of Eudora Public Library.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2799&phase=Run%20this%20report"  target="_blank">Click here to run in a new window.</a></p>
</div>

----------
*/

SELECT
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.timestamp
FROM
  items INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber
WHERE
  items.homebranch LIKE <<Enter item home branch|LBRANCH>> AND
  items.paidfor IS NOT NULL AND
  items.paidfor <> " "
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title




/*
R.003164

----------

Name: GHW - Hootsuite scheduled post generator - single title by barcode number
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2019-01-31 09:29:30
Modified on: 2019-01-31 09:32:23
Date last run: 2019-03-28 09:49:15

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates an easily scheduled media post for a new title</p>
<ul><li>Shows a title or titles based on the barcode number you specify</li>
<li>At all Next libraries</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3164&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat(
    "Recently added:<br /><br />",
    Upper(Replace(Replace(Replace(Replace(biblio.title, " /", ""),  " :", ""), " ;", ""), ".", "")),
    "<br /><br />https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=",
    biblio.biblionumber
  ) AS NEWSTUFF
FROM
  biblio
  JOIN items ON items.biblionumber = biblio.biblionumber
WHERE
  items.barcode LIKE Concat("%", <<Enter item barcode number or a % symbol>>, "%") AND
  (items.notforloan = 0 OR
    items.notforloan IS NULL) AND
  (items.damaged = 0 OR
    items.damaged IS NULL) AND
  (items.itemlost = 0 OR
    items.itemlost IS NULL) AND
  (items.withdrawn = 0 OR
    items.withdrawn IS NULL)


























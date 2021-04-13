/*
R.002891

----------

Name: GHW - Titles with more than 3 holds for pickup at your library - sorted by title
Created by: George H Williams

----------

Group: Holds-Reserves
     -

Created on: 2017-02-01 09:16:37
Modified on: 2018-04-16 11:06:24
Date last run: 2021-03-15 16:41:33

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows titles with requests for pickup at your library with 3 or more requests</p>
<ul><li>shows current requests assigned to be picked up at the library you specify</li>
<li>on all items in NExpress</li>
<li>sorted by title, local copy count, and local request count</li>
<li>includes links to bibliographic records</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report has two corresponding reports - Report 2890 which gathers the same data sorted by local copy count and Report 2891 wich gathers the same data sorted by local request count.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2890&phase=Run%20this%20report"  target="_blank">Click here to run 2890 in a new window</a></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2892&phase=Run%20this%20report"  target="_blank">Click here to run 2892 in a new window</a></p>
<p> </p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2891&phase=Run%20this%20report"  target="_blank">Click here to run this report in a new window</a></p>
</div>

----------
*/

SELECT
  reserves.branchcode,
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', reserves.biblionumber, '\" target="_blank">', "LINK", '</a>') AS LINK,
  biblio.title AS TITLE,
  Count(borrowers.borrowernumber) AS LOCAL_REQUESTS,
  Coalesce(localcopies.Count_itemnumber, 0) AS LOCAL_COPIES
FROM
  reserves JOIN
  borrowers
    ON reserves.borrowernumber = borrowers.borrowernumber JOIN
  biblio
    ON reserves.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
    items.biblionumber,
    Count(items.itemnumber) AS Count_itemnumber
  FROM
    items
  WHERE
    (items.damaged < 1 OR
      items.damaged IS NULL) AND
    (items.itemlost < 1 OR
      items.itemlost IS NULL) AND
    (items.withdrawn < 1 OR
      items.withdrawn IS NULL) AND
    (items.notforloan < 1 OR
      items.notforloan IS NULL) AND
    items.homebranch = <<Choose your library|branches>>
  GROUP BY
    items.biblionumber) localcopies
    ON biblio.biblionumber = localcopies.biblionumber
WHERE
  reserves.branchcode = <<Choose your library again|branches>>
GROUP BY
  reserves.branchcode, biblio.title, Coalesce(localcopies.Count_itemnumber, 0)
HAVING
  Count(*) > <<More than X local requests|YNUMBER>>
ORDER BY
  TITLE,
  LOCAL_COPIES,
  LOCAL_REQUESTS





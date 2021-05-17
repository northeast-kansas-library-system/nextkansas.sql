/*
R.002883

----------

Name: GHW - Deleted item information
Created by: George H Williams

----------

Group: Catalog Records and Items
     -

Created on: 2017-01-10 16:12:46
Modified on: 2018-04-16 11:04:50
Date last run: 2021-05-13 14:18:42

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Lists information about deleted items</p>
<ul><li>Shows information on items that have data in the deleteditems table</li>
<li>Shows information for the single barcode number you specify</li>
<li>grouped by item barcode</li>
<li>If there is still an active bibliographic record for the title, a link will appear to that record</li>
</ul><br />
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2883&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  If(Coalesce(biblio.biblionumber, 0) = deleteditems.biblionumber, Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank"><ins>Click for bibliographic record</ins></a>'), If(Coalesce(deletedbiblio.biblionumber, 0) > 0, '<span style="background-color: yellow; color: red;">Biblio has been deleted</span>', '--') ) AS BIBLIO_RECORD_STATUS,
  deleteditems.barcode,
  deleteditems.homebranch,
  deleteditems.location,
  deleteditems.itype,
  deleteditems.ccode,
  deleteditems.itemcallnumber,
  If(Coalesce(deletedbiblio.author, '--') = '--', Coalesce(biblio.author, '--'), Coalesce(deletedbiblio.author, '--')) AS AUTHOR,
  If(Coalesce(deletedbiblio.title, '--') = '--', Coalesce(biblio.title, '--'), Coalesce(deletedbiblio.title, '--')) AS TITLE,
  deleteditems.replacementprice,
  deleteditems.timestamp AS DELETED_ON
FROM
  deleteditems LEFT JOIN
  biblio
    ON deleteditems.biblionumber = biblio.biblionumber LEFT JOIN
  deletedbiblio
    ON deleteditems.biblionumber = deletedbiblio.biblionumber
WHERE
  deleteditems.barcode LIKE Concat("%", <<Enter single barcode number>>, "%")
GROUP BY
  deleteditems.biblionumber
ORDER BY
  deleteditems.homebranch,
  deleteditems.location,
  deleteditems.itype,
  deleteditems.ccode,
  deleteditems.itemcallnumber,
  AUTHOR,
  TITLE




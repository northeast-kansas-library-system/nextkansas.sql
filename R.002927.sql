/*
R.002927

----------

Name: GHW - Deleted item information
Created by: George H Williams

----------

Group: Catalog Records and Items
     -

Created on: 2017-03-29 09:38:37
Modified on: 2018-04-16 11:08:43
Date last run: 2019-06-25 11:34:09

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows information on items that have been deleted and are still in the deleteditems table</p>
<ul><li>Shows information on items that are in the deleteditems table</li>
<li>Shows information for the barcode number you specify (wildcards are OK)</li>
<li>grouped by itemnumber</li>
<li>sorted by item information</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2927&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  deleteditems.itemnumber,
  If(biblio.biblionumber IS NULL, deletedbiblio.biblionumber, biblio.biblionumber) AS BIBLIONUMBER,
  deleteditems.barcode,
  Concat_Ws("<br />",
    Concat("Home library: ", deleteditems.homebranch),
    Concat("Location: ", deleteditems.location), Concat("Item type: ", deleteditems.itype),
    Concat("Collection Code: ", Coalesce(ccode.lib, "-")),
    Concat("Call number: ", deleteditems.itemcallnumber),
    Concat("Author: ", If(Coalesce(biblio.author, "-") = "-", Coalesce(deletedbiblio.author, "-"), Coalesce(biblio.author, "-"))),
    Concat("Title: ", If(Coalesce(biblio.title, "-") = "-", Coalesce(deletedbiblio.title, "-"), Coalesce(biblio.title, "-"))),
    Concat("Replacement Price: $", Format(deleteditems.replacementprice, 2)),
    Concat("Withdrawn status: ", Coalesce(withdrawnitems.lib, "-")),
    Concat("Lost status: ", Coalesce(lostitems.lib, "-")),
    Concat("Damaged status: ", Coalesce(damageditems.lib, "-")),
    Concat("Deleted on: ", deleteditems.timestamp)) AS ITEM_INFORMATION,
  If(biblio.title IS NULL, "<span style='background-color: yellow'>Biblio has also been deleted<span>", (Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Go to bibliographic record</a>'))) AS DELETED_OR_LINK
FROM
  deleteditems LEFT JOIN
  biblio
    ON deleteditems.biblionumber = biblio.biblionumber LEFT JOIN
  authorised_values ccode
    ON deleteditems.ccode = ccode.authorised_value LEFT JOIN
  deletedbiblio
    ON deleteditems.biblionumber = deletedbiblio.biblionumber LEFT JOIN
  (SELECT
    authorised_values.category,
    authorised_values.authorised_value,
    authorised_values.lib
  FROM
    authorised_values
  WHERE
    authorised_values.category = 'LOST') lostitems
    ON deleteditems.itemlost = lostitems.authorised_value LEFT JOIN
  (SELECT
    authorised_values.category,
    authorised_values.authorised_value,
    authorised_values.lib
  FROM
    authorised_values
  WHERE
    authorised_values.category = 'WITHDRAWN') withdrawnitems
    ON deleteditems.withdrawn = withdrawnitems.authorised_value LEFT JOIN
  (SELECT
    authorised_values.category,
    authorised_values.authorised_value,
    authorised_values.lib
  FROM
    authorised_values
  WHERE
    authorised_values.category = 'DAMAGED') damageditems
    ON deleteditems.damaged = damageditems.authorised_value
WHERE
  deleteditems.barcode LIKE <<Enter item barcode number>>
GROUP BY
  deleteditems.itemnumber
ORDER BY
  ITEM_INFORMATION


























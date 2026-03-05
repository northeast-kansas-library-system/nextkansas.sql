/*
R.002927

----------

Name: GHW - Deleted item information
Created by: George Williams

----------

Group: Catalog Records and Items
     -

Created on: 2017-03-29 09:38:37
Modified on: 2024-01-17 11:49:29
Date last run: 2025-09-14 12:55:39

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows information on items that have been deleted and are still in the deleteditems table&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows information on items that are in the deleteditems table&lt;/li&gt;
&lt;li&gt;Shows information for the barcode number you specify (wildcards are OK)&lt;/li&gt;
&lt;li&gt;grouped by itemnumber&lt;/li&gt;
&lt;li&gt;sorted by item information&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2927&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  deleteditems.itemnumber,
  If(biblio.biblionumber IS NULL, deletedbiblio.biblionumber, biblio.biblionumber) AS BIBLIONUMBER,
  deleteditems.barcode,
  Concat_Ws("",
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
  If(biblio.title IS NULL, "Biblio has also been deleted", (Concat('Go to bibliographic record'))) AS DELETED_OR_LINK
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
  deleteditems.barcode LIKE &lt;&gt;
GROUP BY
  deleteditems.itemnumber
ORDER BY
  ITEM_INFORMATION


























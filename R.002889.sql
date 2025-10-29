/*
R.002889

----------

Name: GHW - Holds queue by Accelerated Reader
Created by: George Williams

----------

Group: Holds-Reserves
     -

Created on: 2017-01-31 09:54:21
Modified on: 2024-01-17 11:48:51
Date last run: 2024-09-25 10:44:16

----------

Public: 0
Expiry: 0

----------

<div class="reportinfo noprint"> 
<p>Shows items with requests in the holds queue at the specified branch</p>
<ul><li>shows items currently in the holds queue</li>
<li>shows items at the library you specify</li>
<li>grouped by item barcode number</li>
<li>sorted by Accelerated Reader information from the 526 a,b,c, and d subfields (if there is any data in those fields)</li>
<li>contains links to the bibliographic records</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report was created to help out the Axtell School where they have the library arranged by Accelerated Reader Level.  This report won't be perfect because not all items have AR data in the 526 fields, but it might help speed a few things up for them.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2889&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat_Ws(", ", ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]/subfield[@code="a"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata,'//datafield[@tag="526"]/subfield[@code="c"]')) AS AR,
  Concat_Ws('', hold_fill_targets.source_branchcode, items.homebranch,(Concat('Go to biblio'))) AS CURRENT_OWNING,
  Concat_Ws('', items.location, authorised_values.lib, items.itemcallnumber) AS CALL_NUMBER,
  Concat_Ws('', biblio.author, (Concat_Ws('', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')))) AS AUTHOR_TITLE,
  Concat_Ws('', (Concat('')), items.barcode) AS BARCODE,
  items.itemnotes
FROM
  biblio LEFT JOIN
  ((hold_fill_targets LEFT JOIN
  items
    ON hold_fill_targets.itemnumber = items.itemnumber) LEFT JOIN
  biblio_metadata
    ON items.biblionumber = biblio_metadata.biblionumber)
    ON biblio.biblionumber = biblio_metadata.biblionumber LEFT JOIN
  authorised_values
    ON items.ccode = authorised_values.authorised_value
WHERE
  hold_fill_targets.source_branchcode LIKE <> AND
  authorised_values.category = "ccode"
GROUP BY
  items.barcode
ORDER BY
  AR,
  items.homebranch,
  items.location,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title



























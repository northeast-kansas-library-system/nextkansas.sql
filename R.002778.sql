/*
R.002778

----------

Name: GHW - Holds Queue with scannable barcodes
Created by: George H Williams

----------

Group: Holds-Reserves
     -

Created on: 2016-09-25 22:37:09
Modified on: 2019-08-16 15:53:35
Date last run: 2019-09-20 14:59:38

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo class="noPrint">
<p>Print holds queue report with scannable barcodes</p>
<ul><li>Shows items in the current holds queue</li>
<li>at the location you specify</li>
<li>grouped by specified location, items home branch, call number, author, and title</li>
<li>contains links to the bibliographic records</li>
</ul><br />
</div>



----------
*/

SELECT
  Concat_Ws('<br />', hold_fill_targets.source_branchcode, items.homebranch,(Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber,'\" target="_blank">Go to biblio</a>'))) AS CURRENT_OWNING,
  Concat_Ws('<br />', items.location, authorised_values.lib, items.itemcallnumber, items.copynumber) AS CALL_NUMBER,
  Concat_Ws('<br />', biblio.author, (Concat_Ws('<br />', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')))) AS AUTHOR_TITLE,
  Concat_Ws('<br />', (Concat('<img src="/cgi-bin/koha/svc/barcode?barcode=', '*', Upper(items.barcode), '*', '&type=Code39"></img>')), items.barcode) AS BARCODE
FROM
  biblio
  LEFT JOIN ((hold_fill_targets
  LEFT JOIN items ON hold_fill_targets.itemnumber = items.itemnumber)
  LEFT JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber) ON
    biblio.biblionumber = biblio_metadata.biblionumber
  LEFT JOIN authorised_values ON items.ccode = authorised_values.authorised_value
WHERE
  hold_fill_targets.source_branchcode LIKE <<Select your branch|LBRANCH>> AND
  authorised_values.category = "ccode"
GROUP BY
  hold_fill_targets.source_branchcode,  
  Concat_Ws('<br />', items.location, authorised_values.lib, items.itemcallnumber),
  items.holdingbranch,
  biblio.author,
  biblio.title




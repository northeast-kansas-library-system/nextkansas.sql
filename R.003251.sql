/*
R.003251

----------

Name: GHW - Holds Queue
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-16 14:59:53
Modified on: 2020-07-24 14:41:10
Date last run: 2020-08-19 10:09:47

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class="noPrint">
<p>Print holds queue report</p>
<ul><li>Shows items in the current holds queue</li>
<li>at the location you specify</li>
<li>grouped by specified location, items home branch, call number, author, and title</li>
<li>contains links to the bibliographic records</li>
</ul><br />
</div>

----------
*/

SELECT
  Concat_Ws('<br />', 
    Concat('Current: ', hold_fill_targets.source_branchcode), 
    Concat('Owned by: ', items.homebranch), 
    Concat('Last seen: ', items.datelastseen),
    (Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Go to biblio</a>'))
  ) AS INFO,
  Concat_Ws('<br />', 
    If(items.location = 'CART', 'Recently returned', items.location), 
    collectioncode.lib, 
    items.itemcallnumber, 
    items.copynumber
  ) AS CALL_NUMBER,
  Concat_Ws('<br />', 
    biblio.author, 
    (Concat_Ws('<br />', 
      biblio.title, 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'))
    )
  ) AS AUTHOR_TITLE,
  Upper(items.barcode) AS BARCODE
FROM
  biblio LEFT JOIN
  ((hold_fill_targets LEFT JOIN
  items ON hold_fill_targets.itemnumber = items.itemnumber) LEFT JOIN
  biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber) ON
      biblio.biblionumber = biblio_metadata.biblionumber LEFT JOIN
  authorised_values collectioncode ON
      items.ccode = collectioncode.authorised_value
WHERE
  hold_fill_targets.source_branchcode LIKE <<Select your branch|LBRANCH>> AND
  collectioncode.category = "ccode"
GROUP BY
  hold_fill_targets.itemnumber
ORDER BY
  items.homebranch,
  If(items.location = 'CART', 'Z', items.location),
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.barcode




/*
R.003908

----------

Name: GHW - Bibliographic records with item count in descending order
Created by: George Williams

----------

Group: -
     -

Created on: 2025-08-22 14:29:00
Modified on: 2025-08-28 10:54:55
Date last run: 2025-08-28 10:52:31

----------

Public: 0
Expiry: 300

----------

  biblioitems.agerestriction IN <<Choose a bib-level shelving location|bibloc:in>> AND 
  biblioitems.itemtype IN <<Choose a bib-level item type|bibitype:in>> AND 
  biblioitems.cn_class IN <<Choose a bib-level collection code|CCODE:in>>

----------
*/



SELECT 
  Concat(
    '<a class="btn btn-default noprint" ',
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',
    biblio.biblionumber,
    '\" target="_blank">Koha link</a>',
    '<br>&nbsp;<br>',
    '<a class="btn btn-default noprint" ',
    'href=\"https://nextkansas.org/Record/',
    biblio.biblionumber,
    '\" target="_blank">Aspen Link</a>'
  ) As LINK_ONE,
  biblio.author,
  Concat_Ws(' ',
    biblio.title,
    biblio.medium,
    biblio.subtitle,
    biblioitems.number,
    biblio.part_name
  ) AS TITLE,
  locs.lib AS BIB_LOCATION,
  itypes.description AS BIB_ITEMTYPE,
  ccodes.lib AS BIB_COLLECTION_CODE,
  Count(items.itemnumber) AS ITEM_COUNT
FROM biblio
  JOIN biblioitems 
    ON biblioitems.biblionumber = biblio.biblionumber
  JOIN items 
    ON items.biblionumber = biblio.biblionumber
  LEFT JOIN 
    (
      SELECT authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      FROM authorised_values
      WHERE authorised_values.category = 'LOC'
    ) locs 
      ON locs.authorised_value = biblioitems.agerestriction
  LEFT JOIN 
    (
      SELECT itemtypes.itemtype,
        itemtypes.description
      FROM itemtypes
    ) itypes 
      ON itypes.itemtype = biblioitems.itemtype
  LEFT JOIN 
    (
      SELECT authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      FROM authorised_values
      WHERE authorised_values.category = 'CCODE'
    ) ccodes 
      ON ccodes.authorised_value = biblioitems.cn_class
WHERE 
  biblioitems.agerestriction IN <<Choose a bib-level shelving location|bibloc:in>> AND 
  biblioitems.itemtype IN <<Choose a bib-level item type|bibitype:in>> AND 
  biblioitems.cn_class IN <<Choose a bib-level collection code|CCODE:in>>
GROUP BY 
  biblio.biblionumber
HAVING 
  ITEM_COUNT >= <<Bibliographic records with at least XX items|YNUMBER>>
ORDER BY 
  ITEM_COUNT DESC


























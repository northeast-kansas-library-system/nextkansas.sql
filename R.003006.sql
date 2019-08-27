/*
R.003006

----------

Name: GHW - Prioritized Holds Queue
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-10-12 12:11:36
Modified on: 2017-12-19 09:38:38
Date last run: 2018-03-07 17:02:09

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat_Ws('<br />',
    hold_fill_targets.source_branchcode,
    items.homebranch,
    (Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Go to biblio</a>')),
    If(localonly.Count_itemnumber > 0, "<span style='background-color: yellow;'>TOP PRIORITY<br />ONLY COPY AVAILABLE</span>",
    If(availablecount.Count_itemnumber < 3, "<span style='background-color: orange;'>Priority<br />All other copies checked out</span>", "-"))) AS CURRENT_OWNING,
  Concat_Ws('<br />', items.location, authorised_values.lib, items.itemcallnumber) AS CALL_NUMBER,
  Concat_Ws('<br />',
    biblio.author,
    (Concat_Ws('<br />',
      biblio.title,
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')))) AS AUTHOR_TITLE,
  Concat_Ws('<br />', (Concat('<img src="/cgi-bin/koha/svc/barcode?barcode=', '*', Upper(items.barcode), '*', '&type=Code39"></img>')),
    items.barcode) AS BARCODE
FROM
  biblio
  LEFT JOIN ((hold_fill_targets
  LEFT JOIN items ON hold_fill_targets.itemnumber = items.itemnumber)
  LEFT JOIN biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber) ON biblio.biblionumber =
    biblioitems.biblionumber
  LEFT JOIN authorised_values ON items.ccode = authorised_values.authorised_value
  INNER JOIN (SELECT
        hold_fill_targets.biblionumber,
        Count(DISTINCT items.itemnumber) AS Count_itemnumber
      FROM
        hold_fill_targets
        JOIN items ON hold_fill_targets.biblionumber = items.biblionumber
      WHERE
        items.onloan IS NULL AND
        (items.notforloan = 0 OR
          items.notforloan IS NULL) AND
        (items.damaged = 0 OR
          items.damaged IS NULL) AND
        (items.itemlost = 0 OR
          items.itemlost IS NULL) AND
        (items.withdrawn = 0 OR
          items.withdrawn IS NULL)
      GROUP BY
        hold_fill_targets.biblionumber) availablecount ON hold_fill_targets.biblionumber = availablecount.biblionumber
  LEFT JOIN (SELECT
        hold_fill_targets.biblionumber,
        Count(DISTINCT items.itemnumber) AS Count_itemnumber,
        Group_Concat(DISTINCT items.holdingbranch) AS Group_Concat_holdingbranch
      FROM
        hold_fill_targets
        JOIN items ON hold_fill_targets.biblionumber = items.biblionumber
      WHERE
        ((items.notforloan = 0 OR
          items.notforloan IS NULL) AND
        (items.damaged = 0 OR
          items.damaged IS NULL) AND
        (items.itemlost = 0 OR
          items.itemlost IS NULL) AND
        (items.withdrawn = 0 OR
          items.withdrawn IS NULL)) OR
        ((items.notforloan = 0 OR
          items.notforloan IS NULL) AND
        (items.damaged = 0 OR
          items.damaged IS NULL) AND
        (items.itemlost = 0 OR
          items.itemlost IS NULL) AND
        (items.withdrawn = 0 OR
          items.withdrawn IS NULL))
      GROUP BY
        hold_fill_targets.biblionumber
      HAVING
        Count(DISTINCT items.itemnumber) = 1 AND
        Group_Concat(DISTINCT items.holdingbranch) LIKE <<Choose your branch|branches>>) localonly ON
    hold_fill_targets.biblionumber = localonly.biblionumber
  LEFT JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber AND items.biblioitemnumber =
    biblio_metadata.biblionumber
WHERE
  authorised_values.category = "ccode" AND
  hold_fill_targets.source_branchcode LIKE <<Choose your branch again|branches>>
GROUP BY
  Concat_Ws('<br />', items.location, authorised_values.lib, items.itemcallnumber), Concat_Ws('<br />', biblio.author, (Concat_Ws('<br />', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')))), If(localonly.Count_itemnumber > 0, "TOP PRIORITY", If(availablecount.Count_itemnumber < 3, "Priority", "-")),
  items.holdingbranch,
  biblio.author,
  biblio.title
ORDER BY
  If(localonly.Count_itemnumber > 0, "TOP PRIORITY", If(availablecount.Count_itemnumber < 3, "Priority", "-")) DESC,
  CALL_NUMBER,
  AUTHOR_TITLE




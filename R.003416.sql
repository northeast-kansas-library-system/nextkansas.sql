/*
R.003416

----------

Name: GHW - Multiple items on a bibliographic record
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-02-01 11:35:59
Modified on: 2021-02-01 12:11:44
Date last run: 2021-02-24 16:00:28

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    items.biblionumber, 
    '\" target="_blank">', 
    items.biblionumber, 
    '</a>'
  ) AS LINK_TO_TITLE,
  biblio.biblionumber,
  items.itemnumber,
  items.homebranch AS HOME,
  items.holdingbranch,
  If(
    items.permanent_location = items.location, 
    permlocationss.lib,
    Concat(permlocationss.lib, ' (', locationss.lib, ')')
  ) AS LOCATION,
  itypess.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),  
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),  
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),  
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE
FROM
  biblio JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber JOIN
  items ON items.biblionumber = biblio.biblionumber JOIN
  (SELECT
      items.biblionumber,
      items.homebranch,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.biblionumber,
      items.homebranch
    HAVING
      Count(items.itemnumber) > 1) itemcountss ON itemcountss.biblionumber =
      items.biblionumber AND
      itemcountss.homebranch = items.homebranch LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') permlocationss ON
      permlocationss.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locationss ON
      locationss.authorised_value = items.location LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypess ON itypess.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value =
      items.ccode
WHERE
  items.homebranch LIKE <<Item home library|ZBRAN>> AND
  items.permanent_location LIKE <<Item permanent location|LLOC>> AND
  items.itype LIKE <<Item type|LITYPES>> AND
  items.ccode LIKE <<Item collection code|LCCODE>>
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  HOME,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE




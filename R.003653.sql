/*
R.003653

----------

Name: GHW - Single page
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-02-28 17:51:25
Modified on: 2022-02-28 18:19:33
Date last run: 2022-02-28 18:17:27

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_WS('<br />',
    Concat('Home library: ', homebranch.branchname, IF(holdingbranch.branchname = homebranch.branchname, '',  Concat('<br /><span style="background-color: #FFFF00">Current library: ', holdingbranch.branchname, '</span>'))),
    Concat('Permanent location: ', IF(perm_locs.lib = locs.lib, perm_locs.lib, CONCAT(perm_locs.lib, '<br /><span style="background-color: #FFFF00">Current location: ', locs.lib, '</span>'))),
    Concat('Item type: ', itemtypes.description),
    Concat('Collection code: ', ccodes.lib),
    Concat('Call number: ', Concat_Ws('', items.itemcallnumber, Concat(' / Copy #: ', items.copynumber)))
    ) AS INFO,
    Concat_WS('<br />',
      biblio.author,
    Concat_Ws('<br />', 
      biblio.title, 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]')
    ),
    Concat(
      '<a class="btn btn-default noprint" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
      items.biblionumber, 
      '\" target="_blank">Go to title</a><br />'
    )
  ) AS AUTHOR_TITLE
FROM
  biblio JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN
  items ON items.biblionumber = biblio.biblionumber INNER JOIN
  branches homebranch ON homebranch.branchcode = items.homebranch INNER JOIN
  branches holdingbranch ON holdingbranch.branchcode = items.holdingbranch
  LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc') perm_locs ON
      perm_locs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc') locs ON locs.authorised_value =
      items.location LEFT JOIN
  itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="n"]') = 1 AND
  items.homebranch LIKE <<Choose your library|ZBRAN>>
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  homebranch.branchname,
  perm_locs.lib,
  itemtypes.description,
  ccodes.lib,
  Concat_Ws('', items.itemcallnumber, Concat(' / Copy #: ', items.copynumber)),
  biblio.author,
  TITLE


























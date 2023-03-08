/*
R.002808

----------

Name: GHW - Flexible shelflist sorted by branch, location, itype, ccode
Created by: George H Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2016-10-14 10:30:29
Modified on: 2023-03-07 13:32:33
Date last run: 2023-03-07 14:02:20

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows all items at a specified branch with a specified shelving location, a specified item type, and a specified collection code</p>
<ul><li>Shows current items</li>
<li>at a location you specify</li>
<li>grouped and sorted by item home branch, shelving location, item type, collection code, call number, author, and title</li>
</ul><br />
<p></p>
<p>Notes:</p>
<p></p>
<p>Update for new links on 2023.03.07</p>
</div>

----------
*/



SELECT 
  biblio.biblionumber,
  items.itemnumber,
  Concat('- ', items.barcode, ' -') AS 'Item barcode',
  If(
    items.homebranch <> items.holdingbranch,
    Concat(
      home_library.branchname,
      ' (',
      holding_library.branchname,
      ')'
    ),
    home_library.branchname
  ) AS 'Home library',
  If(
    items.permanent_location <> items.location,
    Concat(perm_locs.lib, ' (', locs.lib, ')'),
    perm_locs.lib
  ) AS 'Shelving location',
  itemtypes.description AS 'Item type',
  ccodes.lib AS 'Collection code',
  If(
    (
      items.copynumber != ''
      AND items.enumchron != ''
    ),
    Concat(
      items.itemcallnumber,
      ' / CHRON: ',
      items.enumchron,
      ' / COPY: ',
      items.copynumber
    ),
    If(
      (
        items.copynumber IS NOT NULL
        AND items.enumchron IS NULL
      ),
      Concat(
        items.itemcallnumber,
        ' / COPY: ',
        items.copynumber
      ),
      If(
        (
          items.copynumber IS NULL
          AND items.enumchron IS NOT NULL
        ),
        Concat(
          items.itemcallnumber,
          ' / CHRON: ',
          items.enumchron
        ),
        items.itemcallnumber
      )
    )
  ) AS 'Call number',
  biblio.author AS 'Author',
  Concat_Ws(
    ' ',
    biblio.title,
    ExtractValue(
      biblio_metadata.metadata,
      '//datafield[@tag="245"]/subfield[@code="b"]'
    ),
    ExtractValue(
      biblio_metadata.metadata,
      '//datafield[@tag="245"]/subfield[@code="p"]'
    ),
    ExtractValue(
      biblio_metadata.metadata,
      '//datafield[@tag="245"]/subfield[@code="n"]'
    )
  ) AS 'Title'
FROM items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  AND items.biblionumber = biblio_metadata.biblionumber
  LEFT JOIN authorised_values ON items.ccode = authorised_values.authorised_value
  LEFT JOIN 
    (
      SELECT authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      FROM authorised_values
      WHERE authorised_values.category = 'CCODE'
    ) ccodes ON ccodes.authorised_value = items.ccode
  LEFT JOIN 
    (
      SELECT authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      FROM authorised_values
      WHERE authorised_values.category = 'LOC'
    ) perm_locs ON perm_locs.authorised_value = items.permanent_location
  LEFT JOIN 
    (
      SELECT authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      FROM authorised_values
      WHERE authorised_values.category = 'LOC'
    ) locs ON locs.authorised_value = items.location
  JOIN 
    branches home_library ON home_library.branchcode = items.homebranch
  JOIN 
    branches holding_library ON items.holdingbranch = holding_library.branchcode
  LEFT JOIN 
    itemtypes ON itemtypes.itemtype = items.itype
WHERE 
  items.homebranch LIKE <<Choose your library|branches:all>>
  AND items.itype LIKE <<Choose an item type|itemtypes:all>>
  AND items.permanent_location LIKE <<Choose a shelving location|LOC:all>>
  AND items.ccode LIKE <<Choose a collection code|CCODE:all>>
GROUP BY 
  biblio.biblionumber,
  items.itemnumber
ORDER BY 
  home_library.branchname,
  perm_locs.lib,
  itemtypes.description,
  ccodes.lib,
  items.itemcallnumber,
  items.enumchron,
  items.copynumber,
  biblio.author,
  'Title'


























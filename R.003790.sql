/*
R.003790

----------

Name: GHW - Shelving location, Item type, or Collection code problems email helper
Created by: George Williams

----------

Group: -
     -

Created on: 2024-01-10 11:50:48
Modified on: 2024-01-10 12:08:00
Date last run: 2024-01-11 15:42:13

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT Concat_Ws(
    '',
    branches.branchemail,
    Concat('Problem with ', branches.branchname, ' item ', items.barcode, ''),
    Concat(
      'Hello at ',
      branches.branchname,
      ','
    ),
    'There appears to be a problem with the following item owned by your library.',
    '----------',
    Concat('Barcode: ', items.barcode),
    Concat(
      'Location: ',
      If(
        items.permanent_location = items.location,
        permanent_locs.lib,
        Concat(permanent_locs.lib, ' (', locs.lib, ')')
      )
    ),
    Concat('Item type: ', itypes.description),
    Concat('Collection code: ', ccodes.lib),
    Concat(
      'Call number: ',
      Concat_Ws(
        '',
        items.itemcallnumber,
        If(
          items.copynumber IS NULL,
          '',
          Concat(' / ', items.copynumber)
        ),
        If(
          items.enumchron IS NULL,
          '',
          Concat(' / ', items.enumchron)
        )
      )
    ),
    Concat('Author: ', biblio.author),
    Concat(
      'Title: ',
      UPPER(
        Concat_Ws(
          '',
          biblio.title,
          If(
            ExtractValue(
              biblio_metadata.metadata,
              '//datafield[@tag="245"]/subfield[@code="h"]'
            ) = '',
            '',
            Concat(
              ' ',
              ExtractValue(
                biblio_metadata.metadata,
                '//datafield[@tag="245"]/subfield[@code="h"]'
              )
            )
          ),
          If(
            ExtractValue(
              biblio_metadata.metadata,
              '//datafield[@tag="245"]/subfield[@code="b"]'
            ) = '',
            '',
            Concat(
              ' ',
              ExtractValue(
                biblio_metadata.metadata,
                '//datafield[@tag="245"]/subfield[@code="b"]'
              )
            )
          ),
          If(
            ExtractValue(
              biblio_metadata.metadata,
              '//datafield[@tag="245"]/subfield[@code="p"]'
            ) = '',
            '',
            Concat(
              ' ',
              ExtractValue(
                biblio_metadata.metadata,
                '//datafield[@tag="245"]/subfield[@code="p"]'
              )
            )
          ),
          If(
            ExtractValue(
              biblio_metadata.metadata,
              '//datafield[@tag="245"]/subfield[@code="n"]'
            ) = '',
            '',
            Concat(
              ' ',
              ExtractValue(
                biblio_metadata.metadata,
                '//datafield[@tag="245"]/subfield[@code="n"]'
              )
            )
          )
        )
      )
    ),
    '',
    If(
      items.onloan IS NULL,
      'Item is checked in',
      Concat('Item is due on: ', items.onloan)
    ),
    '',
    If(
      Coalesce(items.notforloan, '') = '',
      '',
      Concat('Not for loan: ', nfl.lib)
    ),
    If(
      Coalesce(items.damaged, '') = '',
      '',
      Concat(
        'Damaged status: ',
        damageds.lib,
        ' (',
        items.damaged_on,
        ')'
      )
    ),
    If(
      Coalesce(items.itemlost, '') = '',
      '',
      Concat(
        'Lost status: ',
        losts.lib,
        ' (',
        items.itemlost_on,
        ')'
      )
    ),
    If(
      Coalesce(items.withdrawn, '') = '',
      '',
      Concat(
        'Withdrawn status: ',
        withdrawns.lib,
        ' (',
        items.withdrawn_on,
        ')'
      )
    ),
    '----------',
    Concat(
      'The shelving location on this item appears to be incorrect.  Could you take a look to verify that "',
      permanent_locs.lib,
      '" is the correct shelving location for this item?'
    ),
    Concat(
      'The item type on this item appears to be incorrect.  Could you take a look to verify that "',
      itypes.description,
      '" is the correct item type for this item?'
    ),
    Concat(
      'The collection code on this item appears to be incorrect.  Could you take a look to verify that "',
      ccodes.lib,
      '" is the correct collection code for this item?'
    ),
    'Thanks,'
  ) AS INFO
FROM biblio
  JOIN items ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'LOC'
  ) permanent_locs ON permanent_locs.authorised_value = items.permanent_location
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'LOC'
  ) locs ON locs.authorised_value = items.location
  LEFT JOIN (
    SELECT itemtypes.itemtype,
      itemtypes.description
    FROM itemtypes
  ) itypes ON itypes.itemtype = items.itype
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'CCODE'
  ) ccodes ON ccodes.authorised_value = items.ccode
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'not_loan'
  ) nfl ON nfl.authorised_value = items.notforloan
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'damaged'
  ) damageds ON damageds.authorised_value = items.damaged
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'lost'
  ) losts ON losts.authorised_value = items.itemlost
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'withdrawn'
  ) withdrawns ON withdrawns.authorised_value = items.withdrawn
  LEFT JOIN branches ON items.homebranch = branches.branchcode
WHERE items.barcode LIKE Concat('%', <>, '%')


























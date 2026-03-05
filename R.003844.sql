/*
R.003844

----------

Name: Item type - collection code missmatch - ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2024-06-07 10:32:45
Modified on: 2025-02-18 14:53:19
Date last run: 2025-11-23 21:25:26

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  Concat_WS('', 
    '<a class="btn btn-default btn-xs noprint" ', 
    'href="mailto:', 
    home_branches.branchemail, 
    '?subject=Item&nbsp;that&nbsp;will&nbsp;not&nbsp;display&nbsp;correctly&nbsp;in&nbsp;Aspen&nbsp;Discovery', 
    '&nbsp;&lpar;',
    items.itemnumber, 
    '&rpar;', 
    '&body=An%20item%20owned%20by&nbsp;', 
    home_branches.branchname, 
    '%20has%20been%20identified%20as%20having%20a%20collection%20code%20that%20does%20not%20really%20match%20the%20item%20type%20for%20the%20item.',
    '%0D%0A%0D%0A',
    'This%20item%20doesn%27t%20really%20display%20correctly%20in%20Aspen%20Discovery.',
    '%0D%0A%0D%0A',
    'Go%20to%20',
    '%0D%0A%0D%0A',
    'http://nekls.aspendiscovery.org/Record/',
    items.biblionumber,
    '%0D%0A%0D%0A',
    '%20to%20 see%20how%20this%20item%20will%20display%20in%20Aspen.',
    '%0D%0A%0D%0A', 
    'The%20details%20of%20this%20item%20are%20as%20follow%3A', 
    '%0D%0A', 
    '%0D%0ALibrary&colon;&nbsp;&nbsp;', 
    If( 
      items.homebranch = items.holdingbranch, 
      home_branches.branchname, 
      Concat( 
        home_branches.branchname, 
        '<br />Currently at: ', 
        current_branches.branchname 
      ) 
    ), 
    '%0D%0AShelving%20location&colon;&nbsp;&nbsp;', 
    If( 
      items.permanent_location = items.location, 
      perm_locs.lib, 
      Concat(perm_locs.lib, ' (', locs.lib, ')') 
    ), 
    '%0D%0AItem%20type&colon;&nbsp;&nbsp;', 
    itemtypes.description, 
    '%0D%0ACollection%20code&colon;&nbsp;&nbsp;', 
    ccodes.lib, 
    '%0D%0ACall%20number&colon;&nbsp;&nbsp;', 
    items.itemcallnumber, 
    '%0D%0AAuthor&colon;&nbsp;&nbsp;', 
    biblio.author, 
    '%0D%0ATitle&colon;&nbsp;&nbsp;', 
    UPPER( 
      Concat_Ws( 
        " ", 
        biblio.title, 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]') 
      ) 
    ), 
    '%0D%0ABarcode&colon;&nbsp;&nbsp;', 
    items.barcode, 
    '%0D%0A%0D%0A', 
    'Could%20you%20please%20take%20a%20look%20at%20this%20item%20and%20', 
    'modify%20the%20item%20type%20or%20collection%20code%20as%20needed&quest;' 
    '%0D%0A%0D%0A', 
    'Thanks&comma;', 
    '%0D%0A%0D%0A', 
    'George' 
    '">Send e-mail</a>' 
  ) AS MAILTO_LINK, 
  If( 
    items.homebranch = items.holdingbranch, 
    home_branches.branchname, 
    Concat( 
      home_branches.branchname, 
      '<br />Currently at: ', 
      current_branches.branchname 
    ) 
  ) AS LIBRARY, 
  If( 
    items.permanent_location = items.location, 
    perm_locs.lib, 
    Concat(perm_locs.lib, ' (', locs.lib, ')') 
  ) AS LOCATION, 
  itemtypes.description AS ITEM_TYPE, 
  ccodes.lib AS COLLECTION_CODE, 
  items.itemcallnumber AS CALL_NUMBER, 
  biblio.author AS AUTHOR, 
  Concat_Ws( 
    " ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]') 
  ) AS TITLE, 
  Concat_WS('', '-', items.barcode, '-') AS ITEM_BARCODE, 
  items.datelastseen, 
  Coalesce(items.notforloan, '') AS NFL, 
  Coalesce(items.damaged, '') AS DAMAGED, 
  Coalesce(items.itemlost, '') AS LOST, 
  Coalesce(items.withdrawn, '') AS WITHDRAWN, 
  Coalesce(items.onloan, '') AS ONLOAN 
FROM biblio 
  JOIN biblio_metadata 
    ON biblio_metadata.biblionumber = biblio.biblionumber 
  JOIN items 
    ON items.biblionumber = biblio.biblionumber 
  JOIN branches home_branches 
    ON items.homebranch = home_branches.branchcode 
  JOIN branches current_branches 
    ON items.holdingbranch = current_branches.branchcode 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.imageurl, 
      authorised_values.lib_opac 
    FROM authorised_values 
    WHERE authorised_values.category = 'LOC' 
  ) perm_locs 
    ON perm_locs.authorised_value = items.permanent_location 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.imageurl, 
      authorised_values.lib_opac 
    FROM authorised_values 
    WHERE authorised_values.category = 'LOC' 
  ) locs 
    ON locs.authorised_value = items.location 
  LEFT JOIN itemtypes 
    ON itemtypes.itemtype = items.itype 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.imageurl, 
      authorised_values.lib_opac 
    FROM authorised_values 
    WHERE authorised_values.category = 'CCODE' 
  ) ccodes 
    ON ccodes.authorised_value = items.ccode 
WHERE 
  items.barcode LIKE Concat(<<Enter item barcode number>>) AND 
  items.homebranch LIKE '%' AND 
  items.permanent_location LIKE '%' AND 
  items.itype LIKE '%' AND 
  items.ccode LIKE '%' AND 
  Coalesce(items.notforloan, '0') LIKE '%' AND 
  Coalesce(items.damaged, '0') LIKE '%' AND 
  Coalesce(items.itemlost, '0') LIKE '%' AND 
  Coalesce(items.withdrawn, '0') LIKE '%'AND 
  Coalesce(items.onloan, '0') LIKE '%' 
GROUP BY 
  items.itemnumber, 
  biblio.biblionumber 
ORDER BY 
  home_branches.branchcode, 
  perm_locs.lib, 
  ITEM_TYPE, 
  COLLECTION_CODE, 
  CALL_NUMBER, 
  AUTHOR, 
  TITLE, 
  items.barcode 


























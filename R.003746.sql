/*
R.003746

----------

Name: GHW - Checkouts and renewals from other libraries - date range
Created by: George Williams

----------

Group: -
     -

Created on: 2023-08-02 14:59:27
Modified on: 2024-01-17 11:13:59
Date last run: 2025-01-30 03:27:33

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
 
  <div class="reportInfoContent"> 
 
    <p>Lists all titles checked out at the library you specify that are not owned by the library you specify</p> 
 
    <ul> 
      <li>during the date range you specify</li> 
      <li>checked out at the library you specify</lia
      <li>sorted by the normal Next Search Catalog classification order</li> 
    </ul> 
 
  </div>

  <div class="reportInfoNotes">
 
    <p> 
    </p> 

    <p> 
      Data from circulation more than 25 months old is not available.
    </p> 

    <p> 
      Data for items that have been deleted since they circulated is not present in this report.
    </p> 

    <p> 
      Owning library, permanent shelving location, call number, author, title, enumeration and chronology, and copy number are based on data generated at the time the report was run.  In other words, if any of these fields changed between the time the item circulated and the time the report was run, those changes are reflected in this report. 
    </p> 
 
    <p> 
      Item type and collection code are based on the data for the item that was circulated at the time the item was checked out or renewed.  In other words, if these fields have changed since the item circulated, those changes are not reflected in these results.
    </p> 
   
  </div> 

</div>

----------
*/



SELECT 
  branches.branchname AS CKO_LIBRARY, 
  Concat_Ws('', 
    'View title' 
  ) AS VIEW_TITLE, 
  item_home.branchname AS OWNING_LIBRARY, 
  locs.lib, 
  itemtypes.description, 
  ccodes.lib AS CCODE, 
  items.itemcallnumber, 
  biblio.author, 
  Concat_Ws( 
    " ", 
    biblio.title, 
    ExtractValue( 
      biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]' 
    ), 
    ExtractValue( 
      biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]' 
    ), 
    ExtractValue( 
      biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]' 
    ), 
    ExtractValue( 
      biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]' 
    ) 
  ) AS FULL_TITLE, 
  items.enumchron, 
  items.copynumber 
FROM statistics 
  JOIN branches 
    ON statistics.branch = branches.branchcode 
  LEFT JOIN itemtypes 
    ON itemtypes.itemtype = statistics.itemtype 
  JOIN items 
    ON items.itemnumber = statistics.itemnumber 
  LEFT JOIN 
    ( 
      SELECT 
        authorised_values.category, 
        authorised_values.authorised_value, 
        authorised_values.lib, 
        authorised_values.lib_opac 
      FROM authorised_values 
      WHERE authorised_values.category = 'loc' 
    ) locs 
    ON locs.authorised_value = items.permanent_location 
  LEFT JOIN branches item_home 
    ON item_home.branchcode = items.homebranch 
  LEFT JOIN 
    ( 
      SELECT authorised_values.category, 
        authorised_values.authorised_value, 
        authorised_values.lib, 
        authorised_values.lib_opac 
      FROM authorised_values 
      WHERE authorised_values.category = 'ccode' 
    ) ccodes 
    ON ccodes.authorised_value = statistics.ccode 
  JOIN biblio 
    ON items.biblionumber = biblio.biblionumber 
  JOIN biblio_metadata 
    ON biblio_metadata.biblionumber = biblio.biblionumber 
WHERE 
  (statistics.type = 'issue' 
    OR statistics.type = 'renew') AND 
  (branches.branchcode LIKE @brn:=<> COLLATE utf8mb4_unicode_ci) AND 
  (items.homebranch NOT LIKE @brn) AND 
  items.permanent_location LIKE <> AND 
  statistics.itemtype LIKE <> AND 
  statistics.ccode LIKE <> AND 
  statistics.datetime BETWEEN <> and (<> + interval 1 day) 
ORDER BY CKO_LIBRARY, 
  OWNING_LIBRARY, 
  locs.lib, 
  itemtypes.description, 
  ccodes.lib, 
  items.itemcallnumber, 
  biblio.author, 
  FULL_TITLE, 
  items.enumchron, 
  items.copynumber 


























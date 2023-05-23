/*
R.003084

----------

Name: GHW - Priority Holds Report
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-06-18 11:15:38
Modified on: 2023-03-03 16:44:10
Date last run: 2023-05-23 14:04:53

----------

Public: 0
Expiry: 300

----------

<div id="reportinfo" class="noprint reportinfo">
<p>Print holds queue report with scannable barcodes and divided into priorities.</p>
<ul><li>Shows items in the current holds queue</li>
<li>at the location you specify</li>
<li>grouped by specified location, items home branch, call number, author, and title</li>
<li>sorted by request priority and standard NEXT classification.</li>
<li>contains links to the bibliographic records</li>
</ul><br />
<p></p>
<p>Notes:</p>
<p></p>
<p><span style="text-decoration: underline;">Highest priority</span> = request is for pickup at this library || or || this is an item level request.</p>
<p><span style="text-decoration: underline;">High priority</span> = the copy requested is the only copy owned by any Next Search Catalog library</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3084&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT 
  Concat_Ws( 
    '<br />', 
    If( 
      LOCATIONS.lib = PERM_LOCATIONS.lib, 
      LOCATIONS.lib, 
      Concat(PERM_LOCATIONS.lib, " (", LOCATIONS.lib, ")") 
    ), 
    ITEMTYPESS.description, 
    CCODES.lib, 
    items.itemcallnumber, 
    items.copynumber, 
    If( 
      hold_fill_targets.source_branchcode = priority.branchcode, 
      "<span style='font-weight: bold;'>(Highest priority)</span>", 
      If( 
        hold_fill_targets.item_level_request = 1, 
        "<span style='font-weight: bold;'>(Highest priority)</span>", 
        If( 
          priority.Count_itemnumber = 1, 
          "<span>(High priority)</span>",
          "" 
        ) 
      ) 
    ), 
    Concat('<span class="noprint">Accessioned date: ', items.dateaccessioned, '</span>'), 
    (Concat( 
      '<br />', 
      '<a class="btn btn-default noprint" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
      biblio.biblionumber, 
      '\" target="_blank">Go to biblio</a>' 
      ) 
    ) 
  ) AS CALL_NUMBER, 
  Concat_Ws( 
    '<br />', 
    biblio.author, 
    Concat_Ws( 
      ' ', 
      biblio.title, 
      '<br />', 
      IF( 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') = '', 
        '', 
        Concat( 
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), 
          '<br />' 
        ) 
      ), 
      IF( 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]') = '', 
        '', 
        Concat( 
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
          '<br />' 
        ) 
      ), 
      IF( 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]') = '', 
        '', 
        Concat( 
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), 
          '<br />' 
        ) 
      ), 
      IF( 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]') = '', 
        '', 
        Concat( 
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
          '<br />' 
        ) 
      ) 
    ) 
  ) AS AUTHOR_TITLE, 
  Concat_Ws( 
    '<br />', 
    Concat( 
      '<img src="/cgi-bin/koha/svc/barcode?barcode=', 
      '*', 
      Upper(items.barcode), 
      '*', 
      '&type=Code39"></img>' 
    ), 
    items.barcode , 
    '<br />', 
    items.holdingbranch
  ) AS BARCODE 
FROM 
  biblio LEFT JOIN 
  ((hold_fill_targets LEFT JOIN 
  items ON hold_fill_targets.itemnumber = items.itemnumber) LEFT JOIN 
  biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber) ON 
      biblio.biblionumber = biblio_metadata.biblionumber LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'CCODE' 
  ) CCODES 
  ON CCODES.authorised_value = 
    items.ccode LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
  ) PERM_LOCATIONS 
  ON PERM_LOCATIONS.authorised_value = items.permanent_location LEFT JOIN 
  ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
  ) LOCATIONS 
  ON LOCATIONS.authorised_value = items.location LEFT JOIN 
  ( 
    SELECT 
      itemtypes.itemtype, 
      itemtypes.description 
    FROM 
      itemtypes 
  ) ITEMTYPESS 
  ON ITEMTYPESS.itemtype = items.itype JOIN 
  ( 
    SELECT 
      hold_fill_targets.reserve_id, 
      reserves.branchcode, 
      icounts.Count_itemnumber 
    FROM 
      hold_fill_targets JOIN 
      reserves ON reserves.reserve_id = hold_fill_targets.reserve_id LEFT JOIN 
      ( 
        SELECT 
          items.biblionumber, 
          Count(DISTINCT items.itemnumber) AS Count_itemnumber 
        FROM 
          items 
        WHERE 
          (items.notforloan IS NOT NULL OR 
            items.notforloan <> 0) AND 
          (items.damaged IS NOT NULL OR 
            items.damaged <> 0) AND 
          (items.itemlost IS NOT NULL OR 
            items.itemlost <> 0) AND 
          (items.withdrawn IS NOT NULL OR 
            items.withdrawn <> 0) AND 
          items.onloan IS NULL 
        GROUP BY 
          items.biblionumber 
    ) icounts 
    ON icounts.biblionumber = hold_fill_targets.biblionumber 
  ) priority 
  ON priority.reserve_id = hold_fill_targets.reserve_id 
WHERE 
  hold_fill_targets.source_branchcode LIKE <<Choose your library|ZBRAN>> 
GROUP BY 
  hold_fill_targets.itemnumber 
ORDER BY 
  If( 
    hold_fill_targets.source_branchcode = priority.branchcode, 
    "1", 
    If( 
      hold_fill_targets.item_level_request = 1, 
      "1", 
      If( 
        priority.Count_itemnumber = 1, 
        "2", 
        "3" 
      ) 
    ) 
  ), 
  items.homebranch, 
  PERM_LOCATIONS.lib, 
  ITEMTYPESS.description, 
  CCODES.lib, 
  items.itemcallnumber, 
  biblio.author, 
  biblio.title, 
  items.barcode


























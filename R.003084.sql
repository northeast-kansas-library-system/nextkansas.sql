/*
R.003084

----------

Name: GHW - Priority Holds Report
Created by: George Williams

----------

Group: -
     -

Created on: 2018-06-18 11:15:38
Modified on: 2025-04-17 09:30:37
Date last run: 2026-01-29 14:12:02

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Print holds queue report with scannable barcodes and divided into priorities.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items in the current holds queue&lt;/li&gt;
&lt;li&gt;at the location you specify&lt;/li&gt;
&lt;li&gt;grouped by specified location, items home branch, call number, author, and title&lt;/li&gt;
&lt;li&gt;sorted by request priority and standard NEXT classification.&lt;/li&gt;
&lt;li&gt;contains links to the bibliographic records&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Notes:&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;span style="text-decoration: underline;"&gt;Highest priority&lt;/span&gt; = request is for pickup at this library || or || this is an item level request.&lt;/p&gt;
&lt;p&gt;&lt;span style="text-decoration: underline;"&gt;High priority&lt;/span&gt; = the copy requested is the only copy owned by any Next Search Catalog library&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;

&lt;/div&gt;

----------
*/



SELECT 
  Concat_Ws( 
    '', 
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
      "(Highest priority)", 
      If( 
        hold_fill_targets.item_level_request = 1, 
        "(Highest priority)", 
        If( 
          priority.Count_itemnumber = 1, 
          "(High priority)",
          "" 
        ) 
      ) 
    ), 
    Concat('Accessioned date: ', items.dateaccessioned, ''), 
    (Concat( 
      '', 
      'Go to biblio' 
      ) 
    ) 
  ) AS CALL_NUMBER, 
  Concat_Ws( 
    '', 
    Concat_WS('',
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="110"]/subfield[@code="a"]'),
      biblio.author
    ), 
    Concat_Ws( 
      ' ', 
      biblio.title, 
      '', 
      IF( 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') = '', 
        '', 
        Concat( 
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), 
          '' 
        ) 
      ), 
      IF( 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]') = '', 
        '', 
        Concat( 
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
          '' 
        ) 
      ), 
      IF( 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]') = '', 
        '', 
        Concat( 
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), 
          '' 
        ) 
      ), 
      IF( 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]') = '', 
        '', 
        Concat( 
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
          '' 
        ) 
      ) 
    ) 
  ) AS AUTHOR_TITLE, 
  Concat_Ws( 
    '', 
    Concat( 
      '' 
    ), 
    items.barcode , 
    '', 
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
            items.notforloan &lt;&gt; 0) AND 
          (items.damaged IS NOT NULL OR 
            items.damaged &lt;&gt; 0) AND 
          (items.itemlost IS NOT NULL OR 
            items.itemlost &lt;&gt; 0) AND 
          (items.withdrawn IS NOT NULL OR 
            items.withdrawn &lt;&gt; 0) AND 
          items.onloan IS NULL 
        GROUP BY 
          items.biblionumber 
    ) icounts 
    ON icounts.biblionumber = hold_fill_targets.biblionumber 
  ) priority 
  ON priority.reserve_id = hold_fill_targets.reserve_id 
WHERE 
  hold_fill_targets.source_branchcode LIKE &lt;&gt; 
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


























/*
R.003084

----------

Name: GHW - Priority Holds Report
Created by: George Williams

----------

Group: -
     -

Created on: 2018-06-18 11:15:38
Modified on: 2026-05-01 15:25:06
Date last run: 2026-08-25 19:40:21

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

<style>

  .report_hidden {
    display:  none
  }

  .accordion .accordion-button {
    font-size:  1.1em !important;
    color:  #fff !important;
    font-weight:  900
  }

  .next_report_function .accordion-header * {
    background-color:  #df6320 !important;
    color:  #fff !important
  }

  .next_report_notes .accordion-header * {
    background-color:  #dfc220 !important;
    color:  #000 !important
  }

  .next_report_instructions .accordion-header * {
    background-color:  #3ddf20 !important;
    color:  #000 !important
  }

  .next_report_resources .accordion-header * {
    background-color:  #1f9bde !important;
    color:  #fff !important
  }

  .next_report_training .accordion-header * {
    background-color:  #6320df !important;
    color:  #fff !important
  }

  .accordion-collapse.collapse * {
    background-color:  #e6e6e6;
    color:  #000
  }

  .accordion-body h3 {
    font-size:  1.5em !important
  }

  .report_section {
    border:  2px solid #000;
    border-radius:  8px;
    margin:  10px;
    padding:  15px
  }

  .resources_btn, .training_btn, .direct_download_btn {
    padding:  10px;
    margin:  10px 0 0;
    display:  inline-block;
    font-weight:  650;
    line-height:  1.5;
    text-align:  center;
    vertical-align:  middle;
    white-space:  nowrap;
    color:  #000
  }

  .resources_btn {
    border:  1px solid #555;
    border-radius:  4px;
    background:  #dfc220 !important
  }

  .training_btn {
    border:  1px solid #555;
    border-radius:  4px;
    background:  #3ddf20 !important
  }

  .direct_download_btn {
    color:  #fff;
    border:  1px solid #555;
    border-radius:  4px;
    background:  indigo !important
  }
  .direct_download_btn:hover {
    color: #000000 !important;
    background: #D396FF !important;
  }

</style>

<!-- Overview -->

  <div class="next_report_summary">
    <br>

    <p id="report_id"><strong> Report number:</strong> 3084</p>

    <p id="report_name"><strong> Report name:</strong>Priority Holds Report</p>

    <p id="report_author"><strong> Report author:</strong>George H. Williams</p>

    <p id="report_summary"><strong> Report summary:</strong> Prints current holds queue in order from highest priority to standard priority.</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3084-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3084Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3084Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3084Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3084Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3084Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Print holds queue report with scanable barcodes and divided into priorities.</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> shows items in the current holds queue</li>

              <li><strong>AT:</strong> the location you specify</li>

              <li><strong>GROUPED BY:</strong> specified location, items home branch, call number, author, and title</li>

              <li><strong>SORTED BY:</strong> request priority and standard NEXT classification.</li>

              <li><strong>CONTAINS LINKS:</strong> Each row is linked to bibliographic records of the items being requested</li>
            </ul>


            <p>Highest priority = request is for pickup at this library || or || this is an item level request.<br>High priority = the copy requested is the only copy owned by any Next Search Catalog library</p>

          </div>

        </div>
      </div>

    </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#holds queue</p>
    <p>#priority</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
  </div>

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
      '<a class="next_btn next_green noprint" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
      biblio.biblionumber, 
      '\" target="_blank">Go to biblio</a>' 
      ) 
    ) 
  ) AS CALL_NUMBER, 
  Concat_Ws( 
    '<br />', 
    Concat_WS('',
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="110"]/subfield[@code="a"]'),
      biblio.author
    ), 
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


























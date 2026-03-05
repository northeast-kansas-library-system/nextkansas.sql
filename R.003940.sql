/*
R.003940

----------

Name: GHW - Daily item count by collection code
Created by: George Williams

----------

Group: -
     -

Created on: 2026-01-19 09:55:55
Modified on: 2026-01-29 16:48:18
Date last run: 2026-03-04 22:00:04

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

    <p id="report_id"><strong>Report number:</strong> 3940</p>

    <p id="report_name"><strong>Report name:</strong> Daily item count by collection code</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Returns a current count of items by collection code</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3940-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3940Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3940Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3940Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3940Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3940Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts itesm</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> counts items in the catalog at the time the report is run</li>

              <li><strong>AT:</strong> all Next Search Catalog libraries</li>

              <li><strong>GROUPED BY:</strong> item type</li>

              <li><strong>SORTED BY:</strong> item type</li>

            <span style="display: none;">
              <li><strong>CONTAINS LINKS:</strong> </li>
            </span>
            </ul>


            <p>This report is currently set to run automatically every night at 10:00 p.m. and have its results e-mailed to the Next Search Catalog coordinator</p>

          </div>

        </div>
      </div>

    </div>

<!-- Direct download section -->
  <div class="next_report_direct_download ">
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3940" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#count items</p>
    <p>#collection code count</p>
    <p>#automatic</p>
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
  ccodes.lib AS COLLECTION_CODE,
  ccodes.authorised_value AS CCODE,
  Coalesce(itemss.Count_itemnumber, 0) AS ITEM_COUNT,
  Date_Format(CurDate(), "%y-%m-%d") AS DATE
FROM
  (SELECT
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    UNION
    SELECT
      '-' AS lib,
      ' No collection code' AS authorised_value,
      'CCODE' AS category) ccodes LEFT JOIN
  (SELECT
      Coalesce(items.ccode, '-') AS ccode,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      Coalesce(items.ccode, '-')) itemss ON
      itemss.ccode = ccodes.authorised_value
GROUP BY
  ccodes.lib,
  ccodes.authorised_value
ORDER BY
  COLLECTION_CODE
LIMIT 250


























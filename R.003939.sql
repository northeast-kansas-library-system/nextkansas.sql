/*
R.003939

----------

Name: GHW - Daily item type count
Created by: George Williams

----------

Group: -
     -

Created on: 2026-01-19 08:57:45
Modified on: 2026-01-29 14:00:02
Date last run: 2026-04-09 22:00:03

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

    <p id="report_id"><strong>Report number:</strong> 3939</p>

    <p id="report_name"><strong>Report name:</strong> Daily item type count</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Returns a current count of items by item type</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3939-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3939Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3939Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3939Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3939Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3939Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts items</p>
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
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3939" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#count items</p>
    <p>#item type count</p>
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
  item_types.description AS ITEM_TYPE,
  item_types.itemtype AS ITYPE_CODE,
  Coalesce(itemss.COUNT, 0) AS ITEM_COUNT,
  Date_Format(CurDate(), "%Y-%m-%d") AS DATE
FROM
  (SELECT
      itemtypes.description,
      itemtypes.itemtype
    FROM
      itemtypes
    UNION
    SELECT
      ' No item type' AS Column1,
      '-' AS Column2
    FROM
      itemtypes) item_types LEFT JOIN
  (SELECT
      Coalesce(items.itype, '-') AS CODE,
      Count(items.itemnumber) AS COUNT
    FROM
      items
    GROUP BY
      Coalesce(items.itype, '-')) itemss ON itemss.CODE = item_types.itemtype
GROUP BY
  item_types.description,
  item_types.itemtype
ORDER BY
  ITEM_TYPE
LIMIT 250


























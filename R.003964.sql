/*
R.003964

----------

Name: GHW - Flexible Circulation and Renewal Count by Shelving Location
Created by: George Williams

----------

Group: Statistics
     -

Created on: 2026-07-16 08:25:09
Modified on: 2026-07-16 08:32:36
Date last run: 2026-07-16 09:28:35

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

    <p id="report_id"><strong>Report number:</strong> 2770</p>

    <p id="report_name"><strong>Report name:</strong> Circulation and Renewal Count by Shelving Location with flexible date range</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Counts circulation, groups by library, shelving location, and allows flexible date range input.</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_2770-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_2770Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_2770Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_2770Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_2770Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_2770Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts circulation (checkouts and renewals)</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> the date range you specify</li>

              <li><strong>AT:</strong> at the library you specify</li>

              <li><strong>GROUPED BY:</strong> library and shelving location</li>

              <li><strong>SORTED BY:</strong> library and shelving location</li>

            <span style="display: none;">
              <li><strong>CONTAINS LINKS:</strong> </li>
            </span>
            </ul>


            <p>Uses SQL "ROLLUP" function to auto-generate totals for each library</p>

          </div>

        </div>
      </div>

    </div>

<!-- Notes section -->
    <div id="accordion_2770-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_2770Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_2770Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_2770Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_2770Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_2770Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Created for</h4>
            <p>Report created by GHW at the request of LEAVENWRTH so they could track circulation of items on display.</p>
          </div>

          <div id="notes_2" class="report_section">
            <h4>Limitations</h4>
            <p>Items without a shelving location will be recorded as having a shelving location of "Adult."</p>
          </div>

          <div id="notes_3" class="report_section">
            <h4>Updated</h4>
            <p>Updated on 2021.10.20 to include changes based on the "Recently returned" shelving location.</p>
          </div>

          <div id="notes_4" class="report_section">
            <h4>Updated</h4>
            <p>Notes updated on 2026.07.16</p>
          </div>

          <div id="notes_5" class="report_section report_hidden">
            <h4> NOTE_FIVE_TITLE </h4>
            <p> NOTE_FIVE_CONTENT </p>
          </div>

        </div>
      </div>

    </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#circulation</p>
    <p>#checkouts</p>
    <p>#renewals</p>
    <p>#count</p>
    <p>#daterange</p>
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
  branches.branchname AS BRANCHNAME,
  Coalesce(branches.lib, '** Total **') AS SHELVING_LOCATION,
  Coalesce(Sum(statisticss.CKO_RENEW_COUNT), 0) AS CKO_RENEW_COUNT
FROM
  (SELECT
      branches.branchcode,
      branches.branchname,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category
    FROM
      branches,
      authorised_values
    WHERE
      authorised_values.category = 'LOC') branches LEFT JOIN
  (SELECT
      statistics.branch,
      Count(*) AS CKO_RENEW_COUNT,
      If(
        Coalesce(statistics.location, "L_AD") = "CART",
        items.permanent_location, 
        Coalesce(statistics.location, "L_AD")
      ) AS
      location
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      statistics.datetime BETWEEN 
        <<Between the start of the day on|date>> AND 
        (<<and the end of the day on|date>> + INTERVAL 1 DAY) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      statistics.branch,
      Coalesce(statistics.location, "L_AD")) statisticss ON
      statisticss.branch = branches.branchcode AND
      statisticss.location = branches.authorised_value
WHERE
  branches.branchcode LIKE <<Choose your library|LBRANCH>>
GROUP BY
  branches.branchname,
  branches.lib
WITH rollup


























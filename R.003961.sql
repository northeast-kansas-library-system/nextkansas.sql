/*
R.003961

----------

Name: GHW - Which fields in Koha are date and which are datetime
Created by: George Williams

----------

Group: -
     -

Created on: 2026-06-04 14:36:57
Modified on: 2026-06-04 15:13:02
Date last run: 2026-06-04 15:13:02

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

    <p id="report_id"><strong>Report number:</strong> 3961</p>

    <p id="report_name"><strong>Report name:</strong> All date fields</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> List all 'date', 'time', 'datetime', 'year', and 'timestamp' fields in Koha.</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3961-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3961Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3961Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3961Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3961Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3961Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Generates bits and pieces of SQL that you can use to make other reports</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> now</li>

            <span style="display: none;">
              <li><strong>AT:</strong> </li>
            </span>

              <li><strong>GROUPED BY:</strong> date</li>

            <span style="display: none;">
              <li><strong>SORTED BY:</strong> </li>
            </span>

            <span style="display: none;">
              <li><strong>CONTAINS LINKS:</strong> </li>
            </span>
            </ul>


            <span style="display: none;">
            <p> - </p>
            </span>

          </div>

        </div>
      </div>

    </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#dates</p>
    <p>#koha-us_video</p>
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
  Concat_Ws('.', col.TABLE_NAME, col.COLUMN_NAME) AS field,
  col.DATA_TYPE AS type
FROM
  information_schema.COLUMNS col JOIN
  information_schema.TABLES tab ON tab.TABLE_SCHEMA = col.TABLE_SCHEMA AND
      tab.TABLE_NAME = col.TABLE_NAME AND
      tab.TABLE_TYPE = 'BASE TABLE'
WHERE
  col.DATA_TYPE IN ('date', 'time', 'datetime', 'year', 'timestamp')
ORDER BY
  col.TABLE_NAME


























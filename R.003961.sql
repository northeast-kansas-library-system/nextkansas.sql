/*
R.003961

----------

Name: GHW - Which fields in Koha are date and which are datetime
Created by: George Williams

----------

Group: -
     -

Created on: 2026-06-04 14:36:57
Modified on: 2026-07-28 18:10:34
Date last run: 2026-07-28 18:10:34

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

              <li><strong>TIME FRAME:</strong> shows fields currently in the Koha schema</li>

            <span style="display: none;">
              <li><strong>AT:</strong> </li>
            </span>

              <li><strong>GROUPED BY:</strong> field name and type of date</li>

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

<!-- Notes section -->
<div id="accordion_-2" class="accordion-item next_report_notes ">

    <h2 class="accordion-header" id="panelsStay_Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
            data-bs-target="#panelsStay_Open-collapseTwo" aria-expanded="false"
            aria-controls="panelsStay_Open-collapseTwo">

            Notes:

        </button>

    </h2>

    <div id="panelsStay_Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_Open-headingTwo">
        <div class="accordion-body">

            <div id="notes_1" class="report_section">
                <h4>Date types</h4>
                <p>
                <table>
                    <colgroup>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>
                                <p style="text-align: center"><span>DATA TYPES</span></p>
                            </th>
                            <th>
                                <p style="text-align: center"><span>Range</span></p>
                            </th>
                            <th>
                                <p style="text-align: center"><span>Format</span></p>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <p style="text-align: center"><span>DATE</span></p>
                            </td>
                            <td>
                                <p style="text-align: center"><span>1000-01-01 to 9999-12-31</span></p>
                            </td>
                            <td>
                                <p style="text-align: center"><span>YYYY-MM-DD</span></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p style="text-align: center"><span>TIME</span></p>
                            </td>
                            <td>
                                <p style="text-align: center"><span>-838:59:59 to 838:59:59</span></p>
                            </td>
                            <td>
                                <p style="text-align: center"><span>HH:MM:SS</span></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p style="text-align: center"><span>DATETIME</span></p>
                            </td>
                            <td>
                                <p style="text-align: center"><span>1000-01-01 00:00:00 to 9999-12-31 23:59:59</span>
                                </p>
                            </td>
                            <td>
                                <p style="text-align: center"><span>YYYY-MM-DD HH:MM:SS</span></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p style="text-align: center"><span>TIMESTAMP</span></p>
                            </td>
                            <td>
                                <p style="text-align: center"><span>1970-01-01 00:00:01 UTC to 2038-01-19 03:14:07
                                        UTC</span> </p>
                            </td>
                            <td>
                                <p style="text-align: center"><span>YYYY-MM-DD HH:MM:SS</span></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p style="text-align: center"><span>YEAR</span></p>
                            </td>
                            <td>
                                <p style="text-align: center"><span>2 0r 4 digit</span></p>
                            </td>
                            <td>
                                <p style="text-align: center"><span>4 digit format.</span></p>
                            </td>
                        </tr>
                    </tbody>
                </table>
                </p>
            </div>

            <div id="notes_2" class="report_section report_hidden">
                <h4> NOTE_TWO_TITLE </h4>
                <p> NOTE_TWO_CONTENT </p>
            </div>

            <div id="notes_3" class="report_section report_hidden">
                <h4> NOTE_THREE_TITLE </h4>
                <p> NOTE_THREE_CONTENT </p>
            </div>

            <div id="notes_4" class="report_section report_hidden">
                <h4> NOTE_FOUR_TITLE </h4>
                <p> NOTE_FOUR_CONTENT </p>
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
    <p>#koha</p>
    <p>#dates</p>
    <p>#SQL</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#has_notes</p>
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


























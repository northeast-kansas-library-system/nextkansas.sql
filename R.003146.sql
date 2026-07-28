/*
R.003146

----------

Name: GHW - Date helper
Created by: George Williams

----------

Group: -
     -

Created on: 2018-12-17 15:53:14
Modified on: 2026-06-04 15:07:36
Date last run: 2026-06-04 15:07:36

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

    <p id="report_id"><strong>Report number:</strong> 3146</p>

    <p id="report_name"><strong>Report name:</strong> Date helper</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Useful SQL to use in other reports</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3146-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3146Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3146Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3146Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3146Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3146Open-headingOne">
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
    <p>#date</p>
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
  @1 := 'YESTERDAY'  AS DESCRIPTION,
  @2 := 'CurDate() - INTERVAL 1 DAY' AS `"SQL"`,
  CurDate() - INTERVAL 1 DAY
UNION
SELECT
  @1 := 'TODAY',
  @2 := 'CurDate()',
  CurDate()
UNION
SELECT
  @1 := 'TOMORROW',
  @2 := 'CurDate() + INTERVAL 1 DAY',
  CurDate() + INTERVAL 1 DAY
UNION
SELECT
  @1 := 'FIRST_DATE_LAST_YEAR',
  @2 := 'MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR',
  MakeDate(Year(Now()), 1) - INTERVAL 1 YEAR
UNION
SELECT
  @1 := 'FIRST_DATE_THIS_YEAR',
  @2 := 'MakeDate(Year(Now()), 1)',
  MakeDate(Year(Now()), 1)
UNION
SELECT
  @1 := 'FIRST_DATE_NEXT_YEAR',
  @2 := 'MakeDate(Year(Now()), 1) + INTERVAL 1 YEAR',
  MakeDate(Year(Now()), 1) + INTERVAL 1 YEAR
UNION
SELECT
  @1 := 'FIRST_DATE_LAST_M',
  @2 := 'AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)',
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)
UNION
SELECT
  @1 := 'FIRST_DATE_THIS_M',
  @2 := 'AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)',
  AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
UNION
SELECT
  @1 := 'FIRST_DATE_NEXT_M',
  @2 := 'AddDate(Last_Day(SubDate(Now(), INTERVAL -1 MONTH)), 1)',
  AddDate(Last_Day(SubDate(Now(), INTERVAL -1 MONTH)), 1)
UNION
SELECT
  @1 := 'Y_LAST_Y',
  @2 := 'Year(Now() - INTERVAL 1 YEAR)',
  Year(Now() - INTERVAL 1 YEAR)
UNION
SELECT
  @1 := 'Y_THIS_Y',
  @2 := 'Year(Now())',
  Year(Now())
UNION
SELECT
  @1 := 'Y_NEXT_Y',
  @2 := 'Year(Now() + INTERVAL 1 YEAR)',
  Year(Now() + INTERVAL 1 YEAR)
UNION
SELECT
  @1 := 'Y_LAST_M',
  @2 := 'Year(Now() - INTERVAL 1 MONTH)',
  Year(Now() - INTERVAL 1 MONTH)
UNION
SELECT
  @1 := 'Y_THIS_M',
  @2 := 'Year(Now())',
  Year(Now())
UNION
SELECT
  @1 := 'Y_NEXT_M',
  @2 := 'Year(Now() + INTERVAL 1 MONTH)',
  Year(Now() + INTERVAL 1 MONTH)
UNION
SELECT
  @1 := 'M_LAST_M',
  @2 := 'Month(Now() - INTERVAL 1 MONTH)',
  Month(Now() - INTERVAL 1 MONTH)
UNION
SELECT
  @1 := 'M_THIS_M',
  @2 := 'Month(Now())',
  Month(Now())
UNION
SELECT
  @1 := 'M_NEXT_M',
  @2 := 'Month(Now() + INTERVAL 1 MONTH)',
  Month(Now() + INTERVAL 1 MONTH)
UNION
SELECT
  @1 := 'D_1_YEAR_AGO',
  @2 := 'CurDate() - INTERVAL 1 YEAR',
  CurDate() - INTERVAL 1 YEAR
UNION
SELECT
  @1 := 'D_TODAY',
  @2 := 'CurDate()',
  CurDate()
UNION
SELECT
  @1 := 'D_1_YEAR_FROM_NOW',
  @2 := 'CurDate() + INTERVAL 1 YEAR',
  CurDate() + INTERVAL 1 YEAR
UNION
SELECT
  @1 := 'D_TWO_SUNDAYS_AGO',
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) - INTERVAL 1 WEEK',
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) - INTERVAL 1 WEEK
UNION
SELECT
  @1 := 'D_LAST_SUNDAY',
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY)',
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY)
UNION
SELECT
  @1 := 'D_THIS_SUNDAY',
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY)',
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY)
UNION
SELECT
  @1 := 'D_NEXT_SUNDAY',
  @2 := 'Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY) + INTERVAL 1 WEEK',
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY) + INTERVAL 1 WEEK
LIMIT 90



























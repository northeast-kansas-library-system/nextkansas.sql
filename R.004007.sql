/*
R.004007

----------

Name: GHW - All permissions
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2026-11-16 17:18:04
Modified on: 2026-11-16 18:06:19
Date last run: 2026-11-16 17:40:44

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

    <p id="report_id"><strong>Report number:</strong> 4007</p>

    <p id="report_name"><strong>Report name:</strong> Permissions list</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Lists all permissions in Koha</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_4007-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_4007Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_4007Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_4007Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_4007Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_4007Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Lists all permissions in Koha</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> shows permissions available at the time you run the report</li>

              <li><strong>AT:</strong> this Koha installation</li>

              <li><strong>GROUPED BY:</strong> main permission name and sub-permission name</li>

              <li><strong>SORTED BY:</strong> main permission name and sub-permission name</li>

            <span style="display: none;">
              <li><strong>CONTAINS LINKS:</strong> </li>
            </span>
            </ul>


            <p>This is a part of a series of reports designed to make it easier to write reports for Koha</p>

          </div>

        </div>
      </div>

    </div>

<!-- Direct download section -->
  <div class="next_report_direct_download ">
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=4007" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#koha_internal</p>
    <p>#</p>
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
  all_permissions_and_flags.DESCRIPTION AS MAIN_PERMISSION,
  all_permissions_and_flags.SUB AS SUB_PERMISSIONS
FROM
  (
    SELECT
      userflags.bit AS BIT,
      Concat_Ws('', userflags.flagdesc, ' (', userflags.flag, ')') AS DESCRIPTION,
      '' AS SUB
    FROM
      userflags
    UNION
    SELECT
      permissions.module_bit AS BIT,
      '-' AS DESCRIPTION,
      Concat_Ws('', permissions.description, ' (', permissions.code, ')') AS SUB
    FROM
      permissions
  ) all_permissions_and_flags
ORDER BY
  all_permissions_and_flags.BIT,
  If(
    all_permissions_and_flags.DESCRIPTION = '-',
    'ZZZZZ',
    all_permissions_and_flags.DESCRIPTION
  ),
  SUB


























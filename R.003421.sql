/*
R.003421

----------

Name: 0012 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 17:45:36
Modified on: 2026-01-30 17:26:08
Date last run: 2026-04-01 00:12:01

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

    <p id="report_id"><strong>Report number:</strong> 3421</p>

    <p id="report_name"><strong>Report name:</strong> 0020 - 2024_99_a_cy monthly_statistics</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Generates part of the monthly overview spreadsheet</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3421-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3421Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3421Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3421Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3421Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3421Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Gathers intra-consortial loans and borrows data</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> gathers data for the previous calendar month</li>

              <li><strong>AT:</strong> all next search catalog libraries</li>

              <li><strong>GROUPED BY:</strong> library name</li>

              <li><strong>SORTED BY:</strong> library name</li>

            <span style="display: none;">
              <li><strong>CONTAINS LINKS:</strong> </li>
            </span>
            </ul>


            <p>These counts are are based on whether you shipped or received an item via the Kansas Library Express courier. Whether or not the item was actually checked out to a borrower is irrelevant in this count because, whether or not loaned to a borrower, the item was loaned to another library or borrowed from your library.</p>

            <p>Runs in 00:00:04 // Tested 2026-01-30</p>

          </div>

        </div>
      </div>

    </div>

<!-- Notes section -->
    <div id="accordion_3421-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3421Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3421Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3421Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3421Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3421Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Column header definitions</h4>
            <p><ul><br><li>NX_ILL_LOANED_LM = count of items your library loaned to another Next Search Catalog library last month</li><br><li>NX_ILL_BORROWED_LM = count of items your library borrowed from another Next Search Catalog library last month</li><br></ul></p>
          </div>

          <div id="notes_2" class="report_section">
            <h4>Header row</h4>
            <p>The header row is duplicated to make it easier to schedule the report with the built-in report scheduling tool.</p>
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

<!-- Direct download section -->
  <div class="next_report_direct_download ">
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3421" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#statistics</p>
    <p>#overview</p>
    <p>#monthly_overview</p>
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
  'BRANCHNAME' AS BRANCHNAME,
  'NX_ILL_LOANED_LM' AS NX_ILL_LOANED_LM,
  'NX_ILL_BORROWED_LM' AS NX_ILL_BORROWED_LM
UNION  
(SELECT 
  'BRANCHNAME' AS BRANCHNAME,
  'NX_ILL_LOANED_LM' AS NX_ILL_LOANED_LM, 
  'NX_ILL_BORROWED_LM' AS NX_ILL_BORROWED_LM
UNION
(SELECT 
  branches.branchname, 
  Coalesce(ILL_LOANED.count, 0) AS NX_ILL_LOANED_LM, 
  Coalesce(ILL_BORROWED.count, 0) AS NX_ILL_BORROWED_LM 
FROM 
  branches LEFT JOIN 
    (SELECT 
      items.homebranch, 
      COUNT(*) AS count 
    FROM 
      branchtransfers LEFT JOIN 
      items ON branchtransfers.itemnumber = items.itemnumber 
    WHERE 
      items.homebranch <> branchtransfers.tobranch AND 
      Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND 
      branchtransfers.tobranch <> branchtransfers.frombranch AND 
      branchtransfers.comments IS NULL  AND
      branchtransfers.reason = 'reserve'
    GROUP BY 
      items.homebranch 
    ) ILL_LOANED 
  ON branches.branchcode = ILL_LOANED.homebranch LEFT JOIN 
    (SELECT 
      branchtransfers.tobranch, 
      COUNT(*) AS count 
    FROM 
      branchtransfers LEFT JOIN 
      items ON branchtransfers.itemnumber = items.itemnumber 
    WHERE 
      branchtransfers.tobranch <> items.homebranch AND 
      Month(branchtransfers.datearrived) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(branchtransfers.datearrived) = Year(Now() - INTERVAL 1 MONTH) AND 
      branchtransfers.frombranch <> branchtransfers.tobranch AND 
      branchtransfers.comments IS NULL  AND
      branchtransfers.reason = 'reserve'
    GROUP BY 
      branchtransfers.tobranch 
    ) ILL_BORROWED 
  ON branches.branchcode = ILL_BORROWED.tobranch 
GROUP BY 
  branches.branchname
ORDER BY 
  branches.branchname))


























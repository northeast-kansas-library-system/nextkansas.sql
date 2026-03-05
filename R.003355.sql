/*
R.003355

----------

Name: 0040 - 2024_99_d_circulation_unique_daily_borrowers monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2020-10-08 22:42:10
Modified on: 2026-01-30 17:27:51
Date last run: 2026-03-01 00:40:01

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

    <p id="report_id"><strong>Report number:</strong> 3355</p>

    <p id="report_name"><strong>Report name:</strong> 0050 - 2024_99_d_circulation_unique_daily_borrowers monthly_statistics</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Generates data for monthly statistics</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3355-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3355Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3355Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3355Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3355Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3355Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts the number of unique individual library cards used to check out and renew materials at your library</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> previous calendar month</li>

              <li><strong>AT:</strong> all Next Search Catalog libraries</li>

              <li><strong>GROUPED BY:</strong> library name and day of the month</li>

              <li><strong>SORTED BY:</strong> library name</li>

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
    <div id="accordion_3355-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3355Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3355Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3355Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3355Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3355Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>How unique borrowers are counted</h4>
            <p><p>A borrower is counted as 1 borrower if they check out or renew materials on the day specified. If a borrower checks out 10 items at 10:00 a.m. and then checks out additional items at 4:00 p.m., that borrower is only counted once for the purposes of this report.</p><p>The final column is a monthly count of unique borrowers. So if a borrower checks out 1 book on the first of the month and then checks out 1 book on the 15th of the month, that borrower is only counted as 1 unique borrower in the final column of this report.</p></p>
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
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3355" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#monthly</p>
    <p>#statistics</p>
    <p>#borrower</p>
    <p>#details</p>
    <p>#unique</p>
    <p>#circulation_by_borrower_details</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
  </div>

</div>

----------
*/



SELECT 
  'branchname' AS 'branchname',  
  '1' AS '1',  
  '2' AS '2',  
  '3' AS '3',  
  '4' AS '4',  
  '5' AS '5',  
  '6' AS '6',  
  '7' AS '7',  
  '8' AS '8',  
  '9' AS '9',  
  '10' AS '10',  
  '11' AS '11',  
  '12' AS '12',  
  '13' AS '13',  
  '14' AS '14',  
  '15' AS '15',  
  '16' AS '16',  
  '17' AS '17',  
  '18' AS '18',  
  '19' AS '19',  
  '20' AS '20',  
  '21' AS '21',  
  '22' AS '22',  
  '23' AS '23',  
  '24' AS '24',  
  '25' AS '25',  
  '26' AS '26',  
  '27' AS '27',  
  '28' AS '28',  
  '29' AS '29',  
  '30' AS '30',  
  '31' AS '31',  
  'MONTHLY_TOTAL' AS 'MONTHLY_TOTAL' 
UNION 
(SELECT 
  branchess.branchname, 
  aa.Count_borrowernumber AS `01`, 
  ab.Count_borrowernumber AS `02`, 
  ac.Count_borrowernumber AS `03`, 
  ad.Count_borrowernumber AS `04`, 
  ae.Count_borrowernumber AS `05`, 
  af.Count_borrowernumber AS `06`, 
  ag.Count_borrowernumber AS `07`, 
  ah.Count_borrowernumber AS `08`, 
  ai.Count_borrowernumber AS `09`, 
  aj.Count_borrowernumber AS `10`, 
  ba.Count_borrowernumber AS `11`, 
  bb.Count_borrowernumber AS `12`, 
  bc.Count_borrowernumber AS `13`, 
  bd.Count_borrowernumber AS `14`, 
  be.Count_borrowernumber AS `15`, 
  bf.Count_borrowernumber AS `16`, 
  bg.Count_borrowernumber AS `17`, 
  bh.Count_borrowernumber AS `18`, 
  bi.Count_borrowernumber AS `19`, 
  bj.Count_borrowernumber AS `20`, 
  ca.Count_borrowernumber AS `21`, 
  cb.Count_borrowernumber AS `22`, 
  cc.Count_borrowernumber AS `23`, 
  cd.Count_borrowernumber AS `24`, 
  ce.Count_borrowernumber AS `25`, 
  cf.Count_borrowernumber AS `26`, 
  cg.Count_borrowernumber AS `27`, 
  ch.Count_borrowernumber AS `28`, 
  ci.Count_borrowernumber AS `29`, 
  da.Count_borrowernumber AS `30`, 
  db.Count_borrowernumber AS `31`, 
  zz.Count_borrowernumber AS MONTHLY_TOTAL 
FROM 
  (SELECT 
      branches.branchcode, 
      branches.branchname 
    FROM 
      branches) branchess LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 1 
    GROUP BY 
      statistics.branch) aa ON aa.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 2 
    GROUP BY 
      statistics.branch) ab ON ab.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 3 
    GROUP BY 
      statistics.branch) ac ON ac.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 4 
    GROUP BY 
      statistics.branch) ad ON ad.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 5 
    GROUP BY 
      statistics.branch) ae ON ae.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 6 
    GROUP BY 
      statistics.branch) af ON af.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 7 
    GROUP BY 
      statistics.branch) ag ON ag.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 8 
    GROUP BY 
      statistics.branch) ah ON ah.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 9 
    GROUP BY 
      statistics.branch) ai ON ai.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 10 
    GROUP BY 
      statistics.branch) aj ON aj.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 11 
    GROUP BY 
      statistics.branch) ba ON ba.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 12 
    GROUP BY 
      statistics.branch) bb ON bb.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 13 
    GROUP BY 
      statistics.branch) bc ON bc.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 14 
    GROUP BY 
      statistics.branch) bd ON bd.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 15 
    GROUP BY 
      statistics.branch) be ON be.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 16 
    GROUP BY 
      statistics.branch) bf ON bf.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 17 
    GROUP BY 
      statistics.branch) bg ON bg.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 18 
    GROUP BY 
      statistics.branch) bh ON bh.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 19 
    GROUP BY 
      statistics.branch) bi ON bi.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 20 
    GROUP BY 
      statistics.branch) bj ON bj.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 21 
    GROUP BY 
      statistics.branch) ca ON ca.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 22 
    GROUP BY 
      statistics.branch) cb ON cb.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 23 
    GROUP BY 
      statistics.branch) cc ON cc.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 24 
    GROUP BY 
      statistics.branch) cd ON cd.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 25 
    GROUP BY 
      statistics.branch) ce ON ce.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 26 
    GROUP BY 
      statistics.branch) cf ON cf.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 27 
    GROUP BY 
      statistics.branch) cg ON cg.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 28 
    GROUP BY 
      statistics.branch) ch ON ch.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 29 
    GROUP BY 
      statistics.branch) ci ON ci.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 30 
    GROUP BY 
      statistics.branch) da ON da.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      Year(statistics.datetime) AS YEAR, 
      Month(statistics.datetime) AS MONTH, 
      Day(statistics.datetime) AS DAY, 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
          statistics.type = 'renew') AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Day(statistics.datetime) = 31 
    GROUP BY 
      statistics.branch) db ON db.branch = branchess.branchcode LEFT JOIN 
  (SELECT 
      statisticss.branch, 
      Count(DISTINCT statisticss.borrowernumber) AS Count_borrowernumber 
    FROM 
      statistics statisticss 
    WHERE 
      (statisticss.type = 'issue' OR 
          statisticss.type = 'renew') AND 
      statisticss.datetime BETWEEN (AddDate(Last_Day(SubDate(Now(), INTERVAL 2 
      MONTH)), 1)) AND (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)) 
    GROUP BY 
      statisticss.branch) zz ON zz.branch = branchess.branchcode 
UNION 
SELECT 
  Concat(" DATE") AS branchname, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) AS `01`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 1 DAY AS `02`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 2 DAY AS `03`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 3 DAY AS `04`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 4 DAY AS `05`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 5 DAY AS `06`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 6 DAY AS `07`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 7 DAY AS `08`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 8 DAY AS `09`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 9 DAY AS `10`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 10 DAY AS `11`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 11 DAY AS `12`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 12 DAY AS `13`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 13 DAY AS `14`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 14 DAY AS `15`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 15 DAY AS `16`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 16 DAY AS `17`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 17 DAY AS `18`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 18 DAY AS `19`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 19 DAY AS `20`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 20 DAY AS `21`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 21 DAY AS `22`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 22 DAY AS `23`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 23 DAY AS `24`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 24 DAY AS `25`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 25 DAY AS `26`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 26 DAY AS `27`, 
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 27 DAY AS `28`, 
  If( 
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)), 
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY, 
    "NA" 
  ) AS `29`, 
  If( 
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)), 
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY, 
    "NA" 
  ) AS `30`, 
  If( 
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)), 
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY, 
    "NA" 
  ) AS `31`, 
  Concat(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1), ' - ', Last_Day(CURRENT_DATE()) - INTERVAL 1 MONTH) AS MONTHLY_TOTAL 
UNION 
SELECT 
  Concat(" DAY") AS branchname, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1), "%W") AS `01`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 1 DAY, "%W") AS `02`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 2 DAY, "%W") AS `03`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 3 DAY, "%W") AS `04`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 4 DAY, "%W") AS `05`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 5 DAY, "%W") AS `06`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 6 DAY, "%W") AS `07`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 7 DAY, "%W") AS `08`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 8 DAY, "%W") AS `09`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 9 DAY, "%W") AS `10`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 10 DAY, "%W") AS `11`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 11 DAY, "%W") AS `12`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 12 DAY, "%W") AS `13`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 13 DAY, "%W") AS `14`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 14 DAY, "%W") AS `15`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 15 DAY, "%W") AS `16`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 16 DAY, "%W") AS `17`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 17 DAY, "%W") AS `18`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 18 DAY, "%W") AS `19`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 19 DAY, "%W") AS `20`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 20 DAY, "%W") AS `21`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 21 DAY, "%W") AS `22`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 22 DAY, "%W") AS `23`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 23 DAY, "%W") AS `24`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 24 DAY, "%W") AS `25`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 25 DAY, "%W") AS `26`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 26 DAY, "%W") AS `27`, 
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 27 DAY, "%W") AS `28`, 
  If( 
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)), 
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY, "%W"), 
    "NA" 
  ) AS `29`, 
  If( 
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)), 
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY, "%W"), 
    "NA" 
  ) AS `30`, 
  If( 
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)), 
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY, "%W"), 
    "NA" 
  ) AS `31`, 
  Concat('-') AS MONTHLY_TOTAL 
ORDER BY 
  branchname 
LIMIT 1000
)


























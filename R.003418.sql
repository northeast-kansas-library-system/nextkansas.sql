/*
R.003418

----------

Name: 0005 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 16:34:33
Modified on: 2025-05-13 12:00:57
Date last run: 2025-10-03 12:36:52

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">
  <div id="report-3418" class="accordion accordion-flush">

    <div class="accordion-item">

      <h2 class="accordion-header" id="panelsStayOpen-headingOne">
        <button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">

          Report function:

        </button>
      </h2>
      <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
        <div class="accordion-body">

          <p>Monthly overview - collection statistics</p>

          <ul>
            <li>
              Shows item and holding counts for the previous calendar month
            </li>
            <li>
              At all Next Search Catalog libraries
            </li>
            <li>
              grouped and sorted by branch name
            </li>
          </ul>

        </div>
      </div>
    </div>

    <div class="accordion-item">
      <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
        <button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">

          Report notes:

        </button>
      </h2>
      <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
        <div class="accordion-body">

          <div class="next_report_section">

            <p>Generates data for:</p>

            <ul>
              <li>START_I = number of items owned on the first of the month</li>
              <li>END_I = number of items owned on the last day of the month</li>
              <li>ITEMS_ADD_L_M = items added last month</li>
              <li>ITEMS_DEL_L_M = items deleted last month</li>
              <li>TOTAL_HOLDINGS = number of bibliographic records where at least 1 item was held at this library on the first of the month</li>
            </ul>

          </div>

        </div>
      </div>
    </div>

    <div class="accordion-item next_hidden">
      <h2 class="accordion-header" id="panelsStayOpen-headingThree">
        <button class="accordion-button collapsed next_report_instructions" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">

          Report instructions:

        </button>
      </h2>
      <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree">
        <div class="accordion-body">

          <div class="next_report_section">

            <p>
              Instructions go here
            </p>

          </div>

          <div class="next_report_section">

            <p>
              More instructions go here
            </p>

          </div>

        </div>
      </div>
    </div>

    <div class="accordion-item next_hidden">

      <h2 class="accordion-header" id="panelsStayOpen-headingFour">
        <button class="accordion-button collapsed next_report_resources" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false" aria-controls="panelsStayOpen-collapseFour">

          Report external resources:

        </button>
      </h2>

      <div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingFour">
        <div class="accordion-body">

          <ul style="list-style-type: none;">
            <li>


              Explanation of resource if necessary<br>

              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen1">External resource 1</a>

            </li>
            <li>


              Explanation of resource if necessary<br>

              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen1">External resource 2</a>

            </li>
          </ul>

        </div>
      </div>
    </div>

  </div>

  <div class="next_direct_download next_hidden">

    <a class="next_btn next_indigo next_embiggen1" href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=INSERT_REPORT_NUMBER_HERE">Download this report as a csv file <i class="bi bi-download"></i></a>

  </div>

  <div class="next_hidden">

    <p>

      #monthly 
      #statistics 
      #monthly_statistics
      #overview 
      #monthly_overview

    </p>

  </div>
</div>

----------
*/



SELECT 
  'BRANCH' AS BRANCH, 
  'START_I' AS START_I, 
  'END_I' AS END_I, 
  'ITEMS_ADD_L_M' AS ITEMS_ADD_L_M, 
  'ITEMS_DEL_L_M' AS ITEMS_DEL_L_M, 
  'TOTAL_HOLDINGS' AS TOTAL_HOLDINGS
UNION
SELECT 
  branches.branchname AS BRANCH, 
  Coalesce(Sum(DISTINCT START_ITEMS.count), 0) AS START_I, 
  Coalesce(Sum(DISTINCT END_ITEMS.count), 0) AS END_I, 
  Coalesce(Sum(DISTINCT ITEMS_ADDED.count), 0) AS ITEMS_ADD_L_M, 
  Coalesce(ITEMS_DELETED.count, 0) AS ITEMS_DEL_L_M, 
  Coalesce(Sum(DISTINCT TOTAL_HOLDINGS.count), 0) AS TOTAL_HOLDINGS 
FROM branches 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
      AND deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) START_ITEMS ON branches.branchcode = START_ITEMS.homebranch 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
      AND deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) END_ITEMS ON branches.branchcode = END_ITEMS.homebranch 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY deleteditems.homebranch 
  ) ITEMS_ADDED ON branches.branchcode = ITEMS_ADDED.homebranch 
  LEFT JOIN ( 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY deleteditems.homebranch 
  ) ITEMS_DELETED ON branches.branchcode = ITEMS_DELETED.homebranch 
  LEFT JOIN ( 
    SELECT items.homebranch, 
      Count(DISTINCT items.biblionumber) AS count 
    FROM items 
    WHERE items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(DISTINCT deleteditems.biblionumber) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
      AND deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) TOTAL_HOLDINGS ON branches.branchcode = TOTAL_HOLDINGS.homebranch 
GROUP BY branches.branchname 
ORDER BY IF (BRANCH = 'BRANCH', ' AAAAA', BRANCH) 


























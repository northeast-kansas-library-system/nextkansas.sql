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
Date last run: 2026-01-06 15:27:12

----------

Public: 0
Expiry: 300

----------

&lt;div class="next_report_info next_noprint"&gt;
  &lt;div id="report-3418" class="accordion accordion-flush"&gt;

    &lt;div class="accordion-item"&gt;

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingOne"&gt;
        &lt;button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne"&gt;

          Report function:

        &lt;/button&gt;
      &lt;/h2&gt;
      &lt;div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;p&gt;Monthly overview - collection statistics&lt;/p&gt;

          &lt;ul&gt;
            &lt;li&gt;
              Shows item and holding counts for the previous calendar month
            &lt;/li&gt;
            &lt;li&gt;
              At all Next Search Catalog libraries
            &lt;/li&gt;
            &lt;li&gt;
              grouped and sorted by branch name
            &lt;/li&gt;
          &lt;/ul&gt;

        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;div class="accordion-item"&gt;
      &lt;h2 class="accordion-header" id="panelsStayOpen-headingTwo"&gt;
        &lt;button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo"&gt;

          Report notes:

        &lt;/button&gt;
      &lt;/h2&gt;
      &lt;div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div class="next_report_section"&gt;

            &lt;p&gt;Generates data for:&lt;/p&gt;

            &lt;ul&gt;
              &lt;li&gt;START_I = number of items owned on the first of the month&lt;/li&gt;
              &lt;li&gt;END_I = number of items owned on the last day of the month&lt;/li&gt;
              &lt;li&gt;ITEMS_ADD_L_M = items added last month&lt;/li&gt;
              &lt;li&gt;ITEMS_DEL_L_M = items deleted last month&lt;/li&gt;
              &lt;li&gt;TOTAL_HOLDINGS = number of bibliographic records where at least 1 item was held at this library on the first of the month&lt;/li&gt;
            &lt;/ul&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;div class="accordion-item next_hidden"&gt;
      &lt;h2 class="accordion-header" id="panelsStayOpen-headingThree"&gt;
        &lt;button class="accordion-button collapsed next_report_instructions" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree"&gt;

          Report instructions:

        &lt;/button&gt;
      &lt;/h2&gt;
      &lt;div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div class="next_report_section"&gt;

            &lt;p&gt;
              Instructions go here
            &lt;/p&gt;

          &lt;/div&gt;

          &lt;div class="next_report_section"&gt;

            &lt;p&gt;
              More instructions go here
            &lt;/p&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;div class="accordion-item next_hidden"&gt;

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingFour"&gt;
        &lt;button class="accordion-button collapsed next_report_resources" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false" aria-controls="panelsStayOpen-collapseFour"&gt;

          Report external resources:

        &lt;/button&gt;
      &lt;/h2&gt;

      &lt;div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingFour"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;ul style="list-style-type: none;"&gt;
            &lt;li&gt;


              Explanation of resource if necessary&lt;br&gt;

              &lt;a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen1"&gt;External resource 1&lt;/a&gt;

            &lt;/li&gt;
            &lt;li&gt;


              Explanation of resource if necessary&lt;br&gt;

              &lt;a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen1"&gt;External resource 2&lt;/a&gt;

            &lt;/li&gt;
          &lt;/ul&gt;

        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

  &lt;/div&gt;

  &lt;div class="next_direct_download next_hidden"&gt;

    &lt;a class="next_btn next_indigo next_embiggen1" href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=INSERT_REPORT_NUMBER_HERE"&gt;Download this report as a csv file &lt;i class="bi bi-download"&gt;&lt;/i&gt;&lt;/a&gt;

  &lt;/div&gt;

  &lt;div class="next_hidden"&gt;

    &lt;p&gt;

      #monthly 
      #statistics 
      #monthly_statistics
      #overview 
      #monthly_overview

    &lt;/p&gt;

  &lt;/div&gt;
&lt;/div&gt;

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
      Count(&ast;) AS count 
    FROM items 
    WHERE items.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(&ast;) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
      AND deleteditems.timestamp &gt;= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) START_ITEMS ON branches.branchcode = START_ITEMS.homebranch 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(&ast;) AS count 
    FROM items 
    WHERE items.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(&ast;) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
      AND deleteditems.timestamp &gt;= AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) END_ITEMS ON branches.branchcode = END_ITEMS.homebranch 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(&ast;) AS count 
    FROM items 
    WHERE Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(&ast;) AS count 
    FROM deleteditems 
    WHERE Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY deleteditems.homebranch 
  ) ITEMS_ADDED ON branches.branchcode = ITEMS_ADDED.homebranch 
  LEFT JOIN ( 
    SELECT 
      deleteditems.homebranch, 
      Count(&ast;) AS count 
    FROM deleteditems 
    WHERE Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY deleteditems.homebranch 
  ) ITEMS_DELETED ON branches.branchcode = ITEMS_DELETED.homebranch 
  LEFT JOIN ( 
    SELECT items.homebranch, 
      Count(DISTINCT items.biblionumber) AS count 
    FROM items 
    WHERE items.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(DISTINCT deleteditems.biblionumber) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
      AND deleteditems.timestamp &gt;= AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) TOTAL_HOLDINGS ON branches.branchcode = TOTAL_HOLDINGS.homebranch 
GROUP BY branches.branchname 
ORDER BY IF (BRANCH = 'BRANCH', ' AAAAA', BRANCH) 


























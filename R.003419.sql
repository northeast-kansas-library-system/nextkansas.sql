/*
R.003419

----------

Name: 0010 - 2024_99_a_cy monthly_statistics 
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 16:59:13
Modified on: 2025-04-03 18:49:49
Date last run: 2026-01-07 09:56:19

----------

Public: 0
Expiry: 300

----------

&lt;div class="next_report_info next_noprint"&gt;

  &lt;div class="accordion accordion-flush"&gt;

    &lt;div id="report-function" class="accordion-item"&gt;

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingOne"&gt;

        &lt;button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne"&gt;

            Report function:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;p&gt;Monthly overview - circulation statistics&lt;/p&gt; 

          &lt;ul&gt;&lt;li&gt;Shows circulation and renewal counts for the previous calendar month&lt;/li&gt; 
            &lt;li&gt;At all Next Search Catalog libraries&lt;/li&gt; 
            &lt;li&gt;grouped and sorted by branch name&lt;/li&gt; 
            &lt;/ul&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

    &lt;div id="report-notes" class="accordion-item"&gt;

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
  &lt;li&gt;CHECKOUT_RENEW_LM = all items checked out or renewed at this library last month&lt;/li&gt; 
  &lt;li&gt;CHECKOUT_LM = all items checked out at this library last month&lt;/li&gt; 
  &lt;li&gt;RENEW_LM = all items renewed at this library last month&lt;/li&gt; 
  &lt;li&gt;RETURN_LM = all items returned at this library last month&lt;/li&gt; 
  &lt;li&gt;CR_ADULT_LM includes items with these shelving locations:&lt;/li&gt; 
  &lt;ul&gt; 
    &lt;li&gt;Adult&lt;/li&gt; 
    &lt;li&gt;~Display - BALDWIN - Adult&lt;/li&gt; 
    &lt;li&gt;~Display - LEAVENWRTH - Adult&lt;/li&gt; 
    &lt;li&gt;~Display - PAOLA - Adult&lt;/li&gt; 
    &lt;li&gt;Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Adult" locations&lt;/li&gt; 
  &lt;/ul&gt; 
  &lt;li&gt;CR_YOUTH_LM includes items with these shelving locations:&lt;/li&gt; 
  &lt;ul&gt; 
    &lt;li&gt;Young adult&lt;/li&gt; 
    &lt;li&gt;~Display - BALDWIN - Young Adult&lt;/li&gt; 
    &lt;li&gt;~Display - LEAVENWRTH - Young adult&lt;/li&gt; 
    &lt;li&gt;~Display - PAOLA - Young adult&lt;/li&gt; 
    &lt;li&gt;Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations&lt;/li&gt; 
    &lt;li&gt;Childrens&lt;/li&gt; 
    &lt;li&gt;~Display - BALDWIN - Childrens&lt;/li&gt; 
    &lt;li&gt;~Display - LEAVENWRTH - Children's&lt;/li&gt; 
    &lt;li&gt;~Display - PAOLA - Children's&lt;/li&gt; 
    &lt;li&gt;Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations&lt;/li&gt; 
    &lt;li&gt;Cataloging&lt;/li&gt; 
    &lt;li&gt;Processing Center&lt;/li&gt; 
    &lt;li&gt;Any other situation where the recorded shelving location is "Recently returned" but the item's permanent location is ambiguous&lt;/li&gt; 
    &lt;li&gt;Any items where the recorded shelving location is blank or unknown&lt;/li&gt; 
  &lt;/ul&gt; 
&lt;/ul&gt;

          &lt;/div&gt;

          &lt;div class="next_report_section"&gt;

            &lt;p class="updated"&gt;SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."  If the shelving location is completely ambiguous, the circulation is counted as a "Youth" circulation in the CR_YOUTH_LM column.&lt;/p&gt; 

          &lt;/div&gt;

          &lt;div class="next_report_section"&gt;

            &lt;p class="updated"&gt;This report and these notes updated on 2022.03.10&lt;/p&gt; 

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

    &lt;div id="report-instructions" class="accordion-item next_hidden"&gt;

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

    &lt;div id="report-resources" class="accordion-item next_hidden"&gt;

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

  &lt;div id="report-download" class="next_direct_download next_hidden"&gt;

    &lt;a class="next_btn next_indigo next_embiggen1" href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=INSERT_REPORT_NUMBER_HERE"&gt;Download this report as a csv file &lt;i class="bi bi-download"&gt;&lt;/i&gt;&lt;/a&gt;

  &lt;/div&gt;

  &lt;div id="report-tags" class="next_hidden"&gt;

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
  "BRANCH_NAME" AS BRANCH_NAME,
  "CHECKOUT_RENEW_LM" AS CHECKOUT_RENEW_LM,
  "CHECKOUT_LM" AS CHECKOUT_LM,
  "RENEW_LM" AS RENEW_LM,
  "RETURN_LM" AS RETURN_LM,
  "CR_ADULT_LM" AS CR_ADULT_LM,
  "CR_YOUTH_LM" AS CR_YOUTH_LM
UNION  
SELECT 
  branches.branchname AS BRANCH_NAME, 
  Coalesce(CIR_RENEW_LM.count, 0) AS CHECKOUT_RENEW_LM, 
  Coalesce(CKO_LM.count, 0) AS CHECKOUT_LM, 
  Coalesce(RENEW_LM.count, 0) AS RENEW_LM, 
  Coalesce(RETURN_LM.count, 0) AS RETURN_LM, 
  Coalesce(ADULT.count, 0) AS CR_ADULT_LM, 
  Coalesce(YOUTH.count, 0) AS CR_YOUTH_LM 
FROM 
  branches LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(&ast;) AS count 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) CIR_RENEW_LM 
  ON branches.branchcode = CIR_RENEW_LM.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(&ast;) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, 'L_AD'), 
        Coalesce(statistics.location, "L_AD") 
      ) LIKE "%AD%" 
    GROUP BY 
      statistics.branch 
    ) ADULT 
  ON branches.branchcode = ADULT.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(&ast;) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, 'L_AD'), 
        Coalesce(statistics.location, "L_AD") 
      ) NOT LIKE "%AD%" 
    GROUP BY 
      statistics.branch 
    ) YOUTH 
  ON branches.branchcode = YOUTH.branch LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(&ast;) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'issue' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) CKO_LM 
  ON CKO_LM.branch = branches.branchcode LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(&ast;) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'renew' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) RENEW_LM 
  ON RENEW_LM.branch = branches.branchcode 
  LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(&ast;) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.type = 'return' AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) RETURN_LM 
  ON RETURN_LM.branch = branches.branchcode 
GROUP BY 
  BRANCH_NAME 
ORDER BY 
  IF(BRANCH_NAME = "BRANCH_NAME", " BRANCH_NAME", BRANCH_NAME) 


























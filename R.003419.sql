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
Date last run: 2025-10-03 12:42:42

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <div class="accordion accordion-flush">

    <div id="report-function" class="accordion-item">

      <h2 class="accordion-header" id="panelsStayOpen-headingOne">

        <button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">

            Report function:

        </button>

      </h2>

      <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
        <div class="accordion-body">

          <p>Monthly overview - circulation statistics</p> 

          <ul><li>Shows circulation and renewal counts for the previous calendar month</li> 
            <li>At all Next Search Catalog libraries</li> 
            <li>grouped and sorted by branch name</li> 
            </ul>

        </div>
      </div>

    </div>

    <div id="report-notes" class="accordion-item">

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
  <li>CHECKOUT_RENEW_LM = all items checked out or renewed at this library last month</li> 
  <li>CHECKOUT_LM = all items checked out at this library last month</li> 
  <li>RENEW_LM = all items renewed at this library last month</li> 
  <li>RETURN_LM = all items returned at this library last month</li> 
  <li>CR_ADULT_LM includes items with these shelving locations:</li> 
  <ul> 
    <li>Adult</li> 
    <li>~Display - BALDWIN - Adult</li> 
    <li>~Display - LEAVENWRTH - Adult</li> 
    <li>~Display - PAOLA - Adult</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Adult" locations</li> 
  </ul> 
  <li>CR_YOUTH_LM includes items with these shelving locations:</li> 
  <ul> 
    <li>Young adult</li> 
    <li>~Display - BALDWIN - Young Adult</li> 
    <li>~Display - LEAVENWRTH - Young adult</li> 
    <li>~Display - PAOLA - Young adult</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations</li> 
    <li>Childrens</li> 
    <li>~Display - BALDWIN - Childrens</li> 
    <li>~Display - LEAVENWRTH - Children's</li> 
    <li>~Display - PAOLA - Children's</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations</li> 
    <li>Cataloging</li> 
    <li>Processing Center</li> 
    <li>Any other situation where the recorded shelving location is "Recently returned" but the item's permanent location is ambiguous</li> 
    <li>Any items where the recorded shelving location is blank or unknown</li> 
  </ul> 
</ul>

          </div>

          <div class="next_report_section">

            <p class="updated">SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."  If the shelving location is completely ambiguous, the circulation is counted as a "Youth" circulation in the CR_YOUTH_LM column.</p> 

          </div>

          <div class="next_report_section">

            <p class="updated">This report and these notes updated on 2022.03.10</p> 

          </div>

        </div>
      </div>

    </div>

    <div id="report-instructions" class="accordion-item next_hidden">

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

    <div id="report-resources" class="accordion-item next_hidden">

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

  <div id="report-download" class="next_direct_download next_hidden">

    <a class="next_btn next_indigo next_embiggen1" href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=INSERT_REPORT_NUMBER_HERE">Download this report as a csv file <i class="bi bi-download"></i></a>

  </div>

  <div id="report-tags" class="next_hidden">

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
      Count(*) AS count 
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
      Count(*) AS count 
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
      Count(*) AS count 
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
      Count(*) AS count 
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
      Count(*) AS count 
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
      Count(*) AS count 
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


























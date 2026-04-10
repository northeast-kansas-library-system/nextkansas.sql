/*
R.003393

----------

Name: 0030 - 2024_99_c_circulation_item_type monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2020-12-31 17:36:03
Modified on: 2026-02-05 09:06:29
Date last run: 2026-04-01 00:30:01

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <style>
    .report_hidden {
      display: none
    }

    .accordion .accordion-button {
      font-size: 1.1em !important;
      color: #fff !important;
      font-weight: 900
    }

    .next_report_function .accordion-header * {
      background-color: #df6320 !important;
      color: #fff !important
    }

    .next_report_notes .accordion-header * {
      background-color: #dfc220 !important;
      color: #000 !important
    }

    .next_report_instructions .accordion-header * {
      background-color: #3ddf20 !important;
      color: #000 !important
    }

    .next_report_resources .accordion-header * {
      background-color: #1f9bde !important;
      color: #fff !important
    }

    .next_report_training .accordion-header * {
      background-color: #6320df !important;
      color: #fff !important
    }

    .accordion-collapse.collapse * {
      background-color: #e6e6e6;
      color: #000
    }

    .accordion-body h3 {
      font-size: 1.5em !important
    }

    .report_section {
      border: 2px solid #000;
      border-radius: 8px;
      margin: 10px;
      padding: 15px
    }

    .resources_btn,
    .training_btn,
    .direct_download_btn {
      padding: 10px;
      margin: 10px 0 0;
      display: inline-block;
      font-weight: 650;
      line-height: 1.5;
      text-align: center;
      vertical-align: middle;
      white-space: nowrap;
      color: #000
    }

    .resources_btn {
      border: 1px solid #555;
      border-radius: 4px;
      background: #dfc220 !important
    }

    .training_btn {
      border: 1px solid #555;
      border-radius: 4px;
      background: #3ddf20 !important
    }

    .direct_download_btn {
      color: #fff;
      border: 1px solid #555;
      border-radius: 4px;
      background: indigo !important
    }

    .direct_download_btn:hover {
      color: #000000 !important;
      background: #D396FF !important;
    }
  </style>

  <!-- Overview -->

  <div class="next_report_summary">
    <br>

    <p id="report_id"><strong>Report number:</strong> 3393</p>

    <p id="report_name"><strong>Report name:</strong> 0040 - 2024_99_c_circulation_item_type monthly_statistics</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Generates data for monthly statistics</p>

  </div>

  <div class="accordion accordion-flush">

    <!-- Function section -->
    <div id="accordion_3393-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3393Open-headingOne">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3393Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3393Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3393Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3393Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Generates a count of check-outs and renewals by item type</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> previous calendar month</li>

              <li><strong>AT:</strong> all Next Search Catalog libraries</li>

              <li><strong>GROUPED BY:</strong> library name and item type</li>

              <li><strong>SORTED BY:</strong> library name and item type</li>

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
    <div id="accordion_3393-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3393Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3393Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3393Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3393Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3393Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Shelving location:</h4>
            <p>SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless
              the item had a "Recently returned" shelving location.* This report falls back to the items' "Permanent
              shelving location" whenever the statistics data shows that the item's shelving location was "Recently
              returned." If the shelving location is completely ambiguous, the circulation is counted in the
              CKO_RENEW_OTHER column.<br><br>
            <ul>
              <li>CKO_RENEW_ADULT includes items with these shelving locations:</li>
              <ul>
                <li>Adult
                <li>~Display - BALDWIN - Adult
                <li>~Display - LEAVENWRTH - Adult
                <li>~Display - PAOLA - Adult
                <li>Any situation where the location is recorded as "Recently returned" but the item's permanent
                  location is one of these "Adult" locations
              </ul><br>
              <li>CKO_RENEW_YA includes items with these shelving locations:</li>
              <ul>
                <li>Young adult
                <li>~Display - BALDWIN - Young Adult
                <li>~Display - LEAVENWRTH - Young adult
                <li>~Display - PAOLA - Young adult
                <li>Any situation where the location is recorded as "Recently returned" but the item's permanent
                  location is one of these "Young adult" locations
              </ul><br>
              <li>CKO_RENEW_CHILDRENS includes items with these shelving locations:</li>
              <ul>
                <li>Childrens
                <li>~Display - BALDWIN - Childrens
                <li>~Display - LEAVENWRTH - Children's
                <li>~Display - PAOLA - Children's
                <li>Any situation where the location is recorded as "Recently returned" but the item's permanent
                  location is one of these "Childrens" locations
              </ul><br>
              <li>CKO_RENEW_OTHER includes items with these shelving locations:</li>
              <ul>
                <li>Cataloging
                <li>Processing Center
                <li>Any other situation where the recorded shelving location is "Recently returned" but the item's
                  permanent location is ambiguous
                <li>Any items where the recorded shelving location is blank or unknown
              </ul>
            </ul>
            </p>
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
      <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3393"
          class="direct_download_btn">Download directly to a CSV file</a></p>
    </div>

    <!-- Hashtag section -->
    <div class="next_report_hashtags" style="display: none;">
      <p>#monthly</p>
      <p>#statistics</p>
      <p>#item</p>
      <p>#details</p>
      <p>#itype</p>
      <p>#circulation_by_item_details</p>
      <p>#</p>
      <p>#</p>
      <p>#</p>
      <p>#</p>
    </div>

  </div>

----------
*/



SELECT
  'Library Name' AS 'Library Name', 
  'Item type' AS 'Item type', 
  'Checkouts and renewals' AS 'Checkouts and renewals', 
  'Adult checkouts and renewals' AS 'Adult checkouts and renewals', 
  'Young adult checkouts and renewals' AS 'Young adult checkouts and renewals', 
  'Childrens checkouts and renewals' AS 'Childrens checkouts and renewals', 
  'Other checkouts and renewals' AS 'Other checkouts and renewals'
UNION
(SELECT 
  branch_itype.branchname AS 'Library Name', 
  branch_itype.description AS 'Item type', 
  Coalesce(Sum(statistics_all.CKO_REN), 0) AS 'Checkouts and renewals', 
  Coalesce(Sum(statistics_adult.CKO_REN), 0) AS 'Adult checkouts and renewals', 
  Coalesce(Sum(statistics_ya.CKO_REN), 0) AS 'Young adult checkouts and renewals', 
  Coalesce(Sum(statistics_child.CKO_REN), 0) AS 'Childrens checkouts and renewals', 
  Coalesce(Sum(statistics_other.CKO_REN), 0) AS 'Other checkouts and renewals'
FROM 
  ( 
    SELECT 
    branches.branchname, 
      itemtypes.description, 
      branches.branchcode, 
      itemtypes.itemtype 
    FROM branches, 
      itemtypes 
    WHERE branches.branchcode LIKE '%' 
  ) branch_itype 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM statistics 
    WHERE ( 
        statistics.type = 'issue' 
        OR statistics.type = 'renew' 
      ) 
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
    ORDER BY branch, 
      itemtype 
  ) statistics_all ON statistics_all.branch = branch_itype.branchcode 
  AND statistics_all.itemtype = branch_itype.itemtype 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM statistics 
      LEFT JOIN items ON items.itemnumber = statistics.itemnumber 
    WHERE ( 
        statistics.type = 'issue' 
        OR statistics.type = 'renew' 
      ) 
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
      AND ( 
        If( 
          Coalesce(statistics.location, "PROC") = "CART", 
          Coalesce(items.permanent_location, "PROC"), 
          Coalesce(statistics.location, "PROC") 
        ) LIKE "%AD%" 
        OR 
        If( 
          Coalesce(statistics.location, "PROC") = "CART", 
          Coalesce(items.permanent_location, "PROC"), 
          Coalesce(statistics.location, "PROC") 
        ) LIKE "%ADULT%" 
      ) 
    GROUP BY Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_adult 
  ON statistics_adult.branch = branch_itype.branchcode 
  AND statistics_adult.itemtype = branch_itype.itemtype 
  LEFT JOIN 
  ( 
    SELECT Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM statistics 
      LEFT JOIN items ON items.itemnumber = statistics.itemnumber 
    WHERE ( 
        statistics.type = 'issue' 
        OR statistics.type = 'renew' 
      ) 
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) LIKE "%YA%" 
    GROUP BY Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_ya ON statistics_ya.branch = branch_itype.branchcode 
  AND statistics_ya.itemtype = branch_itype.itemtype 
  LEFT JOIN 
  ( 
    SELECT 
    Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM statistics 
      LEFT JOIN items ON items.itemnumber = statistics.itemnumber 
    WHERE ( 
        statistics.type = 'issue' 
        OR statistics.type = 'renew' 
      ) 
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
      AND ( 
        If( 
          Coalesce(statistics.location, "PROC") = "CART", 
          Coalesce(items.permanent_location, "PROC"), 
          Coalesce(statistics.location, "PROC") 
        ) LIKE "%JU%" 
        OR If( 
          Coalesce(statistics.location, "PROC") = "CART", 
          Coalesce(items.permanent_location, "PROC"), 
          Coalesce(statistics.location, "PROC") 
        ) LIKE "%CHILD%" 
      ) 
    GROUP BY Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_child 
  ON statistics_child.branch = branch_itype.branchcode 
  AND statistics_child.itemtype = branch_itype.itemtype 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM statistics 
      LEFT JOIN items ON items.itemnumber = statistics.itemnumber 
    WHERE ( 
        statistics.type = 'issue' 
        OR statistics.type = 'renew' 
      ) 
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%AD%" 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%ADULT%" 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%YA%" 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%JU%" 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%CHILD%" 
    GROUP BY Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_other 
  ON statistics_other.branch = branch_itype.branchcode 
  AND statistics_other.itemtype = branch_itype.itemtype 
GROUP BY branch_itype.branchname, 
  branch_itype.description) 


























/*
R.003128

----------

Name: GHW - Checkout and renewal count by item type and shelving location - previous calendar month
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2018-10-09 17:27:16
Modified on: 2022-02-10 10:15:53
Date last run: 2022-10-03 10:40:05

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Last month's checkouts by library, item type, and location</p>
<ul><li>Shows check-outs and renewals in the previous month by item type and shelving location</li>
<li>at the library you specify</li>
<li>grouped and sorted by checkout branch and shelving location</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Checkouts without a checkout branch location will show as being checked out at NEKLS</p>
<p>Checkouts without an item type will be counted as BOOK</p>
<p></p>
<p>Partially replaces report 1930</p>
<p></p>
<p></p>
<p class="updated">SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."</p>
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3128&reportname=GHW%20-%20Checkout%20and%20renewal%20count%20by%20item%20type%20and%20shelving%20location%20-%20previous%20calendar%20month&sql_params=%25&param_name=Choose%20check-out%20library%7CLBRANCH">Click here to download for all libraries as a csv file</a></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3128&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  branch_itype.branchname,
  branch_itype.description,
  Coalesce(SUM(statistics_all.CKO_REN), 0) AS CKO_REN_ALL,
  Coalesce(SUM(statistics_adult.CKO_REN), 0) AS CKO_REN_ADULT,
  Coalesce(SUM(statistics_ya.CKO_REN), 0) AS CKO_REN_YA,
  Coalesce(SUM(statistics_child.CKO_REN), 0) AS CKO_REN_CHILD,
  Coalesce(SUM(statistics_other.CKO_REN), 0) AS CKO_REN_OTHER
FROM
  (SELECT
      branches.branchname,
      itemtypes.description,
      branches.branchcode,
      itemtypes.itemtype
    FROM
      branches,
      itemtypes
    WHERE
      branches.branchcode Like <<Choose check-out library|ZBRAN>>) branch_itype LEFT JOIN
  (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype
  ) statistics_all ON statistics_all.branch = branch_itype.branchcode AND
      statistics_all.itemtype = branch_itype.itemtype LEFT JOIN
  (
    SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      If(
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC")
      ) LIKE "%ADULT%"
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
  ) statistics_adult ON
      statistics_adult.branch = branch_itype.branchcode AND
      statistics_adult.itemtype = branch_itype.itemtype LEFT JOIN
  (
    SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      If(
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC")
      ) LIKE "%YA%"
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
  ) statistics_ya ON
      statistics_ya.branch = branch_itype.branchcode AND
      statistics_ya.itemtype = branch_itype.itemtype LEFT JOIN
  (
    SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      If(
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC")
      ) LIKE "%CHILD%"
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
  ) statistics_child ON
      statistics_child.branch = branch_itype.branchcode AND
      statistics_child.itemtype = branch_itype.itemtype LEFT JOIN
  (
    SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      If(
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC")
      ) NOT LIKE "%ADULT%" AND
      If(
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC")
      ) NOT LIKE "%YA%" AND 
      If(
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC")
      ) NOT LIKE "%CHILD%"
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
  ) statistics_other ON statistics_other.branch = branch_itype.branchcode AND
      statistics_other.itemtype = branch_itype.itemtype
GROUP BY
  branch_itype.branchname,
  branch_itype.description


























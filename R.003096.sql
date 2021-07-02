/*
R.003096

----------

Name: GHW - Monthly circulation by item type
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2018-07-01 17:17:49
Modified on: 2018-07-02 08:42:40
Date last run: 2021-06-10 17:56:25

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Reports circulation and renewal counts by branchcode, item type, and shelving location</p>
<ul><li>Reports counts for the previous calendar month</li>
<li>at all libraries</li>
<li>grouped by branchcode and item type code</li>
<li>sorted by branchcode and item type description</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3096&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
 branch_types.branchcode,
 Coalesce(branch_types.itypename, "~") AS itype,
 Coalesce(circ_renew.count, 0) AS ALL_CIRC_COUNT,
 Coalesce(adult.count, 0) AS ADULT,
 Coalesce(youngadult.count, 0) AS YOUNG_ADULT,
 Coalesce(children.count, 0) AS CHILDRENS,
 Coalesce(other.count, 0) AS OTHER
FROM
   (SELECT
      branchcodes.authorised_value AS branchcode,
      branchcodes.lib AS branchname,
      itypes.authorised_value AS itype,
      itypes.lib AS itypename
     FROM
      authorised_values itypes,
      authorised_values branchcodes
     WHERE
      itypes.category = 'MRITYPE' AND
      branchcodes.category = 'MRBRAN'
     GROUP BY
      branchcodes.authorised_value,
      branchcodes.lib,
      itypes.authorised_value,
      itypes.lib) branch_types
 LEFT JOIN (SELECT
      Coalesce(st.branch, "~") AS branch,
      Count(*) AS count,
      Coalesce(st.itemtype, "~") AS itemtype
     FROM
      statistics st
     WHERE
      (st.type = 'issue' OR
       st.type = 'renew') AND
      Month(st.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(st.datetime) = Year(Now() - INTERVAL 1 MONTH)
     GROUP BY
      Coalesce(st.itemtype, "~"),
      st.itemtype,
      st.branch) circ_renew ON branch_types.branchcode = circ_renew.branch AND
  branch_types.itype = circ_renew.itemtype
 LEFT JOIN (SELECT
      Coalesce(st.branch, "~") AS branch,
      Coalesce(st.itemtype, "~") AS itemtype,
      count(*) AS count
     FROM
      statistics st
      LEFT JOIN items i ON st.itemnumber = i.itemnumber
     WHERE
      (st.type = 'issue' OR
       st.type = 'renew') AND
      Month(st.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(st.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (i.location = 'ADULT' OR
       i.location = 'LVPLADULT')
     GROUP BY
      Coalesce(st.branch, "~"),
      Coalesce(st.itemtype, "~")
     ORDER BY
      branch,
      itemtype) adult ON branch_types.branchcode = adult.branch AND
  branch_types.itype = adult.itemtype
 LEFT JOIN (SELECT
      Coalesce(st.branch, "~") AS branch,
      Coalesce(st.itemtype, "~") AS itemtype,
      count(*) AS count
     FROM
      statistics st
      LEFT JOIN items i ON st.itemnumber = i.itemnumber
     WHERE
      (st.type = 'issue' OR
       st.type = 'renew') AND
      Month(st.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(st.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (i.location = 'YOUNGADULT' OR
       i.location = 'LVPLYA')
     GROUP BY
      Coalesce(st.branch, "~"),
      Coalesce(st.itemtype, "~")
     ORDER BY
      branch,
      itemtype) youngadult ON branch_types.branchcode = youngadult.branch AND
  branch_types.itype = youngadult.itemtype
 LEFT JOIN (SELECT
      Coalesce(st.branch, "~") AS branch,
      Coalesce(st.itemtype, "~") AS itemtype,
      count(*) AS count
     FROM
      statistics st
      LEFT JOIN items i ON st.itemnumber = i.itemnumber
     WHERE
      (st.type = 'issue' OR
       st.type = 'renew') AND
      Month(st.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(st.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (i.location = 'CHILDRENS' OR
       i.location = 'LVPLCHILD')
     GROUP BY
      Coalesce(st.branch, "~"),
      Coalesce(st.itemtype, "~")
     ORDER BY
      branch,
      itemtype) children ON branch_types.branchcode = children.branch AND
  branch_types.itype = children.itemtype
 LEFT JOIN (SELECT
      Coalesce(st.branch, "~") AS branch,
      Coalesce(st.itemtype, "~") AS itemtype,
      count(*) AS count
     FROM
      statistics st
      LEFT JOIN items i ON st.itemnumber = i.itemnumber
     WHERE
      (st.type = 'issue' OR
       st.type = 'renew') AND
      Month(st.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(st.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (i.location = 'CART' OR
       i.location = 'CATALOGING' OR
       i.location = 'PROC' OR
       i.location IS NULL)
     GROUP BY
      Coalesce(st.branch, "~"),
      Coalesce(st.itemtype, "~")
     ORDER BY
      branch,
      itemtype) other ON branch_types.branchcode = other.branch AND
  branch_types.itype = other.itemtype
GROUP BY
 branch_types.branchcode,
 Coalesce(branch_types.itypename, "~")
ORDER BY
 branch_types.branchcode,
 itype




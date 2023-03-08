/*
R.003552

----------

Name: GHW - Libraries charging late fees
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-08-31 18:42:23
Modified on: 2021-10-07 09:30:55
Date last run: 2023-02-23 13:14:35

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates a list of libraries that still charge late fees</p>
<ul><li>Generates a current list including the item types that are subject to late fees</li>
<li>grouped and sorted by whether the library charges fees on all items or if they charge a late fee on just a few item types</li>
</ul><br />
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3552">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">#late fees; #fines</p>
</div>

----------
*/



SELECT
  Concat("----") AS LIBRARY,
  Concat("Almost all items have late fees") AS ITEM_TYPE
UNION
SELECT
  branches.branchname AS LIBRARY,
  If(Group_Concat(DISTINCT Coalesce(itypess.description, "All")) LIKE "All%",
  "All items with some category and type variations", GROUP_CONCAT(DISTINCT
  itypess.description SEPARATOR " | ")) AS ITEM_TYPE
FROM
  (SELECT
      circulation_rules.branchcode,
      If(circulation_rules.itemtype LIKE "%VID%", "NVIDEO",
      circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'fine' AND
      circulation_rules.rule_value > 0) ruless LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypess ON itypess.itemtype = ruless.itemtype INNER JOIN
  branches ON branches.branchcode = ruless.branchcode
GROUP BY
  branches.branchname
HAVING
  ITEM_TYPE LIKE "All%"
UNION
SELECT
  Concat("----") AS branchcode,
  Concat("----") AS ITEM_TYPE
UNION
SELECT
  Concat("-----") AS branchcode,
  Concat("Some item types have late fees") AS ITEM_TYPE
UNION
SELECT
  branches.branchname,
  If(Group_Concat(DISTINCT Coalesce(itypess.description, "All")) LIKE "All%",
  "All items with some category and type variations", GROUP_CONCAT(DISTINCT
  itypess.description SEPARATOR " | ")) AS ITEM_TYPE
FROM
  (SELECT
      circulation_rules.branchcode,
      If(circulation_rules.itemtype LIKE "%VID%", "NVIDEO",
      circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'fine' AND
      circulation_rules.rule_value > 0) ruless LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypess ON itypess.itemtype = ruless.itemtype INNER JOIN
  branches ON branches.branchcode = ruless.branchcode
GROUP BY
  branches.branchname
HAVING
  ITEM_TYPE NOT LIKE "All%"
LIMIT 500


























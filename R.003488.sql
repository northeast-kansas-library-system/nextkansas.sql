/*
R.003488

----------

Name: GHW - Circulation/fees/request rules 3 - requests and misceleaneous
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-30 09:53:38
Modified on: 2021-03-30 11:18:26
Date last run: 2021-09-15 11:02:07

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Verbose listing of circulation/fees/request rules regarding requests and some miscellaneous rules</p>
<ul><li>Shows the current rules</li>
<li>at the library you specify</li>
<li>grouped and sorted by rule branchcode, borrower category, and item type</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Rules are applied from most specific to least specific and the rules in this report are set to display from most specific to least specific.  The higher a rule is in the results of this report, the higher its priority.</p>
<p></p>
<p>In Next Search Catalog, rules for requests are applied following the rules at the library that owns an item.<br />(Based on the ReservesControlBranch system preference - 2021.03.10)</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3486&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">rules, circulation</p>
</div>

----------
*/

SELECT
  branchess.branchcode,
  categorytypes.BORROWER_CATEGORY,
  categorytypes.ITEM_TYPE,
  reservesallowed.rule_value AS REQUESTS_ALLOWED,
  holds_per_day.rule_value AS REQUESTS_PER_DAY,
  holds_per_record.rule_value AS REQUESTS_PER_BIBLIO,
  If(onshelfholds.rule_value = 1, "Yes", 
    If(onshelfholds.rule_value = 0, "If any unavailable", 
      If(onshelfholds.rule_value = 2, "If all unavailable", 
        onshelfholds.rule_value
      )
    )
  ) AS ON_SHELF_REQUESTS,
  If(opacitemholds.rule_value = "N", "Don't allow", 
    If(opacitemholds.rule_value = "Y", "Allowed", 
      If(opacitemholds.rule_value = "F", "Required", 
        opacitemholds.rule_value
      )
    )
  ) AS OPAC_ITEM_LEVEL_REQUESTS,
  article_requests.rule_value AS ARTICLE_REQUESTS,
  rentaldiscount.rule_value AS RENTAL_DISCOUNT
FROM
  (SELECT
     branches.branchcode,
     branches.branchname
   FROM
     branches
   UNION
   SELECT
     Concat('ALL') AS branchcode,
     Concat('All libraries') AS branchname) branchess INNER JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(categories.description IS NULL, "All borrowers", categories.description) AS BORROWER_CATEGORY,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     If(itemtypes.description IS NULL, "All item types", itemtypes.description) AS ITEM_TYPE
   FROM
     circulation_rules LEFT JOIN
     categories ON circulation_rules.categorycode = categories.categorycode
     LEFT JOIN
     itemtypes ON circulation_rules.itemtype = itemtypes.itemtype
   WHERE
     circulation_rules.rule_name <> '''accountsent"' AND
     circulation_rules.rule_name <> "hold_fulfillment_policy" AND
     circulation_rules.rule_name <> "holdallowed" AND
     circulation_rules.rule_name <> "max_holds" AND
     circulation_rules.rule_name <> "patron_maxissueqty" AND
     circulation_rules.rule_name <> "patron_maxonsiteissueqty" AND
     circulation_rules.rule_name <> "refund" AND
     circulation_rules.rule_name <> "restrictedtype" AND
     circulation_rules.rule_name <> "returnbranch"
   GROUP BY
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode),
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode),
     If(categories.description IS NULL, "All borrowers", categories.description),
     circulation_rules.itemtype,
     itemtypes.description) categorytypes ON categorytypes.branchcode =
      branchess.branchcode LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'reservesallowed') reservesallowed ON
      reservesallowed.branchcode = categorytypes.branchcode AND
      reservesallowed.categorycode = categorytypes.categorycode AND
      reservesallowed.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'holds_per_day') holds_per_day ON
      holds_per_day.branchcode = categorytypes.branchcode AND
      holds_per_day.categorycode = categorytypes.categorycode AND
      holds_per_day.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'holds_per_record') holds_per_record ON
      holds_per_record.branchcode = categorytypes.branchcode AND
      holds_per_record.categorycode = categorytypes.categorycode AND
      holds_per_record.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'onshelfholds') onshelfholds ON
      onshelfholds.branchcode = categorytypes.branchcode AND
      onshelfholds.categorycode = categorytypes.categorycode AND
      onshelfholds.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'opacitemholds') opacitemholds ON
      opacitemholds.branchcode = categorytypes.branchcode AND
      opacitemholds.categorycode = categorytypes.categorycode AND
      opacitemholds.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'article_requests') article_requests ON
      article_requests.branchcode = categorytypes.branchcode AND
      article_requests.categorycode = categorytypes.categorycode AND
      article_requests.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'rentaldiscount') rentaldiscount ON
      rentaldiscount.branchcode = categorytypes.branchcode AND
      rentaldiscount.categorycode = categorytypes.categorycode AND
      rentaldiscount.itemtype = categorytypes.itemtype
WHERE
  (categorytypes.branchcode LIKE <<Choose your library|branches:all>> OR
    categorytypes.branchcode LIKE "ALL")
GROUP BY
  branchess.branchcode,
  categorytypes.BORROWER_CATEGORY,
  categorytypes.ITEM_TYPE
ORDER BY
  IF(branchess.branchcode = "ALL", "ZZZZZ", branchess.branchcode),
  IF(categorytypes.BORROWER_CATEGORY = "All borrowers", "ZZZZZ", categorytypes.BORROWER_CATEGORY),
  IF(categorytypes.ITEM_TYPE = "All item types", "ZZZZZ", categorytypes.ITEM_TYPE)





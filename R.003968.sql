/*
R.003968

----------

Name: GHW - Rules 001a - circulation and renewal rules only
Created by: George Williams

----------

Group: -
     -

Created on: 2026-07-23 17:26:36
Modified on: 2026-07-28 17:46:19
Date last run: 2026-08-10 13:53:56

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

    <p id="report_id"><strong>Report number:</strong> 3968</p>

    <p id="report_name"><strong>Report name:</strong> Rules 001a - circulation and renewal rules only</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Shows circulation and renewal rules</p>

  </div>

  <div class="accordion accordion-flush">

    <!-- Function section -->
    <div id="accordion_3968-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3968Open-headingOne">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3968Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3968Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3968Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3968Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Shows circulation and renewal rules</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> shows rules at the time the report is run</li>

              <li><strong>AT:</strong> at the library you specify</li>

              <li><strong>GROUPED BY:</strong> library, borrower category, and item type</li>

              <li><strong>SORTED BY:</strong> library, borrower category, and item type</li>

              <span style="display: none;">
                <li><strong>CONTAINS LINKS:</strong> </li>
              </span>
            </ul>


            <p>If a library doesn't have an ALL CATEGORIES/ALL ITEM TYPES rule, the ALL LIBRARIES rules will display at
              the bottom of the report.</p>

          </div>

        </div>
      </div>

    </div>

    <!-- Notes section -->
    <div id="accordion_3968-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3968Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3968Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3968Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3968Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3968Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Rule order</h4>
            <p>The rules are applied from most specific to less specific, using the first found in this order:</p>
            <ul>
              <li>same library, same patron category, same item type</li>
              <li>same library, same patron category, all item types</li>
              <li>same library, all patron categories, same item type</li>
              <li>same library, all patron categories, all item types</li>
              <li>default (all libraries), same patron category, same item type</li>
              <li>default (all libraries), same patron category, all item types</li>
              <li>default (all libraries), all patron categories, same item type</li>
              <li>default (all libraries), all patron categories, all item types</li>
            </ul>
            <p>The circulation and fine rules are applied based on the CircControl system preference and the
              HomeOrHoldingBranch system preference which are both set in the system administration module.</p>
          </div>

          <div id="notes_2" class="report_section report_hidden">
            <h4> NOTE_TWO_TITLE </h4>
            <p> NOTE_TWO_CONTENT </p>
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

    <!-- Hashtag section -->
    <div class="next_report_hashtags" style="display: none;">
      <p>#rules</p>
      <p>#circulation</p>
      <p>#renewal</p>
      <p>#</p>
      <p>#</p>
      <p>#</p>
      <p>#</p>
      <p>#</p>
      <p>#</p>
      <p>#has_notes</p>
    </div>

  </div>

----------
*/



SELECT
  branches_categories_itypes.branchname AS 'Library',
  branches_categories_itypes.description AS 'Patron category',
  branches_categories_itypes.description1 AS 'Item type',
  rules_table.maxissueqty AS 'Current checkouts allowed',
  rules_table.maxonsiteissueqty AS 'Current on-site checkouts allowed',
  rules_table.issuelength AS 'Loan period',
  CASE
    WHEN rules_table.daysmode = 0
    THEN 'Default'
    WHEN rules_table.daysmode IS NULL
    THEN 'Default'
    WHEN rules_table.daysmode = ''
    THEN 'Default'
    WHEN rules_table.daysmode = 'Calendar'
    THEN 'Skip'
    WHEN rules_table.daysmode = 'Datedue'
    THEN 'Next open day'
    WHEN rules_table.daysmode = 'Days'
    THEN 'Ignore the calendar'
    WHEN rules_table.daysmode = 'Dayweek'
    THEN 'Same week day'
    ELSE rules_table.daysmode
  END AS 'Days mode',
  rules_table.lengthunit AS 'Unit',
  CASE
    WHEN rules_table.hardduedatecompare = -1
    THEN 'Before'
    WHEN rules_table.hardduedatecompare = 0
    THEN 'After'
    WHEN rules_table.hardduedatecompare = 1
    THEN 'Exactly on'
    ELSE rules_table.hardduedatecompare
  END AS 'Hard due date (comparison)',
  rules_table.hardduedate AS 'Hard due date',
  rules_table.decreaseloanholds AS 'Decreased loan period for high holds (day)',
  rules_table.expire_reserves_charge AS 'Expired hold charge',
  rules_table.renewalsallowed AS 'Renewals allowed (count)',
  rules_table.renewalperiod AS 'Renewal period',
  rules_table.norenewalbefore AS 'No renewal before',
  rules_table.noautorenewalbefore AS 'No automatic renewal before',
  rules_table.auto_renew AS 'Automatic renewal',
  rules_table.no_auto_renewal_after AS 'No automatic renewal after',
  rules_table.no_auto_renewal_after_hard_limit AS 'No automatic renewal after (hard limit)'
FROM
  (SELECT
     branchess.branchcode,
     branchess.branchname,
     categoriess.categorycode,
     categoriess.description,
     itypess.itemtype,
     itypess.description AS description1
   FROM
     (SELECT
        'all' AS branchcode,
        ' All Libraries' AS branchname
      FROM
        branches
      UNION
      SELECT
        branches.branchcode,
        branches.branchname
      FROM
        branches) branchess,
     (SELECT
        'all' AS categorycode,
        ' All categories' AS description
      UNION
      SELECT
        categories.categorycode,
        categories.description
      FROM
        categories) categoriess,
     (SELECT
        'all' AS itemtype,
        ' All item types' AS description
      UNION
      SELECT
        itemtypes.itemtype,
        itemtypes.description
      FROM
        itemtypes) itypess) branches_categories_itypes
  JOIN (SELECT
     Coalesce(circulation_rules.branchcode, 'all') AS branch,
     Coalesce(circulation_rules.categorycode, 'all') AS cat,
     Coalesce(circulation_rules.itemtype, 'all') AS type,
     Max(CASE
       WHEN circulation_rules.rule_name = 'maxissueqty'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS maxissueqty,
     Max(CASE
       WHEN circulation_rules.rule_name = 'maxonsiteissueqty'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS maxonsiteissueqty,
     Max(CASE
       WHEN circulation_rules.rule_name = 'issuelength'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS issuelength,
     Max(CASE
       WHEN circulation_rules.rule_name = 'daysmode'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS daysmode,
     Max(CASE
       WHEN circulation_rules.rule_name = 'lengthunit'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS lengthunit,
     Max(CASE
       WHEN circulation_rules.rule_name = 'hardduedatecompare'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS hardduedatecompare,
     Max(CASE
       WHEN circulation_rules.rule_name = 'hardduedate'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS hardduedate,
     Max(CASE
       WHEN circulation_rules.rule_name = 'decreaseloanholds'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS decreaseloanholds,
     Max(CASE
       WHEN circulation_rules.rule_name = 'fine'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS fine,
     Max(CASE
       WHEN circulation_rules.rule_name = 'chargeperiod'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS chargeperiod,
     Max(CASE
       WHEN circulation_rules.rule_name = 'chargeperiod_charge_at'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS chargeperiod_charge_at,
     Max(CASE
       WHEN circulation_rules.rule_name = 'firstremind'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS firstremind,
     Max(CASE
       WHEN circulation_rules.rule_name = 'overduefinescap'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS overduefinescap,
     Max(CASE
       WHEN circulation_rules.rule_name = 'cap_fine_to_replacement_price'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS cap_fine_to_replacement_price,
     Max(CASE
       WHEN circulation_rules.rule_name = 'expire_reserves_charge'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS expire_reserves_charge,
     Max(CASE
       WHEN circulation_rules.rule_name = 'finedays'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS finedays,
     Max(CASE
       WHEN circulation_rules.rule_name = 'maxsuspensiondays'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS maxsuspensiondays,
     Max(CASE
       WHEN circulation_rules.rule_name = 'suspension_chargeperiod'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS suspension_chargeperiod,
     Max(CASE
       WHEN circulation_rules.rule_name = 'renewalsallowed'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS renewalsallowed,
     Max(CASE
       WHEN circulation_rules.rule_name = 'renewalperiod'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS renewalperiod,
     Max(CASE
       WHEN circulation_rules.rule_name = 'norenewalbefore'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS norenewalbefore,
     Max(CASE
       WHEN circulation_rules.rule_name = 'noautorenewalbefore'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS noautorenewalbefore,
     Max(CASE
       WHEN circulation_rules.rule_name = 'auto_renew'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS auto_renew,
     Max(CASE
       WHEN circulation_rules.rule_name = 'no_auto_renewal_after'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS no_auto_renewal_after,
     Max(CASE
       WHEN circulation_rules.rule_name = 'no_auto_renewal_after_hard_limit'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS no_auto_renewal_after_hard_limit,
     Max(CASE
       WHEN circulation_rules.rule_name = 'reservesallowed'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS reservesallowed,
     Max(CASE
       WHEN circulation_rules.rule_name = 'holds_per_day'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS holds_per_day,
     Max(CASE
       WHEN circulation_rules.rule_name = 'holds_per_record'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS holds_per_record,
     Max(CASE
       WHEN circulation_rules.rule_name = 'onshelfholds'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS onshelfholds,
     Max(CASE
       WHEN circulation_rules.rule_name = 'opacitemholds'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS opacitemholds,
     Max(CASE
       WHEN circulation_rules.rule_name = 'holds_pickup_period'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS holds_pickup_period,
     Max(CASE
       WHEN circulation_rules.rule_name = 'article_requests'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS article_requests,
     Max(CASE
       WHEN circulation_rules.rule_name = 'rentaldiscount'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS rentaldiscount
   FROM
     circulation_rules
   GROUP BY
     Coalesce(circulation_rules.branchcode, 'all'),
     Coalesce(circulation_rules.categorycode, 'all'),
     Coalesce(circulation_rules.itemtype, 'all')
   HAVING
     lengthunit IS NOT NULL) rules_table
    ON rules_table.branch = branches_categories_itypes.branchcode AND
      rules_table.cat = branches_categories_itypes.categorycode AND
      rules_table.type = branches_categories_itypes.itemtype,
  (SELECT
     Coalesce(Max(CASE
       WHEN circulation_rules.rule_name = 'maxissueqty' AND Concat_Ws('_', circulation_rules.branchcode,
           Coalesce(circulation_rules.categorycode, 'all'), Coalesce(circulation_rules.itemtype, 'all')) =
           Concat(<<Your library|branches:all>>, '_all_all')
       THEN '1'
     END), 0) AS All_Rule
   FROM
     circulation_rules) rule_check
WHERE
  (branches_categories_itypes.branchcode LIKE  <<Your library|branches:all>> OR
    branches_categories_itypes.branchcode LIKE CASE
      WHEN rule_check.All_Rule = 0
      THEN 'all'
      ELSE 'x'
    END)
ORDER BY
  If(branches_categories_itypes.branchname = ' All libraries', 'Z', branches_categories_itypes.branchname),
  If(branches_categories_itypes.description = ' All categories', 'Z', branches_categories_itypes.description),
  If(branches_categories_itypes.description1 = ' All item types', 'Z', branches_categories_itypes.description1)


























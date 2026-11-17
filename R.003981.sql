/*
R.003981

----------

Name: GHW - Rules 001 - Default rules report - Full table
Created by: George Williams

----------

Group: Rules
     -

Created on: 2026-08-16 17:36:11
Modified on: 2026-08-26 11:26:12
Date last run: 2026-11-05 23:19:40

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

<style>

  .report_hidden {
    display:  none
  }

  .accordion .accordion-button {
    font-size:  1.1em !important;
    color:  #fff !important;
    font-weight:  900
  }

  .next_report_function .accordion-header * {
    background-color:  #df6320 !important;
    color:  #fff !important
  }

  .next_report_notes .accordion-header * {
    background-color:  #dfc220 !important;
    color:  #000 !important
  }

  .next_report_instructions .accordion-header * {
    background-color:  #3ddf20 !important;
    color:  #000 !important
  }

  .next_report_resources .accordion-header * {
    background-color:  #1f9bde !important;
    color:  #fff !important
  }

  .next_report_training .accordion-header * {
    background-color:  #6320df !important;
    color:  #fff !important
  }

  .accordion-collapse.collapse * {
    background-color:  #e6e6e6;
    color:  #000
  }

  .accordion-body h3 {
    font-size:  1.5em !important
  }

  .report_section {
    border:  2px solid #000;
    border-radius:  8px;
    margin:  10px;
    padding:  15px
  }

  .resources_btn, .training_btn, .direct_download_btn {
    padding:  10px;
    margin:  10px 0 0;
    display:  inline-block;
    font-weight:  650;
    line-height:  1.5;
    text-align:  center;
    vertical-align:  middle;
    white-space:  nowrap;
    color:  #000
  }

  .resources_btn {
    border:  1px solid #555;
    border-radius:  4px;
    background:  #dfc220 !important
  }

  .training_btn {
    border:  1px solid #555;
    border-radius:  4px;
    background:  #3ddf20 !important
  }

  .direct_download_btn {
    color:  #fff;
    border:  1px solid #555;
    border-radius:  4px;
    background:  indigo !important
  }
  .direct_download_btn:hover {
    color: #000000 !important;
    background: #D396FF !important;
  }

</style>

<!-- Overview -->

  <div class="next_report_summary">
    <br>

    <p id="report_id"><strong>Report number:</strong> 3981</p>

    <p id="report_name"><strong>Report name:</strong> Rules 001 - Default rules report - Full table</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Reproduces the "Default circulation rules table" as of Koha 25.11</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3981-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3981Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3981Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3981Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3981Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3981Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Shows all values for the "Default circulation rules table"</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> shows results at the time the report is run</li>

              <li><strong>AT:</strong> shows results for the library you specify</li>

            <span style="display: none;">
              <li><strong>GROUPED BY:</strong> </li>
            </span>

              <li><strong>SORTED BY:</strong> the order in which the rules are applied</li>

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
    <div id="accordion_3981-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3981Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3981Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3981Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3981Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3981Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Rationale</h4>
            <p>Viewing a libraries circulation rules in Koha means that the staff member must also have the ability to edit rules.  In some situations staff members who don't have access to edit rules need to know what the rules are, so this report allows them to view rules without being able to edit them.<br><br>It is possible in the future that the Koha community will add a permission to allow staff "view only" permission for circulation rules.  If that happens, this report will become superfluous.</p>
          </div>

          <div id="notes_2" class="report_section">
            <h4>Rules are confusing</h4>
            <p>One of the reasons that most staff don't have the ability to edit rules is because they are confusing.  If you don't understand the data presented here, please ask NEKLS staff and we will be happy to explain them - at least the ones that we understand ourselves.</p>
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

<!-- Resources section -->
    <div id="accordion_3981-4" class="accordion-item next_report_resources  " style="">

      <h2 class="accordion-header" id="panelsStay_3981Open-headingFour">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3981Open-collapseFour" aria-expanded="false"
          aria-controls="panelsStay_3981Open-collapseFour">
          Resources:
        </button>
      </h2>

      <div id="panelsStay_3981Open-collapseFour" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3981Open-headingFour">

        <div class="accordion-body">

          <div id="resources_1" class="row report_section">
            <div class="col col-md-2 align-self-center">
              <a href="https://koha-community.org/manual/latest/en/html/administration.html#circulation-and-fine-rules" target="_blank" class="resources_btn">Koha manual</a>
            </div>            <div class="col col-md-8 align-self-center">
              <p>This is a link to the "Circulation and fine rules" section of the Koha manual.</p>
            </div>          </div>


          <div id="resources_2" class="row report_section">
            <div class="col col-md-2 align-self-center">
              <a href="https://wiki.koha-community.org/wiki/SQL_Reports_System_Administration#Default_rules_report_-_full_table" target="_blank" class="resources_btn">Koha SQL library</a>
            </div>            <div class="col col-md-8 align-self-center">
              <p>This report is available on the Koha Wiki</p>
            </div>          </div>


          <div id="resources_3" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_THREE_URL " target="_blank" class="resources_btn"> RESOURCE_THREE_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_THREE_NOTE </p>
            </div>          </div>


          <div id="resources_4" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_FOUR_URL " target="_blank" class="resources_btn"> RESOURCE_FOUR_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_FOUR_NOTE </p>
            </div>          </div>


          <div id="resources_5" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_FIVE_URL " target="_blank" class="resources_btn"> RESOURCE_FIVE_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_FIVE_NOTE </p>
            </div>          </div>

        </div>

      </div>

    </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#rules</p>
    <p>#workaround</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
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
    WHEN rules_table.daysmode = 0 THEN 'Default'
    WHEN rules_table.daysmode IS NULL THEN 'Default'
    WHEN rules_table.daysmode = '' THEN 'Default'
    WHEN rules_table.daysmode = 'Calendar' THEN 'Skip'
    WHEN rules_table.daysmode = 'Datedue' THEN 'Next open day'
    WHEN rules_table.daysmode = 'Days' THEN 'Ignore the calendar'
    WHEN rules_table.daysmode = 'Dayweek' THEN 'Same week day'
    ELSE rules_table.daysmode
  END AS 'Days mode',
  rules_table.lengthunit AS 'Unit',
  CASE
    WHEN rules_table.hardduedatecompare = -1 THEN 'Before'
    WHEN rules_table.hardduedatecompare = 0 THEN 'After'
    WHEN rules_table.hardduedatecompare = 1 THEN 'Exactly on'
    ELSE rules_table.hardduedatecompare
  END AS 'Hard due date (comparison)',
  rules_table.hardduedate AS 'Hard due date',
  rules_table.decreaseloanholds AS 'Decreased loan period for high holds (day)',
  rules_table.fine AS 'Fine amount',
  rules_table.chargeperiod AS 'Fine charging interval',
  CASE
    WHEN rules_table.chargeperiod_charge_at = 0 THEN 'End of interval'
    WHEN rules_table.chargeperiod_charge_at = 1 THEN 'Start of interval'
    ELSE rules_table.chargeperiod_charge_at
  END AS 'When to charge',
  rules_table.firstremind AS 'Fine/suspension grace period',
  rules_table.overduefinescap AS 'Overdue fines cap (amount)',
  rules_table.cap_fine_to_replacement_price AS 'Cap fine at replacement price',
  rules_table.expire_reserves_charge AS 'Expired hold charge',
  rules_table.finedays AS 'Suspension in days (day)',
  rules_table.maxsuspensiondays AS 'Max. suspension duration (day)',
  rules_table.suspension_chargeperiod AS 'Suspension charging interval',
  rules_table.renewalsallowed AS 'Renewals allowed (count)',
  rules_table.unseen_renewals_allowed AS 'Unseen renewals allowed (count)',
  rules_table.renewalperiod AS 'Renewal period',
  rules_table.norenewalbefore AS 'No renewal before',
  rules_table.noautorenewalbefore AS 'No automatic renewal before',
  rules_table.auto_renew AS 'Automatic renewal',
  rules_table.no_auto_renewal_after AS 'No automatic renewal after',
  rules_table.no_auto_renewal_after_hard_limit AS 'No automatic renewal after (hard limit)',
  rules_table.reservesallowed AS 'Holds allowed (total)',
  rules_table.holds_per_day AS 'Holds allowed (daily)',
  rules_table.holds_per_record AS 'Holds per record (count)',
  rules_table.onshelfholds AS 'On shelf holds allowed',
  CASE
    WHEN rules_table.opacitemholds = 'N' THEN "Don't allow"
    WHEN rules_table.opacitemholds = 'Y' THEN 'Allow'
    WHEN rules_table.opacitemholds = 'F' THEN 'Force'
    ELSE rules_table.opacitemholds
  END AS 'OPAC item level holds',
  rules_table.holds_pickup_period AS 'Holds pickup period (day)',
  rules_table.hold_fee AS 'Hold fee',
  rules_table.article_requests AS 'Article requests',
  rules_table.rentaldiscount AS 'Rental discount (%)',
  rules_table.recalls_allowed AS 'Recalls allowed (total)',
  rules_table.recalls_per_record AS 'Recalls per record (count)',
  CASE
    WHEN rules_table.on_shelf_recalls = 'any' THEN "If any unavailable"
    WHEN rules_table.on_shelf_recalls = 'all' THEN 'If all unavailable'
    ELSE rules_table.on_shelf_recalls
  END AS 'On shelf recalls allowed',
  rules_table.recall_due_date_interval AS 'Recall due date interval (day)',
  rules_table.recall_overdue_fine AS 'Recall overdue fine amount',
  rules_table.recall_shelf_time AS 'Recall pickup period (day)'
FROM
  (
    SELECT
      branchess.branchcode,
      branchess.branchname,
      categoriess.categorycode,
      categoriess.description,
      itypess.itemtype,
      itypess.description AS description1
    FROM
      (
        SELECT
          'all' AS branchcode,
          ' All Libraries' AS branchname
        FROM
          branches
        UNION
        SELECT
          branches.branchcode,
          branches.branchname
        FROM
          branches
      ) branchess,
      (
        SELECT
          'all' AS categorycode,
          ' All categories' AS description
        UNION
        SELECT
          categories.categorycode,
          categories.description
        FROM
          categories
      ) categoriess,
      (
        SELECT
          'all' AS itemtype,
          ' All item types' AS description
        UNION
        SELECT
          itemtypes.itemtype,
          itemtypes.description
        FROM
          itemtypes
      ) itypess
  ) branches_categories_itypes
  JOIN (
    SELECT
      Coalesce(circulation_rules.branchcode, 'all') AS branch,
      Coalesce(circulation_rules.categorycode, 'all') AS cat,
      Coalesce(circulation_rules.itemtype, 'all') AS type,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'maxissueqty' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS maxissueqty,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'maxonsiteissueqty' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS maxonsiteissueqty,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'issuelength' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS issuelength,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'daysmode' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS daysmode,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'lengthunit' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS lengthunit,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'hardduedatecompare' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS hardduedatecompare,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'hardduedate' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS hardduedate,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'decreaseloanholds' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS decreaseloanholds,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'fine' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS fine,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'chargeperiod' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS chargeperiod,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'chargeperiod_charge_at' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS chargeperiod_charge_at,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'firstremind' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS firstremind,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'overduefinescap' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS overduefinescap,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'cap_fine_to_replacement_price' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS cap_fine_to_replacement_price,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'expire_reserves_charge' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS expire_reserves_charge,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'finedays' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS finedays,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'maxsuspensiondays' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS maxsuspensiondays,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'suspension_chargeperiod' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS suspension_chargeperiod,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'renewalsallowed' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS renewalsallowed,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'unseen_renewals_allowed' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS unseen_renewals_allowed,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'renewalperiod' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS renewalperiod,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'norenewalbefore' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS norenewalbefore,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'noautorenewalbefore' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS noautorenewalbefore,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'auto_renew' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS auto_renew,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'no_auto_renewal_after' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS no_auto_renewal_after,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'no_auto_renewal_after_hard_limit' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS no_auto_renewal_after_hard_limit,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'reservesallowed' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS reservesallowed,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'holds_per_day' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS holds_per_day,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'holds_per_record' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS holds_per_record,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'onshelfholds' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS onshelfholds,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'opacitemholds' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS opacitemholds,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'holds_pickup_period' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS holds_pickup_period,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'hold_fee' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS hold_fee,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'article_requests' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS article_requests,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'rentaldiscount' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS rentaldiscount,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'recalls_allowed' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS recalls_allowed,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'recalls_per_record' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS recalls_per_record,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'on_shelf_recalls' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS on_shelf_recalls,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'recall_due_date_interval' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS recall_due_date_interval,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'recall_overdue_fine' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS recall_overdue_fine,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'recall_shelf_time' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS recall_shelf_time
    FROM
      circulation_rules
    GROUP BY
      Coalesce(circulation_rules.branchcode, 'all'),
      Coalesce(circulation_rules.categorycode, 'all'),
      Coalesce(circulation_rules.itemtype, 'all')
    HAVING
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'lengthunit' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) IS NOT NULL
  ) rules_table ON rules_table.branch = branches_categories_itypes.branchcode AND
  rules_table.cat = branches_categories_itypes.categorycode AND
  rules_table.type = branches_categories_itypes.itemtype,
  (
    SELECT
      Coalesce(
        Max(
          CASE
            WHEN circulation_rules.rule_name = 'maxissueqty' AND
            Concat_Ws(
              '_',
              circulation_rules.branchcode,
              Coalesce(circulation_rules.categorycode, 'all'),
              Coalesce(circulation_rules.itemtype, 'all')
            ) = Concat(<<Your library|branches:all>>, '_all_all') THEN '1'
          END
        ),
        0
      ) AS All_Rule
    FROM
      circulation_rules
  ) rule_check
WHERE
  (
    branches_categories_itypes.branchcode LIKE <<Your library|branches:all>> OR
    branches_categories_itypes.branchcode LIKE CASE
      WHEN rule_check.All_Rule = 0 THEN 'all'
      ELSE 'x'
    END
  )
ORDER BY
  If(
    branches_categories_itypes.branchname = ' All libraries',
    'Z',
    branches_categories_itypes.branchname
  ),
  If(
    branches_categories_itypes.description = ' All categories',
    'Z',
    branches_categories_itypes.description
  ),
  If(
    branches_categories_itypes.description1 = ' All item types',
    'Z',
    branches_categories_itypes.description1
  )


























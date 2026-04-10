/*
R.003951

----------

Name: GHW - Rules 008 - Holds and bookings policies by item type
Created by: George Williams

----------

Group: Rules
     -

Created on: 2026-03-24 14:55:42
Modified on: 2026-03-27 14:34:52
Date last run: 2026-03-27 14:04:32

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

    <p id="report_id"><strong>Report number:</strong> 3951</p>

    <p id="report_name"><strong>Report name:</strong> Rules - Holds and bookings policies by item</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Displays Holds and bookings policies by item rules from the circulation and fine rules page.</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3951-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3951Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3951Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3951Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3951Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3951Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Displays Holds and bookings policies by item rules from the circulation and fine rules page</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> Shows current rules</li>

              <li><strong>AT:</strong> at the library you specify</li>

              <li><strong>GROUPED BY:</strong> rule ID</li>

              <li><strong>SORTED BY:</strong> library and item type</li>

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
    <div id="accordion_3951-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3951Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3951Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3951Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3951Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3951Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Default rules</h4>
            <p>If no rule is specified for an item type, the item type follows the default circulation rule for all libraries.
              Re-run this report and select all libraries and all item types, then scroll to the bottom of the results to see the
              defaults.<br><br>If no default is set for "All libraries" then the rules followed are:</p>
            <ul>
              <li>Hold policy = From any library</li>
              <li>Hold and booking pickup library match = any library </li>
              <li>Booking pre-processing (days) = 0</li>
              <li>Booking post-processing (days) = 0</li>
              <li>Return policy = Item returns home</li>
            </ul>
          </div>

          <div id="notes_2" class="report_section">
            <h4>Changes to rules</h4>
            <p>Member libraries are not allowed to change their own rules.<br></p>
            <p>This is not because we don't trust member libraries.  It is because giving a member library access to their own rules also give them access to everyone else's rules and it is very easy to accidentally modify, or delete rules belonging to other libraries.</p>
          </div>

          <div id="notes_3" class="report_section">
            <h4>Heirarchy</h4>
            <p>Rules are shown for the library you specify plus "All libraries" to show you if there are any system wide rules that apply at your library.</p>
            <p>This is because rules are applied from most specific rule to least specific rule.  Therefore, the rules closest to the top of this list will be applied before the rules at the bottom.</p>
            <p>For example, in this list:</p>
            <ol>
              <li>Atchison Public Library / Special collections (local requests only) / From home library / item's home library</li>
              <li>Atchison Public Library / All item types / From any library / any library</li>
              <li>All libraries / Special collections (local requests only) / From local hold group / item's hold group </li>
              <li>All libraries / All item types / From any library / any library</li>
            </ol>
            <p>If someone tries to place a request on a copy of a Special collections (local requests only) item owned by ATCHISON, Rule #1 will apply because it is higher up the list than rule #2 and #3.  Rule #2 will apply to any items owned by ATCHISON that don't have a specific rule for their item type.  Rule #3 will only apply at libraries where for that specific item type is not set and no "All item types" rule is set for that specific library.</p>
            <p>If no rules exist, the "All libraries / All item types" rule applies.</p>
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
    <p>#hold</p>
    <p>#policy</p>
    <p>#smart-rules</p>
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
  branch_itype.branchname AS 'Library',
  branch_itype.description AS 'Item type',
  holdallowed.rule_value AS 'Hold policy',
  hold_fulfillment_policy.rule_value AS 'Hold and booking pickup library match',
  bookings_lead_period.rule_value AS 'Booking pre-processing (days)',
  bookings_trail_period.rule_value AS 'Booking post-processing (days)',
  returnbranch.rule_value AS 'Return policy'
FROM
  (
    SELECT
      *
    FROM
      (
        SELECT
          ' All libraries' AS branchname,
          '--' AS branchcode
        UNION
        SELECT
          branches.branchname,
          branches.branchcode
        FROM
          branches
      ) branchess,
      (
        SELECT
          ' All item types' AS description,
          '---' AS itype
        UNION
        SELECT
          itemtypes.description,
          itemtypes.itemtype
        FROM
          itemtypes
      ) itypess
  ) branch_itype
  LEFT JOIN (
    SELECT
      Coalesce(circulation_rules.branchcode, '--') AS branchcode,
      Coalesce(circulation_rules.itemtype, '---') AS itemtype,
      circulation_rules.rule_name,
      CASE
        WHEN circulation_rules.rule_value = 'from_any_library' THEN 'From any library'
        WHEN circulation_rules.rule_value = 'from_local_hold_group' THEN 'From local hold group'
        WHEN circulation_rules.rule_value = 'from_home_library' THEN 'From home library'
        WHEN circulation_rules.rule_value = 'not_allowed' THEN 'No holds allowed'
        ELSE '-'
      END AS rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'holdallowed'
    GROUP BY
      circulation_rules.id
    ORDER BY
      branchcode,
      itemtype
  ) holdallowed ON holdallowed.branchcode = branch_itype.branchcode AND
  holdallowed.itemtype = branch_itype.itype
  LEFT JOIN (
    SELECT
      Coalesce(circulation_rules.branchcode, '--') AS branchcode,
      Coalesce(circulation_rules.itemtype, '---') AS itemtype,
      circulation_rules.rule_name,
      CASE
        WHEN circulation_rules.rule_value = "any" THEN "any library"
        WHEN circulation_rules.rule_value = "holdgroup" THEN "item's hold group"
        WHEN circulation_rules.rule_value = "patrongroup" THEN "patron's hold group"
        WHEN circulation_rules.rule_value = "homebranch" THEN "item's home library"
        WHEN circulation_rules.rule_value = "holdingbranch" THEN "item's holding library"
        ELSE "-"
      END AS rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'hold_fulfillment_policy'
    GROUP BY
      circulation_rules.id
  ) hold_fulfillment_policy ON hold_fulfillment_policy.branchcode = branch_itype.branchcode AND
  hold_fulfillment_policy.itemtype = branch_itype.itype
  LEFT JOIN (
    SELECT
      Coalesce(circulation_rules.branchcode, '--') AS branchcode,
      Coalesce(circulation_rules.itemtype, '---') AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'bookings_lead_period'
    GROUP BY
      circulation_rules.id
  ) bookings_lead_period ON bookings_lead_period.branchcode = branch_itype.branchcode AND
  bookings_lead_period.itemtype = branch_itype.itype
  LEFT JOIN (
    SELECT
      Coalesce(circulation_rules.branchcode, '--') AS branchcode,
      Coalesce(circulation_rules.itemtype, '---') AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'bookings_trail_period'
    GROUP BY
      circulation_rules.id
  ) bookings_trail_period ON bookings_trail_period.branchcode = branch_itype.branchcode AND
  bookings_trail_period.itemtype = branch_itype.itype
  LEFT JOIN (
    SELECT
      Coalesce(circulation_rules.branchcode, '--') AS branchcode,
      Coalesce(circulation_rules.itemtype, '---') AS itemtype,
      circulation_rules.rule_name,
      CASE
        WHEN circulation_rules.rule_value = "homebranch" THEN "Item returns home"
        WHEN circulation_rules.rule_value = "holdingbranch" THEN "Item returns to issuing library"
        WHEN circulation_rules.rule_value = "noreturn" THEN "Item floats"
        WHEN circulation_rules.rule_value = "returnbylibrarygroup" THEN "Item floats by library group"
        ELSE "-"
      END AS rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'returnbranch'
    GROUP BY
      circulation_rules.id
  ) returnbranch ON returnbranch.branchcode = branch_itype.branchcode AND
  returnbranch.itemtype = branch_itype.itype
WHERE
  (holdallowed.rule_value NOT LIKE '' AND
  branch_itype.branchcode LIKE <<Choose your library|branches:all>> AND
  branch_itype.itype LIKE <<Choose an item type|itemtypes:all>>) OR 
  (holdallowed.rule_value NOT LIKE '' AND
  branch_itype.branchcode LIKE '--')
ORDER BY
  If(
    branch_itype.branchname = ' All libraries',
    'zzzzz',
    branch_itype.branchname
  ),
  If(
    branch_itype.description = ' All item types',
    'zzzzz',
    branch_itype.description
  )


























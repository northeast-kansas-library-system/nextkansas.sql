/*
R.003487

----------

Name: GHW - Circulation/fees/request rules 2 - late fees
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-30 09:23:49
Modified on: 2026-01-12 14:21:18
Date last run: 2026-02-19 16:19:52

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <style>

       .page-section .next_report_info {
      font-size: 120% !important;
    }

        .report_hidden {
          display: none;
        }

        .accordion .accordion-button {
          font-size: 1.1em !important;
          color: white !important;
          font-weight: 900;
        }

        .next_report_function .accordion-header * {
          background-color: #DF6320 !important;
          color: #ffffff !important;
        }

        .next_report_notes .accordion-header * {
          background-color: #DFC220 !important;
          color: #000000 !important;
        }

        .next_report_instructions .accordion-header * {
          background-color: #3DDF20 !important;
          color: #000000 !important;
        }

        .next_report_resources .accordion-header * {
          background-color: #1f9bde !important;
          color: #ffffff !important;
        }

        .next_report_training .accordion-header * {
          background-color: #6320DF !important;
          color: #ffffff !important;
        }

        .accordion-collapse.collapse * {
          background-color: #e6e6e6;
          color: #000000;
        }

        .accordion-body h3 {
          font-size: 1.5em !important;
        }

        .report_section {
          border: 2px solid black;
          border-radius: 8px;
          margin: 10px;
          padding: 15px;
        }

        .resources_btn {
          padding: 10px;
          margin: 10px 0px 0px 0px;
          border: 1px solid #555;
          border-radius: 4px;
          display: inline-block;
          font-weight: 650;
          line-height: 1.5;
          text-align: center;
          vertical-align: middle;
          white-space: nowrap;
          background: #DFC220 none !important;
          color: #000000;
          !important;
        }

        .resources_btn:hover {
          background: #F2E6A5 none !important;
          color: #000000;
          !important;
        }

        .training_btn {
          padding: 10px;
          margin: 10px 0px 0px 0px;
          border: 1px solid #555;
          border-radius: 4px;
          display: inline-block;
          font-weight: 650;
          line-height: 1.5;
          text-align: center;
          vertical-align: middle;
          white-space: nowrap;
          background: #3DDF20 none !important;
          color: #000000;
          !important;
        }

        .training_btn:hover {
          background: #B1F2A5 none !important;
          color: #000000;
          !important;
        }

        .direct_download_btn {
          padding: 10px;
          margin: 10px 0px 0px 0px;
          border: 1px solid #555;
          border-radius: 4px;
          display: inline-block;
          font-weight: 650;
          line-height: 1.5;
          text-align: center;
          vertical-align: middle;
          white-space: nowrap;
          background: #C220DF none !important;
          color: #ffffff;
          !important;
        }

        .direct_download_btn:hover {
          background: #E6A5F2 none !important;
          color: #000000;
          !important;
        }

  </style>



<!-- Overview -->
  <div class="next_report_summary">
    <br>

    <p id="report_id"><strong>Report number:</strong> 3487</p>

    <p id="report_name"><strong>Report name:</strong> GHW - Circulation/fees/request rules 2 - late fees</p>

    <p id="report_author"><strong>Report author:</strong> George Williams</p>

    <p id="report_summary"><strong>Report summary:</strong> Verbose listing of circulation/fees/request rules regarding late fees</p>

  </div>

  <div class="accordion accordion-flush">



<!-- Function section -->
    <div id="accordion_3487-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3487Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3487Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3487Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3487Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3487Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Shows circulation rules regarding late fees</p>
            <ul>

              <li>Shows the current rules</li>

              <li>At the library you specify</li>

              <li>Grouped by rule branchcode, borrower category, and item type</li>

              <li>Sorted by rule branchcode, borrower category, and item type</li>

            <span style="display: none;">
              <li></li>            </span>
            </ul>


            <p>Rules are applied from most specific to least specific and the rules in this report are set to display from most specific to least specific. The higher a rule is in the results of this report, the higher its priority. </p>

          </div>

        </div>
      </div>

    </div>



<!-- Notes section -->
    <div id="accordion_REPORTID-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Rule priority</h4>
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
          </div>

          <div id="notes_2" class="report_section">
            <h4>Circulation rule application</h4>
            <p>Rules regarding circulation are applied based on the library where the items are being checked out. If an item is shipped from SENECA to OTTAWA to fill a request, it will follow the check-out and renewal rules at OTTAWA when it is checked out at OTTAWA.</p>
          </div>

          <div id="notes_3" class="report_section">
            <h4>Request rule application</h4>
            <p>Rules regarding requests are applied based on the library that owns the items being requested. If a request is being placed on a bibliographic record that has items at LEAVENWRTH, RICHMOND, and SILVERLAKE, the rules at LEAVENWRTH, RICHMOND, and SILVERLAKE will apply to that request no matter which library is designated as the pickup library.</p>
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




<!-- Instructions section -->
    <div id="accordion_REPORTID-3" class="accordion-item next_report_instructions report_hidden">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingThree">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseThree" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseThree">

          Instructions:

        </button>

      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseThree" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingThree">
        <div class="accordion-body">

          <div id="instructions_1" class="report_section report_hidden">
            <h4> INSTRUCTION_1_TITLE </h4>
            <p> INSTRUCTION_1_CONTENT </p>
          </div>

          <div id="instructions_2" class="report_section report_hidden">
            <h4> INSTRUCTION_TWO_TITLE </h4>
            <p> INSTRUCTION_TWO_CONTENT </p>
          </div>

          <div id="instructions_3" class="report_section report_hidden">
            <h4> INSTRUCTION_THREE_TITLE </h4>
            <p> INSTRUCTION_THREE_CONTENT </p>
          </div>

          <div id="instructions_4" class="report_section report_hidden">
            <h4> INSTRUCTION_FOUR_TITLE </h4>
            <p> INSTRUCTION_FOUR_CONTENT </p>
          </div>

          <div id="instructions_5" class="report_section report_hidden">
            <h4> INSTRUCTION_FIVE_TITLE </h4>
            <p> INSTRUCTION_FIVE_CONTENT </p>
          </div>

        </div>
      </div>

    </div>



<!-- Resources section -->
    <div id="accordion_REPORTID-4" class="accordion-item next_report_resources report_hidden " style="">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFour">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFour" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFour">
          Resources:
        </button>
      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseFour" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFour">

        <div class="accordion-body">

          <div id="resources_1" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_ONE_URL " target="_blank" class="resources_btn"> RESOURCE_ONE_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_ONE_NOTE </p>
            </div>          </div>


          <div id="resources_2" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_TWO_URL " target="_blank" class="resources_btn"> RESOURCE_TWO_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_TWO_NOTE </p>
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


<!-- Training section -->
    <div id="accordion_REPORTID-5" class="accordion-item next_report_training report_hidden">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFive">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFive" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFive">

          Training available

        </button>

      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFive" style="color: white !important;">
        <div class="accordion-body">

          <div class="container text-center">
            <div class="row">


              <div id="training_link" class="col-md-3 report_hidden">
                <p><a href=" TRAINING_LINK_URL " target="_blank" class="training_btn">Online training</a></p>
              </div>


              <div id="training_link" class="col-md-3">
                <p><a href="" target="_blank" class="training_btn">Training handout</a></p>
              </div>

              <div id="training_link" class="col-md-3">
                <p><a href="" target="_blank" class="training_btn">Video training</a></p>
              </div>

            </div>
          </div>
        </div>
      </div>

    </div>

  </div>

<!-- Direct download section -->
  <div class="next_report_direct_download report_hidden">
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3487" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>



<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#administration</p>
    <p>#rules</p>
    <p>#circulation</p>
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



Select
  Coalesce(branches.branchname, 'All libraries') As 'Library',
  Coalesce(categories.description, 'All categories') As 'Patron category',
  Coalesce(itemtypes.description, 'All item types') As 'Item type',
  Max(Case
      When circulation_rules_sq.rule_name = 'note'
      Then circulation_rules_sq.rule_value
      Else Null
  End) As 'Note',
  Max(Case
      When circulation_rules_sq.rule_name = 'fine'
      Then Format(circulation_rules_sq.rule_value, 2)
      Else Null
  End) As 'Fine amount',
  Max(Case
      When circulation_rules_sq.rule_name = 'chargeperiod'
      Then circulation_rules_sq.rule_value
      Else Null
  End) As 'Fine charging interval',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'lengthunit' Then If(
        Coalesce(circulation_rules_sq.rule_value, '') = '',
        'Unlimited',
        circulation_rules_sq.rule_value
      )
      Else Null
    End
  ) As 'Unit',
  Max(Case
      When circulation_rules_sq.rule_name = 'chargeperiod_charge_at'
      Then (Case
              When circulation_rules_sq.rule_value = '0'
              Then 'End of interval'
              When circulation_rules_sq.rule_value = '1'
              Then 'Start of interval'
              Else circulation_rules_sq.rule_value
          End)
      Else ''
  End) As 'When to charge',
  Max(Case
      When circulation_rules_sq.rule_name = 'firstremind'
      Then circulation_rules_sq.rule_value
      Else Null
  End) As 'Fine/suspension grace period',
  If(Max(Case
      When circulation_rules_sq.rule_name = 'cap_fine_to_replacement_price'
      Then If(circulation_rules_sq.rule_value = '1', '1', '')
      Else Null
  End) = 1, 'Cap fine at replacement price', Max(Case
      When circulation_rules_sq.rule_name = 'overduefinescap'
      Then Format(circulation_rules_sq.rule_value, 2)
      Else Null
  End)) As 'Overdue fines cap (amount)'
From
  (Select
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, 'all') As branchcode,
      Coalesce(circulation_rules.categorycode, 'all') As categorycode,
      Coalesce(circulation_rules.itemtype, 'all') As itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name <> 'accountsent' And
      circulation_rules.rule_name <> 'bookings_lead_period' And
      circulation_rules.rule_name <> 'bookings_trail_period' And
      circulation_rules.rule_name <> 'finedays' And
      circulation_rules.rule_name <> 'hold_fulfillment_policy' And
      circulation_rules.rule_name <> 'holdallowed' And
      circulation_rules.rule_name <> 'lostreturn' And
      circulation_rules.rule_name <> 'max_holds' And
      circulation_rules.rule_name <> 'patron_maxissueqty' And
      circulation_rules.rule_name <> 'patron_maxonsiteissueqty' And
      circulation_rules.rule_name <> 'restrictedtype' And
      circulation_rules.rule_name <> 'returnbranch' And
      circulation_rules.rule_name <> 'unseen_renewals_allowed' And
      circulation_rules.rule_name <> 'waiting_hold_cancellation'
    Group By
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, 'all'),
      Coalesce(circulation_rules.categorycode, 'all'),
      Coalesce(circulation_rules.itemtype, 'all'),
      circulation_rules.rule_name,
      circulation_rules.rule_value) circulation_rules_sq Left Join
  branches On branches.branchcode = circulation_rules_sq.branchcode Left Join
  categories On categories.categorycode = circulation_rules_sq.categorycode Left Join
  itemtypes On itemtypes.itemtype = circulation_rules_sq.itemtype
Where
  (
    circulation_rules_sq.branchcode Like <<Choose your library|ZBRAN>> OR
    circulation_rules_sq.branchcode Like 'all'
  )
Group By
  circulation_rules_sq.branchcode,
  circulation_rules_sq.categorycode,
  circulation_rules_sq.itemtype
Order By
  Coalesce(branches.branchname, 'ZZZZZ'),
  Coalesce(categories.description, 'ZZZZZ'),
  Coalesce(itemtypes.description, 'ZZZZZ')


























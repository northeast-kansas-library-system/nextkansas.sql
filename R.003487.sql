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
Date last run: 2026-01-12 14:21:20

----------

Public: 0
Expiry: 300

----------

&lt;div class="next_report_info next_noprint"&gt;

  &lt;style&gt;

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

  &lt;/style&gt;



&lt;!-- Overview --&gt;
  &lt;div class="next_report_summary"&gt;
    &lt;br&gt;

    &lt;p id="report_id"&gt;&lt;strong&gt;Report number:&lt;/strong&gt; 3487&lt;/p&gt;

    &lt;p id="report_name"&gt;&lt;strong&gt;Report name:&lt;/strong&gt; GHW - Circulation/fees/request rules 2 - late fees&lt;/p&gt;

    &lt;p id="report_author"&gt;&lt;strong&gt;Report author:&lt;/strong&gt; George Williams&lt;/p&gt;

    &lt;p id="report_summary"&gt;&lt;strong&gt;Report summary:&lt;/strong&gt; Verbose listing of circulation/fees/request rules regarding late fees&lt;/p&gt;

  &lt;/div&gt;

  &lt;div class="accordion accordion-flush"&gt;



&lt;!-- Function section --&gt;
    &lt;div id="accordion_3487-1" class="accordion-item next_report_function"&gt;

      &lt;h2 class="accordion-header" id="panelsStay_3487Open-headingOne" &gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3487Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3487Open-collapseOne"&gt;

          Function:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_3487Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3487Open-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="function_section" class="report_section"&gt;


            &lt;p&gt;Shows circulation rules regarding late fees&lt;/p&gt;
            &lt;ul&gt;

              &lt;li&gt;Shows the current rules&lt;/li&gt;

              &lt;li&gt;At the library you specify&lt;/li&gt;

              &lt;li&gt;Grouped by rule branchcode, borrower category, and item type&lt;/li&gt;

              &lt;li&gt;Sorted by rule branchcode, borrower category, and item type&lt;/li&gt;

            &lt;span style="display: none;"&gt;
              &lt;li&gt;&lt;/li&gt;            &lt;/span&gt;
            &lt;/ul&gt;


            &lt;p&gt;Rules are applied from most specific to least specific and the rules in this report are set to display from most specific to least specific. The higher a rule is in the results of this report, the higher its priority. &lt;/p&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;



&lt;!-- Notes section --&gt;
    &lt;div id="accordion_REPORTID-2" class="accordion-item next_report_notes "&gt;

      &lt;h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingTwo"&gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseTwo"&gt;

          Notes:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_REPORTIDOpen-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingTwo"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="notes_1" class="report_section"&gt;
            &lt;h4&gt;Rule priority&lt;/h4&gt;
            &lt;p&gt;The rules are applied from most specific to less specific, using the first found in this order:&lt;/p&gt;
            &lt;ul&gt;
              &lt;li&gt;same library, same patron category, same item type&lt;/li&gt;
              &lt;li&gt;same library, same patron category, all item types&lt;/li&gt;
              &lt;li&gt;same library, all patron categories, same item type&lt;/li&gt;
              &lt;li&gt;same library, all patron categories, all item types&lt;/li&gt;
              &lt;li&gt;default (all libraries), same patron category, same item type&lt;/li&gt;
              &lt;li&gt;default (all libraries), same patron category, all item types&lt;/li&gt;
              &lt;li&gt;default (all libraries), all patron categories, same item type&lt;/li&gt;
              &lt;li&gt;default (all libraries), all patron categories, all item types&lt;/li&gt;
            &lt;/ul&gt;
          &lt;/div&gt;

          &lt;div id="notes_2" class="report_section"&gt;
            &lt;h4&gt;Circulation rule application&lt;/h4&gt;
            &lt;p&gt;Rules regarding circulation are applied based on the library where the items are being checked out. If an item is shipped from SENECA to OTTAWA to fill a request, it will follow the check-out and renewal rules at OTTAWA when it is checked out at OTTAWA.&lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="notes_3" class="report_section"&gt;
            &lt;h4&gt;Request rule application&lt;/h4&gt;
            &lt;p&gt;Rules regarding requests are applied based on the library that owns the items being requested. If a request is being placed on a bibliographic record that has items at LEAVENWRTH, RICHMOND, and SILVERLAKE, the rules at LEAVENWRTH, RICHMOND, and SILVERLAKE will apply to that request no matter which library is designated as the pickup library.&lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="notes_4" class="report_section report_hidden"&gt;
            &lt;h4&gt; NOTE_FOUR_TITLE &lt;/h4&gt;
            &lt;p&gt; NOTE_FOUR_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="notes_5" class="report_section report_hidden"&gt;
            &lt;h4&gt; NOTE_FIVE_TITLE &lt;/h4&gt;
            &lt;p&gt; NOTE_FIVE_CONTENT &lt;/p&gt;
          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;




&lt;!-- Instructions section --&gt;
    &lt;div id="accordion_REPORTID-3" class="accordion-item next_report_instructions report_hidden"&gt;

      &lt;h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingThree"&gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseThree" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseThree"&gt;

          Instructions:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_REPORTIDOpen-collapseThree" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingThree"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="instructions_1" class="report_section report_hidden"&gt;
            &lt;h4&gt; INSTRUCTION_1_TITLE &lt;/h4&gt;
            &lt;p&gt; INSTRUCTION_1_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="instructions_2" class="report_section report_hidden"&gt;
            &lt;h4&gt; INSTRUCTION_TWO_TITLE &lt;/h4&gt;
            &lt;p&gt; INSTRUCTION_TWO_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="instructions_3" class="report_section report_hidden"&gt;
            &lt;h4&gt; INSTRUCTION_THREE_TITLE &lt;/h4&gt;
            &lt;p&gt; INSTRUCTION_THREE_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="instructions_4" class="report_section report_hidden"&gt;
            &lt;h4&gt; INSTRUCTION_FOUR_TITLE &lt;/h4&gt;
            &lt;p&gt; INSTRUCTION_FOUR_CONTENT &lt;/p&gt;
          &lt;/div&gt;

          &lt;div id="instructions_5" class="report_section report_hidden"&gt;
            &lt;h4&gt; INSTRUCTION_FIVE_TITLE &lt;/h4&gt;
            &lt;p&gt; INSTRUCTION_FIVE_CONTENT &lt;/p&gt;
          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;



&lt;!-- Resources section --&gt;
    &lt;div id="accordion_REPORTID-4" class="accordion-item next_report_resources report_hidden " style=""&gt;

      &lt;h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFour"&gt;
        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFour" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFour"&gt;
          Resources:
        &lt;/button&gt;
      &lt;/h2&gt;

      &lt;div id="panelsStay_REPORTIDOpen-collapseFour" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFour"&gt;

        &lt;div class="accordion-body"&gt;

          &lt;div id="resources_1" class="row report_section report_hidden"&gt;
            &lt;div class="col col-md-2"&gt;
              &lt;p&gt;&lt;a href=" RESOURCE_ONE_URL " target="_blank" class="resources_btn"&gt; RESOURCE_ONE_TITLE &lt;/a&gt;&lt;/p&gt;
            &lt;/div&gt;            &lt;div class="col col-md-8"&gt;
              &lt;p&gt; RESOURCE_ONE_NOTE &lt;/p&gt;
            &lt;/div&gt;          &lt;/div&gt;


          &lt;div id="resources_2" class="row report_section report_hidden"&gt;
            &lt;div class="col col-md-2"&gt;
              &lt;p&gt;&lt;a href=" RESOURCE_TWO_URL " target="_blank" class="resources_btn"&gt; RESOURCE_TWO_TITLE &lt;/a&gt;&lt;/p&gt;
            &lt;/div&gt;            &lt;div class="col col-md-8"&gt;
              &lt;p&gt; RESOURCE_TWO_NOTE &lt;/p&gt;
            &lt;/div&gt;          &lt;/div&gt;


          &lt;div id="resources_3" class="row report_section report_hidden"&gt;
            &lt;div class="col col-md-2"&gt;
              &lt;p&gt;&lt;a href=" RESOURCE_THREE_URL " target="_blank" class="resources_btn"&gt; RESOURCE_THREE_TITLE &lt;/a&gt;&lt;/p&gt;
            &lt;/div&gt;            &lt;div class="col col-md-8"&gt;
              &lt;p&gt; RESOURCE_THREE_NOTE &lt;/p&gt;
            &lt;/div&gt;          &lt;/div&gt;


          &lt;div id="resources_4" class="row report_section report_hidden"&gt;
            &lt;div class="col col-md-2"&gt;
              &lt;p&gt;&lt;a href=" RESOURCE_FOUR_URL " target="_blank" class="resources_btn"&gt; RESOURCE_FOUR_TITLE &lt;/a&gt;&lt;/p&gt;
            &lt;/div&gt;            &lt;div class="col col-md-8"&gt;
              &lt;p&gt; RESOURCE_FOUR_NOTE &lt;/p&gt;
            &lt;/div&gt;          &lt;/div&gt;


          &lt;div id="resources_5" class="row report_section report_hidden"&gt;
            &lt;div class="col col-md-2"&gt;
              &lt;p&gt;&lt;a href=" RESOURCE_FIVE_URL " target="_blank" class="resources_btn"&gt; RESOURCE_FIVE_TITLE &lt;/a&gt;&lt;/p&gt;
            &lt;/div&gt;            &lt;div class="col col-md-8"&gt;
              &lt;p&gt; RESOURCE_FIVE_NOTE &lt;/p&gt;
            &lt;/div&gt;          &lt;/div&gt;

        &lt;/div&gt;

      &lt;/div&gt;

    &lt;/div&gt;


&lt;!-- Training section --&gt;
    &lt;div id="accordion_REPORTID-5" class="accordion-item next_report_training report_hidden"&gt;

      &lt;h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFive"&gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFive" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFive"&gt;

          Training available

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_REPORTIDOpen-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFive" style="color: white !important;"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div class="container text-center"&gt;
            &lt;div class="row"&gt;


              &lt;div id="training_link" class="col-md-3 report_hidden"&gt;
                &lt;p&gt;&lt;a href=" TRAINING_LINK_URL " target="_blank" class="training_btn"&gt;Online training&lt;/a&gt;&lt;/p&gt;
              &lt;/div&gt;


              &lt;div id="training_link" class="col-md-3"&gt;
                &lt;p&gt;&lt;a href="" target="_blank" class="training_btn"&gt;Training handout&lt;/a&gt;&lt;/p&gt;
              &lt;/div&gt;

              &lt;div id="training_link" class="col-md-3"&gt;
                &lt;p&gt;&lt;a href="" target="_blank" class="training_btn"&gt;Video training&lt;/a&gt;&lt;/p&gt;
              &lt;/div&gt;

            &lt;/div&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

  &lt;/div&gt;

&lt;!-- Direct download section --&gt;
  &lt;div class="next_report_direct_download report_hidden"&gt;
    &lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3487" class="direct_download_btn"&gt;Download directly to a CSV file&lt;/a&gt;&lt;/p&gt;
  &lt;/div&gt;



&lt;!-- Hashtag section --&gt;
  &lt;div class="next_report_hashtags" style="display: none;"&gt;
    &lt;p&gt;#administration&lt;/p&gt;
    &lt;p&gt;#rules&lt;/p&gt;
    &lt;p&gt;#circulation&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
    &lt;p&gt;#&lt;/p&gt;
  &lt;/div&gt;

&lt;/div&gt;

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
      circulation_rules.rule_name &lt;&gt; 'accountsent' And
      circulation_rules.rule_name &lt;&gt; 'bookings_lead_period' And
      circulation_rules.rule_name &lt;&gt; 'bookings_trail_period' And
      circulation_rules.rule_name &lt;&gt; 'finedays' And
      circulation_rules.rule_name &lt;&gt; 'hold_fulfillment_policy' And
      circulation_rules.rule_name &lt;&gt; 'holdallowed' And
      circulation_rules.rule_name &lt;&gt; 'lostreturn' And
      circulation_rules.rule_name &lt;&gt; 'max_holds' And
      circulation_rules.rule_name &lt;&gt; 'patron_maxissueqty' And
      circulation_rules.rule_name &lt;&gt; 'patron_maxonsiteissueqty' And
      circulation_rules.rule_name &lt;&gt; 'restrictedtype' And
      circulation_rules.rule_name &lt;&gt; 'returnbranch' And
      circulation_rules.rule_name &lt;&gt; 'unseen_renewals_allowed' And
      circulation_rules.rule_name &lt;&gt; 'waiting_hold_cancellation'
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
    circulation_rules_sq.branchcode Like &lt;&gt; OR
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


























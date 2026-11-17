/*
R.003982

----------

Name: GHW - Rules 001a - Default rules report - Checkouts
Created by: George Williams

----------

Group: Rules
     -

Created on: 2026-08-16 17:38:07
Modified on: 2026-08-27 10:58:07
Date last run: 2026-08-26 13:45:08

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

    <p id="report_id"><strong>Report number:</strong> 3982</p>

    <p id="report_name"><strong>Report name:</strong> Rules 001a - Default rules report - Checkouts</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Reproduces the parts of the "Default circulation rules table" related to checkouts as of Koha 25.11</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3982-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3982Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3982Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3982Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3982Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3982Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Shows the values of the "Default circulation rules table" related to checkouts</p>
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


            <p>This only shows the portion of the rules related to checkout limits and loan periods</p>

          </div>

        </div>
      </div>

    </div>

<!-- Notes section -->
    <div id="accordion_3982-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3982Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3982Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3982Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3982Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3982Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Days mode</h4>
            <p>Days mode tells Koha which calendar to follow - the options are:<br><br><ul><br><li>Default</li><li>Skip closed days</li><li>Next open day</li><li>Ignore the calendar</li><li>Same week day</li></ul><br><br></p>
          </div>

          <div id="notes_2" class="report_section">
            <h4>Unit</h4>
            <p>Some libraries (usually academic and special libraries) have items with hourly loans.  Setting the unit to "Days" means that the loan period is measured in number of days; setting the unit to "Hours" means that the loan period will be measured in hours.<br><br>Next Search Catalog has hourly loans set up for the Highland Community College reserves desk.</p>
          </div>

          <div id="notes_3" class="report_section">
            <h4>Rationale</h4>
            <p>Viewing a library's circulation rules in Koha means that the staff member must also have the ability to edit rules. In some situations staff members who don't have access to edit rules need to know what the rules are, so this report allows them to view rules without being able to edit them.<br><br>It is possible in the future that the Koha community will add a permission to allow staff "view only" permission for circulation rules. If that happens, this report will become superfluous.</p>
          </div>

          <div id="notes_4" class="report_section">
            <h4>Rules are confusing</h4>
            <p>One of the reasons that most staff don't have the ability to edit rules is because they are confusing. If you don't understand the data presented here, please ask NEKLS staff and we will be happy to explain them - at least the ones that we understand ourselves.</p>
          </div>

          <div id="notes_5" class="report_section">
            <h4>Further development</h4>
            <p>Currently there is a bug in Bugzilla that will organize the "Default circulation rules table" to show only selected rules based on a series of buttons at the top of the HTML table.  This report shows you the values that will appear if you click "Checkouts" after patches related to that bug are pushed to Koha.</p>
          </div>

        </div>
      </div>

    </div>

<!-- Resources section -->
    <div id="accordion_3982-4" class="accordion-item next_report_resources  " style="">

      <h2 class="accordion-header" id="panelsStay_3982Open-headingFour">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3982Open-collapseFour" aria-expanded="false"
          aria-controls="panelsStay_3982Open-collapseFour">
          Resources:
        </button>
      </h2>

      <div id="panelsStay_3982Open-collapseFour" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3982Open-headingFour">

        <div class="accordion-body">

          <div id="resources_1" class="row report_section">
            <div class="col col-12 col-sm-12 col-md-12 col-lg-2 align-self-center">
              <a href="https://koha-community.org/manual/latest/en/html/administration.html#circulation-and-fine-rules" target="_blank" class="resources_btn">Koha manual</a>
            </div>            <div class="col col-12 col-sm-12 col-md-10 col-lg-10 align-self-center">
              <p>This is a link to the "Circulation and fine rules" section of the Koha manual.</p>
            </div>          </div>


          <div id="resources_2" class="row report_section">
            <div class="col col-12 col-sm-12 col-md-12 col-lg-2 align-self-center">
              <a href="https://wiki.koha-community.org/wiki/SQL_Reports_System_Administration#Default_rules_report_-_Checkouts" target="_blank" class="resources_btn">Koha SQL library</a>
            </div>            <div class="col col-12 col-sm-12 col-md-10 col-lg-10 align-self-center">
              <p>This report is available on the Koha Wiki</p>
            </div>          </div>


          <div id="resources_3" class="row report_section">
            <div class="col col-12 col-sm-12 col-md-12 col-lg-2 align-self-center">
              <a href="https://bugs.koha-community.org/bugzilla3/show_bug.cgi?id=41439" target="_blank" class="resources_btn">Bug 41439</a>
            </div>            <div class="col col-12 col-sm-12 col-md-10 col-lg-10 align-self-center">
              <p>If this patch is added to Koha, the results of this report will match the "Default circulation rules table" when "Checkouts" is selected.</p>
            </div>          </div>


          <div id="resources_4" class="row report_section report_hidden">
            <div class="col col-12 col-sm-12 col-md-12 col-lg-2">
              <p><a href=" RESOURCE_FOUR_URL " target="_blank" class="resources_btn"> RESOURCE_FOUR_TITLE </a></p>
            </div>            <div class="col col-12 col-sm-12 col-md-10 col-lg-10">
              <p> RESOURCE_FOUR_NOTE </p>
            </div>          </div>


          <div id="resources_5" class="row report_section report_hidden">
            <div class="col col-12 col-sm-12 col-md-12 col-lg-2">
              <p><a href=" RESOURCE_FIVE_URL " target="_blank" class="resources_btn"> RESOURCE_FIVE_TITLE </a></p>
            </div>            <div class="col col-12 col-sm-12 col-md-10 col-lg-10">
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
  rules_table.lengthunit AS 'Unit'
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
      ) AS lengthunit
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


























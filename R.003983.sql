/*
R.003983

----------

Name: GHW - Rules 001b - Default rules report - Due dates
Created by: George Williams

----------

Group: Rules
     -

Created on: 2026-08-16 17:39:56
Modified on: 2026-08-27 10:57:28
Date last run: 2026-08-26 13:54:52

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

    <p id="report_id"><strong>Report number:</strong> 3983</p>

    <p id="report_name"><strong>Report name:</strong> Rules 001b - Default rules report - Due dates</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Reproduces the parts of the "Default circulation rules table" related to due dates as of Koha 25.11</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3983-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3983Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3983Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3983Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3983Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3983Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Shows the values of the "Default circulation rules table" related to due dates</p>
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


            <p>This only shows the portion of the rules related to due dates</p>

          </div>

        </div>
      </div>

    </div>

<!-- Notes section -->
    <div id="accordion_3983-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3983Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3983Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3983Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3983Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3983Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Hard due dates</h4>
            <p>This column contains 2 rules:  hardduedatecompare and hardduedate.<br><br>hardduedate is an actual date<br><br>hardduedatecompare has 3 options:<br><ul><br><li>Before</li><li>After</li><li>Exactly on</li><ul></p><br><br><p>Next Search Catalog uses this feature to set hard due dates for the Prairie Hills School District.  All items checked out at that library during the 2026/2026 school year were due "Before" "2026-05-15."  This meant that if an item checked out one of those libraries and would normally have been due on 2026-05-22, that date was modified so that the item would be due on 2026-05-15.</p><br><br><p>For most Next Search Catalog libraries, the hard due date rules are not set.</p></p>
          </div>

          <div id="notes_2" class="report_section">
            <h4>Decreased loan period for high holds</h4>
            <p>This is another feature we are not using.  Some libraries set shortened due dates for items if there are more than X number of holds per copy.<br><br>For example, if a new book was released that would normally check out for 3 weeks and there is one copy and it has 10 holds on it, we could say that whenever the holds ratio for an item is greater than 3:1, those books only check out for 2 weeks.<br><br>Some libraries use this to speed up the turnover time on high demand items.  You are more likely to see this at libraries where they have long loan periods.</p>
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
            <p>Currently there is a bug in Bugzilla that will organize the "Default circulation rules table" to show only selected rules based on a series of buttons at the top of the HTML table. This report shows you the values that will appear if you click "Due dates" after patches related to that bug are pushed to Koha.</p>
          </div>

        </div>
      </div>

    </div>

<!-- Resources section -->
    <div id="accordion_3983-4" class="accordion-item next_report_resources  " style="">

      <h2 class="accordion-header" id="panelsStay_3983Open-headingFour">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3983Open-collapseFour" aria-expanded="false"
          aria-controls="panelsStay_3983Open-collapseFour">
          Resources:
        </button>
      </h2>

      <div id="panelsStay_3983Open-collapseFour" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3983Open-headingFour">

        <div class="accordion-body">

          <div id="resources_1" class="row report_section">
            <div class="col col-12 col-sm-12 col-md-12 col-lg-2 align-self-center">
              <a href="https://koha-community.org/manual/latest/en/html/administration.html#circulation-and-fine-rules" target="_blank" class="resources_btn">Koha manual  </a>
            </div>            <div class="col col-sm-12 col-md-10 col-lg-10 align-self-center">
              <p>This is a link to the "Circulation and fine rules" section of the Koha manual.</p>
            </div>          </div>


          <div id="resources_2" class="row report_section">
            <div class="col col-12 col-sm-12 col-md-12 col-lg-2 align-self-center">
              <a href="https://wiki.koha-community.org/wiki/SQL_Reports_System_Administration#Default_rules_report_-_Due_dates" target="_blank" class="resources_btn">Koha SQL library</a>
            </div>            <div class="col col-sm-12 col-md-10 col-lg-10 align-self-center">
              <p>This report is available on the Koha Wiki</p>
            </div>          </div>


          <div id="resources_3" class="row report_section">
            <div class="col col-12 col-sm-12 col-md-12 col-lg-2 align-self-center">
              <a href="https://bugs.koha-community.org/bugzilla3/show_bug.cgi?id=41439" target="_blank" class="resources_btn">Bug 41439</a>
            </div>            <div class="col col-sm-12 col-md-10 col-lg-10 align-self-center">
              <p>If this patch is added to Koha, the results of this report will match the "Default circulation rules table" when "Due dates" is selected.</p>
            </div>          </div>


          <div id="resources_4" class="row report_section report_hidden">
            <div class="col col-12 col-sm-12 col-md-12 col-lg-2">
              <p><a href=" RESOURCE_FOUR_URL " target="_blank" class="resources_btn"> RESOURCE_FOUR_TITLE </a></p>
            </div>            <div class="col col-sm-12 col-md-10 col-lg-10">
              <p> RESOURCE_FOUR_NOTE </p>
            </div>          </div>


          <div id="resources_5" class="row report_section report_hidden">
            <div class="col col-12 col-sm-12 col-md-12 col-lg-2">
              <p><a href=" RESOURCE_FIVE_URL " target="_blank" class="resources_btn"> RESOURCE_FIVE_TITLE </a></p>
            </div>            <div class="col col-sm-12 col-md-10 col-lg-10">
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
  CASE
    WHEN rules_table.hardduedatecompare = -1 THEN 'Before'
    WHEN rules_table.hardduedatecompare = 0 THEN 'After'
    WHEN rules_table.hardduedatecompare = 1 THEN 'Exactly on'
    ELSE rules_table.hardduedatecompare
  END AS 'Hard due date (comparison)',
  rules_table.hardduedate AS 'Hard due date',
  rules_table.decreaseloanholds AS 'Decreased loan period for high holds (day)'
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
      ) AS decreaseloanholds
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


























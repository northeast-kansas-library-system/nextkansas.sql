/*
R.003552

----------

Name: GHW - Libraries charging late fees
Created by: George Williams

----------

Group: Rules
     -

Created on: 2021-08-31 18:42:23
Modified on: 2026-07-28 17:27:24
Date last run: 2026-08-16 20:52:55

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

    <p id="report_id"><strong>Report number:</strong> 3552</p>

    <p id="report_name"><strong>Report name:</strong> Libraries charging late fees</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Generates a list of libraries that charge late fees</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3552-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3552Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3552Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3552Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3552Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3552Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Generates a list of libraries that charge late fees</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> shows late fees existing at the time the report is run</li>

              <li><strong>AT:</strong> at all member libraries</li>

              <li><strong>GROUPED BY:</strong> library and type of late fee</li>

              <li><strong>SORTED BY:</strong> type of late fee and library</li>

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

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>##rules</p>
    <p>##latefees</p>
    <p>##fines</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>##has_notes</p>
  </div>

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


























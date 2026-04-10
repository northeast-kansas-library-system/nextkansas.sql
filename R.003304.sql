/*
R.003304

----------

Name: GHW - Item Count by item type
Created by: George Williams

----------

Group: -
     -

Created on: 2020-01-13 16:10:56
Modified on: 2026-03-12 11:42:40
Date last run: 2026-03-27 14:05:49

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

    <p id="report_id"><strong>Report number:</strong> 3304</p>

    <p id="report_name"><strong>Report name:</strong> Item Count by item type</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Counts items at a library grouped by item type</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3304-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3304Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3304Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3304Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3304Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3304Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Counts items at a library grouped by item type</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> counts items currently in the collection</li>

              <li><strong>AT:</strong> at the library you specify</li>

              <li><strong>GROUPED BY:</strong> library name and item type description</li>

              <li><strong>SORTED BY:</strong> library name and item type description</li>

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
    <div id="accordion_3304-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3304Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3304Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3304Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3304Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3304Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Shelving location</h4>
            <p>ADULT_ITEMS = items with an adult shelving location<br>JUVENILE_ITEMS = items with a juvenile shelving location<br>YOUNG_ADULT_ITEMS = items with a young adult shelving location<br>OTHER = items without a shelving location or items where the shelving location isn't adult, juvenile, or young adult</p>
          </div>

          <div id="notes_2" class="report_section">
            <h4>Rules</h4>
            <p>If "Specific rules for this item type" = Yes<br>then there is at least one circulation rule at the item's home library for items with this item type.<br><br>You can run reports 3486, 3487, and 3488 to find the circulation matrix rules for your library.<br>You can run report 3765 to find Holds and bookings policies by item type rules for your library.</p>
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
    <p>#item count</p>
    <p>#item type</p>
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
  branchtypes.branchname,
  branchtypes.description AS 'Item type',
  itemss.Count_itemnumber AS TOTAL_ITEMS,
  adultitems.Count_itemnumber AS ADULT_ITEMS,
  juvenileitems.Count_itemnumber AS JUVENILE_ITEMS,
  yaitems.Count_itemnumber AS YOUNG_ADULT_ITEMS,
  other.Count_itemnumber AS OTHER,
  rules.rules AS 'Specific rules for this item type'
FROM
  (SELECT
      branches.branchcode,
      branches.branchname,
      itemtypes.itemtype,
      itemtypes.description
    FROM
      branches,
      itemtypes
    GROUP BY
      branches.branchcode,
      branches.branchname,
      itemtypes.itemtype,
      itemtypes.description) branchtypes LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS ITYPE,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch,
      Coalesce(items.itype, "XXX")) itemss ON itemss.homebranch =
      branchtypes.branchcode AND
      itemss.ITYPE = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE '%AD%'
    GROUP BY
      items.homebranch,
      Coalesce(items.itype, "XXX")) adultitems ON adultitems.homebranch =
      branchtypes.branchcode AND
      adultitems.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE "%JU%"
    GROUP BY
      items.homebranch,
      Coalesce(items.itype, "XXX")) juvenileitems ON juvenileitems.homebranch =
      branchtypes.branchcode AND
      juvenileitems.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.permanent_location LIKE "%YA%"
    GROUP BY
      items.homebranch,
      Coalesce(items.itype, "XXX")) yaitems ON yaitems.homebranch =
      branchtypes.branchcode AND
      yaitems.itype = branchtypes.itemtype LEFT JOIN
  (SELECT
      items.homebranch,
      Coalesce(items.itype, "XXX") AS itype,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      (items.permanent_location IS NULL) OR
      (items.permanent_location NOT LIKE "%AD%" AND
        items.permanent_location NOT LIKE "%JU%" AND
        items.permanent_location NOT LIKE "%YA%")
    GROUP BY
      items.homebranch,
      Coalesce(items.itype, "XXX")) other ON other.itype = branchtypes.itemtype
      AND
      other.homebranch = branchtypes.branchcode LEFT JOIN
  (SELECT
      circulation_rules.branchcode,
      circulation_rules.itemtype,
      "Yes" AS rules
    FROM
      circulation_rules
    GROUP BY
      circulation_rules.branchcode,
      circulation_rules.itemtype) rules ON rules.itemtype = branchtypes.itemtype
      AND
      rules.branchcode = branchtypes.branchcode
WHERE
  branchtypes.branchcode LIKE <<Choose your library|LBRANCH>> AND
  branchtypes.itemtype LIKE <<Choose your item type|LITYPES>> 
GROUP BY
  branchtypes.branchname,
  branchtypes.description


























/*
R.003939

----------

Name: GHW - Daily item type count
Created by: George Williams

----------

Group: -
     -

Created on: 2026-01-19 08:57:45
Modified on: 2026-01-29 14:00:02
Date last run: 2026-01-29 14:00:02

----------

Public: 0
Expiry: 300

----------

&lt;div class="next_report_info next_noprint"&gt;

&lt;style&gt;

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

&lt;/style&gt;

&lt;!-- Overview --&gt;

  &lt;div class="next_report_summary"&gt;
    &lt;br&gt;

    &lt;p id="report_id"&gt;&lt;strong&gt;Report number:&lt;/strong&gt; 3939&lt;/p&gt;

    &lt;p id="report_name"&gt;&lt;strong&gt;Report name:&lt;/strong&gt; Daily item type count&lt;/p&gt;

    &lt;p id="report_author"&gt;&lt;strong&gt;Report author:&lt;/strong&gt; GHW&lt;/p&gt;

    &lt;p id="report_summary"&gt;&lt;strong&gt;Report summary:&lt;/strong&gt; Returns a current count of items by item type&lt;/p&gt;

  &lt;/div&gt;

  &lt;div class="accordion accordion-flush"&gt;

&lt;!-- Function section --&gt;
    &lt;div id="accordion_3939-1" class="accordion-item next_report_function"&gt;

      &lt;h2 class="accordion-header" id="panelsStay_3939Open-headingOne" &gt;

        &lt;button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3939Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3939Open-collapseOne"&gt;

          Function:

        &lt;/button&gt;

      &lt;/h2&gt;

      &lt;div id="panelsStay_3939Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3939Open-headingOne"&gt;
        &lt;div class="accordion-body"&gt;

          &lt;div id="function_section" class="report_section"&gt;


            &lt;p&gt;Counts items&lt;/p&gt;
            &lt;ul style="list-style-type:none"&gt;

              &lt;li&gt;&lt;strong&gt;TIME FRAME:&lt;/strong&gt; counts items in the catalog at the time the report is run&lt;/li&gt;

              &lt;li&gt;&lt;strong&gt;AT:&lt;/strong&gt; all Next Search Catalog libraries&lt;/li&gt;

              &lt;li&gt;&lt;strong&gt;GROUPED BY:&lt;/strong&gt; item type&lt;/li&gt;

              &lt;li&gt;&lt;strong&gt;SORTED BY:&lt;/strong&gt; item type&lt;/li&gt;

            &lt;span style="display: none;"&gt;
              &lt;li&gt;&lt;strong&gt;CONTAINS LINKS:&lt;/strong&gt; &lt;/li&gt;
            &lt;/span&gt;
            &lt;/ul&gt;


            &lt;p&gt;This report is currently set to run automatically every night at 10:00 p.m. and have its results e-mailed to the Next Search Catalog coordinator&lt;/p&gt;

          &lt;/div&gt;

        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

&lt;!-- Direct download section --&gt;
  &lt;div class="next_report_direct_download "&gt;
    &lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3939" class="direct_download_btn"&gt;Download directly to a CSV file&lt;/a&gt;&lt;/p&gt;
  &lt;/div&gt;

&lt;!-- Hashtag section --&gt;
  &lt;div class="next_report_hashtags" style="display: none;"&gt;
    &lt;p&gt;#count items&lt;/p&gt;
    &lt;p&gt;#item type count&lt;/p&gt;
    &lt;p&gt;#automatic&lt;/p&gt;
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



SELECT
  item_types.description AS ITEM_TYPE,
  item_types.itemtype AS ITYPE_CODE,
  Coalesce(itemss.COUNT, 0) AS ITEM_COUNT,
  Date_Format(CurDate(), "%Y-%m-%d") AS DATE
FROM
  (SELECT
      itemtypes.description,
      itemtypes.itemtype
    FROM
      itemtypes
    UNION
    SELECT
      ' No item type' AS Column1,
      '-' AS Column2
    FROM
      itemtypes) item_types LEFT JOIN
  (SELECT
      Coalesce(items.itype, '-') AS CODE,
      Count(items.itemnumber) AS COUNT
    FROM
      items
    GROUP BY
      Coalesce(items.itype, '-')) itemss ON itemss.CODE = item_types.itemtype
GROUP BY
  item_types.description,
  item_types.itemtype
ORDER BY
  ITEM_TYPE
LIMIT 250


























/*
R.003658

----------

Name: GHW - Missing in transit items
Created by: George Williams

----------

Group: -
     -

Created on: 2022-03-25 18:26:18
Modified on: 2025-07-09 11:33:52
Date last run: 2026-01-29 13:39:45

----------

Public: 0
Expiry: 300

----------

&lt;div class="next_report_info next_noprint next_core_report"&gt; 

  &lt;p class="next_embiggen2"&gt;Items that have been in transit for more than 7 days&lt;/p&gt; 

  &lt;div class="accordion accordion-flush"&gt; 

    &lt;div class="accordion-item"&gt; 

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingOne"&gt; 
        &lt;button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne"&gt; 

            Report function:

        &lt;/button&gt; 
      &lt;/h2&gt; 
      &lt;div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne"&gt; 
        &lt;div class="accordion-body"&gt; 

          &lt;p&gt;This report shows items that:&lt;/p&gt; 
          &lt;ul&gt; 
            &lt;li&gt;are owned by your library&lt;/li&gt; 
            &lt;li&gt;or are in transit from your library to another library&lt;/li&gt; 
            &lt;li&gt;or are in transit to your library&lt;/li&gt; 
          &lt;/ul&gt; 

        &lt;/div&gt; 
      &lt;/div&gt; 
    &lt;/div&gt; 

    &lt;div class="accordion-item"&gt; 

      &lt;h2 class="accordion-header" id="panelsStayOpen-headingThree"&gt; 
        &lt;button class="accordion-button next_report_instructions" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree"&gt; 

          Report instructions:

        &lt;/button&gt; 
      &lt;/h2&gt; 
      &lt;div id="panelsStayOpen-collapseThree" class="accordion-collapse show" aria-labelledby="panelsStayOpen-headingThree"&gt; 
        &lt;div class="accordion-body"&gt; 

          &lt;div class="next_report_section"&gt; 

            &lt;p&gt;Please search for these items at your library once a week and then:&lt;/p&gt; 
            &lt;ul&gt; 
              &lt;li&gt;check in any items you find&lt;/li&gt; 
              &lt;li&gt;e-mail the other libraries involved in missing in transit transfers and ask them to also search for the missing items&lt;/li&gt; 
              &lt;li&gt;change the status of any items owned by your library that no one can find to "Missing (unable to locate on shelf)" within a reasonable amount of time&lt;/li&gt; 
            &lt;/ul&gt; 

            &lt;p&gt;If you have a default e-mail program configured on your computer, clicking the "Send e-mail" button in the far right column will automatically generate an e-mail to all libraries concerned with a specific transfer.&lt;/p&gt; 

          &lt;/div&gt; 

        &lt;/div&gt; 
      &lt;/div&gt; 
    &lt;/div&gt; 

  &lt;/div&gt; 

  &lt;div class="next_hidden"&gt; 

    &lt;p&gt; 

      #core 
      #weekly 
      #missing in transit 
      #mit 

    &lt;/p&gt; 

  &lt;/div&gt; 

  &lt;div id="next_report_training" class="next_report_training "&gt;
    &lt;br&gt;&lt;br&gt;
    &lt;a class="next_btn next_indigo next_embiggen2" href="https://northeast-kansas-library-system.github.io/nextsteps/reports_training/report_003658_training.html" target="_blank"&gt;Training page for report 3658&lt;i class="bi bi-arrow-up-right-square"&gt;&lt;/i&gt;&lt;/a&gt;
    &lt;br&gt;

    &lt;br&gt;

  &lt;/div&gt;

&lt;/div&gt;

----------
*/



SELECT 
  Concat( 
    'BIBLIO' 
  ) AS 'LINK', 
  item_info.HOME_LIBRARY, 
  item_info.branchname AS CURRENT_LIBRARY, 
  item_info.LOCATION, 
  item_info.ITYPE, 
  item_info.CCODE, 
  item_info.CALL_NUMBER, 
  item_info.author, 
  item_info.TITLE, 
  item_info.datelastseen, 
  item_info.barcode1, 
  item_info.homebranch AS OWNED_BY, 
  frombranches.branchname AS SENT_FROM, 
  branchtransfers.datesent AS SENT_DATE, 
  tobranches.branchname AS SENT_TO, 
  branchtransfers.reason AS TRANSFER_REASON, 
  Concat_WS('', 
    'Send e-mail' 
  ) AS MAILTO_LINK, 
  @SortOrder := &lt;&gt; AS SORTING 
FROM 
  branchtransfers JOIN 
  branches frombranches ON branchtransfers.frombranch = frombranches.branchcode JOIN 
  branches tobranches ON branchtransfers.tobranch = tobranches.branchcode JOIN 
  (SELECT 
    items.biblionumber, 
    items.itemnumber, 
    items.barcode, 
    home.branchname AS HOME_LIBRARY, 
    holding.branchname, 
    perm_locs.lib AS PERM_LOCATION, 
    Concat_Ws('', 
      perm_locs.lib, 
      If(locs.lib = 'Recently returned', ' (Recently returned)', '') 
    ) AS LOCATION, 
    itemtypes.description AS ITYPE, 
    ccodes.lib AS CCODE, 
    items.itemcallnumber, 
    Concat_Ws('', 
      items.itemcallnumber, 
      If(items.copynumber IS NULL, '', Concat(' (Copy number: ', items.copynumber, ')')) 
    ) AS CALL_NUMBER, 
    biblio.author, 
    Concat_Ws(' ', biblio.title, biblio.medium, biblio.subtitle, 
    biblioitems.number, biblio.part_name) AS TITLE, 
    items.datelastseen, 
    items.copynumber, 
    Concat('-', items.barcode, '-') AS barcode1, 
    items.homebranch, 
    home.branchemail,
    home.branchreplyto 
  FROM 
    items JOIN 
    biblio ON items.biblionumber = biblio.biblionumber JOIN 
    biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN 
    (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
    ) 
    perm_locs ON perm_locs.authorised_value = items.permanent_location LEFT JOIN 
    (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC' 
    ) locs ON locs.authorised_value = items.location LEFT JOIN 
    itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN 
    (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'CCODE' 
    ) 
    ccodes ON 
    ccodes.authorised_value = items.ccode LEFT JOIN 
    branches home ON home.branchcode = items.homebranch LEFT JOIN 
    branches holding ON holding.branchcode = items.holdingbranch 
  GROUP BY 
    items.biblionumber, 
    items.itemnumber 
  ) 
  item_info ON item_info.itemnumber = branchtransfers.itemnumber 
WHERE 
  branchtransfers.datearrived IS NULL AND 
  branchtransfers.datecancelled IS NULL AND 
  Concat_Ws(' | ', 
    item_info.homebranch, 
    branchtransfers.frombranch, 
    branchtransfers.tobranch 
  ) LIKE Concat('%', &lt;&gt;, '%') AND 
  branchtransfers.datesent &lt; CurDate() - INTERVAL 7 DAY 
GROUP BY 
  item_info.biblionumber, 
  item_info.itemnumber 
ORDER BY 
  CASE WHEN SORTING = '1' THEN item_info.HOME_LIBRARY END ASC, 
  CASE WHEN SORTING = '2' THEN item_info.PERM_LOCATION END ASC, 
  item_info.PERM_LOCATION, 
  item_info.ITYPE, 
  item_info.CCODE, 
  item_info.itemcallnumber, 
  item_info.author, 
  item_info.TITLE, 
  item_info.copynumber 


























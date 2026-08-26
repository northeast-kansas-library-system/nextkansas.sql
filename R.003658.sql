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
Date last run: 2026-08-25 17:34:51

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint next_core_report"> 

  <p class="next_embiggen2">Items that have been in transit for more than 7 days</p> 

  <div class="accordion accordion-flush"> 

    <div class="accordion-item"> 

      <h2 class="accordion-header" id="panelsStayOpen-headingOne"> 
        <button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne"> 

            Report function:

        </button> 
      </h2> 
      <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne"> 
        <div class="accordion-body"> 

          <p>This report shows items that:</p> 
          <ul> 
            <li>are owned by your library</li> 
            <li>or are in transit from your library to another library</li> 
            <li>or are in transit to your library</li> 
          </ul> 

        </div> 
      </div> 
    </div> 

    <div class="accordion-item"> 

      <h2 class="accordion-header" id="panelsStayOpen-headingThree"> 
        <button class="accordion-button next_report_instructions" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree"> 

          Report instructions:

        </button> 
      </h2> 
      <div id="panelsStayOpen-collapseThree" class="accordion-collapse show" aria-labelledby="panelsStayOpen-headingThree"> 
        <div class="accordion-body"> 

          <div class="next_report_section"> 

            <p>Please search for these items at your library once a week and then:</p> 
            <ul> 
              <li>check in any items you find</li> 
              <li>e-mail the other libraries involved in missing in transit transfers and ask them to also search for the missing items</li> 
              <li>change the status of any items owned by your library that no one can find to "Missing (unable to locate on shelf)" within a reasonable amount of time</li> 
            </ul> 

            <p>If you have a default e-mail program configured on your computer, clicking the "Send e-mail" button in the far right column will automatically generate an e-mail to all libraries concerned with a specific transfer.</p> 

          </div> 

        </div> 
      </div> 
    </div> 

  </div> 

  <div class="next_hidden"> 

    <p> 

      #core 
      #weekly 
      #missing in transit 
      #mit 

    </p> 

  </div> 

  <div id="next_report_training" class="next_report_training ">
    <br><br>
    <a class="next_btn next_indigo next_embiggen2" href="https://northeast-kansas-library-system.github.io/nextsteps/reports_training/report_003658_training.html" target="_blank">Training page for report 3658<i class="bi bi-arrow-up-right-square"></i></a>
    <br>

    <br>

  </div>

</div>

----------
*/



SELECT 
  Concat( 
    '<a class="btn btn-default btn-xs noprint"', 
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    item_info.biblionumber, 
    '\" target="_blank">BIBLIO</a>' 
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
    '<a class="btn btn-default btn-xs noprint" ', 
    'href="mailto:', 
    item_info.branchreplyto, 
    '?subject=Missing&nbsp;in&nbsp;transit&nbsp;', 
    branchtransfers.branchtransfer_id, 
    '&amp;cc=', 
    frombranches.branchreplyto, 
    ';', 
    tobranches.branchreplyto, 
    '&body=An%20item%20owned%20by%20&#42;&#42;', 
    item_info.HOME_LIBRARY, 
    '&#42;&#42;%20was%20shipped%20from%20&#42;&#42;', 
    frombranches.branchname, 
    '&#42;&#42;%20to%20&#42;&#42;', 
    tobranches.branchname, 
    '&#42;&#42;%20on%20', 
    branchtransfers.datesent, 
    '%20and%20the%20item%20has%20not%20yet%20arrived.', 
    '%0D%0A%0D%0A', 
    'The%20details%20are%20as%20follow%3A', 
    '%0D%0A%0D%0A', 
    'Branch%20transfer%20ID%3A%20', 
    branchtransfers.branchtransfer_id, 
    '%0D%0A%0D%0A', 
    'Home%20library%3A%20', 
    item_info.HOME_LIBRARY, 
    '%0D%0ALocation%3A%20', 
    item_info.LOCATION, 
    '%0D%0AItem%20type%3A%20', 
    item_info.ITYPE, 
    '%0D%0ACollection%20code%3A%20', 
    item_info.CCODE, 
    '%0D%0ACall%20number%3A%20', 
    item_info.CALL_NUMBER, 
    '%0D%0AAuthor%3A%20', 
    item_info.author, 
    '%0D%0ATitle%3A%20', 
    UPPER(REPLACE(item_info.TITLE, '&', 'and')), 
    '%0D%0ABarcode%20number%3A%20', 
    item_info.barcode, 
    '%0D%0A%0D%0A', 
    'Sent%20from%3A%20', 
    frombranches.branchname, 
    '%0D%0ASent%20to%3A%20', 
    tobranches.branchname, 
    '%0D%0ASent%20on%3A%20', 
    branchtransfers.datesent, 
    '%0D%0A%0D%0A', 
    'Transfer%20reason%3A%20', 
    branchtransfers.reason, 
    '%20%0D%0A%0D%0A', 
    'Could%20you%20please%20check%20the%20shelves%20at%20your%20library%20', 
    '&#40;including%20the%20hold%20shelf&#41;%20', 
    'and%20check%20this%20item%20in%20if%20you%20find%20it&#63;', 
    '%0D%0A%0D%0A', 
    'If%20no%20one%20can%20find%20this%20item%20after%2010-14%20days%2C%20', 
    'the%20owning%20library%2C%20%2A%2A',  
    item_info.HOME_LIBRARY,
    '%2A%2A%2C%20should%20change%20the%20status%20of%20the%20item%20', 
    'to%20 %22Missing%20%28unable%20to%20locate%20on%20shelf%29.%22%20', 
    '%0D%0A%0D%0A', 
    'Thank you,', 
    '%20%0D%0A%0D%0A', 
    '">Send e-mail</a>' 
  ) AS MAILTO_LINK, 
  @SortOrder := <<Sort by|XS_BRANCH>> AS SORTING 
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
  ) LIKE Concat('%', <<Choose your library|branches>>, '%') AND 
  branchtransfers.datesent < CurDate() - INTERVAL 7 DAY 
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


























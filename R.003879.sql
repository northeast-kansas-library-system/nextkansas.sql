/*
R.003879

----------

Name: GHW - Flexible Shelflist Report
Created by: George Williams

----------

Group: -
     -

Created on: 2025-03-12 00:03:17
Modified on: 2026-01-29 16:29:36
Date last run: 2026-03-05 14:58:25

----------

Public: 0
Expiry: 300

----------

<div class=""next_report_info next_noprint"">

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

  <div class=""next_report_summary"">
    <br>

    <p id=""report_id""><strong>Report number:</strong> 3879</p>

    <p id=""report_name""><strong>Report name:</strong> Flexible Shelflist Report</p>

    <p id=""report_author""><strong>Report author:</strong> GHW</p>

    <p id=""report_summary""><strong>Report summary:</strong> Generates a list of items owned by a library and allows options for filtering.</p>

  </div>

  <div class=""accordion accordion-flush"">

<!-- Function section -->
    <div id=""accordion_3879-1"" class=""accordion-item next_report_function"">

      <h2 class=""accordion-header"" id=""panelsStay_3879Open-headingOne"" >

        <button class=""accordion-button collapsed"" type=""button"" data-bs-toggle=""collapse""
          data-bs-target=""#panelsStay_3879Open-collapseOne"" aria-expanded=""true""
          aria-controls=""panelsStay_3879Open-collapseOne"">

          Function:

        </button>

      </h2>

      <div id=""panelsStay_3879Open-collapseOne"" class=""accordion-collapse collapse""
        aria-labelledby=""panelsStay_3879Open-headingOne"">
        <div class=""accordion-body"">

          <div id=""function_section"" class=""report_section"">


            <p>Generates a list of items owned by a library and allows options for filtering.</p>
            <ul style=""list-style-type:none"">

              <li><strong>TIME FRAME:</strong> shows items that are currently in Next</li>

              <li><strong>AT:</strong> the library you specify</li>

              <li><strong>GROUPED BY:</strong> itemnumber; home library; shelving location; item type; collection code; call number; author; title; itemnumber</li>

              <li><strong>SORTED BY:</strong> itemnumber; home library; shelving location; item type; collection code; call number; author; title; itemnumber</li>

              <li><strong>CONTAINS LINKS:</strong> links to the bibliographic record and item record</li>
            </ul>


            <span style=""display: none;"">
            <p> - </p>
            </span>

          </div>

        </div>
      </div>

    </div>

<!-- Notes section -->
    <div id=""accordion_REPORTID-2"" class=""accordion-item next_report_notes "">

      <h2 class=""accordion-header"" id=""panelsStay_REPORTIDOpen-headingTwo"">

        <button class=""accordion-button collapsed"" type=""button"" data-bs-toggle=""collapse""
          data-bs-target=""#panelsStay_REPORTIDOpen-collapseTwo"" aria-expanded=""false""
          aria-controls=""panelsStay_REPORTIDOpen-collapseTwo"">

          Notes:

        </button>

      </h2>

      <div id=""panelsStay_REPORTIDOpen-collapseTwo"" class=""accordion-collapse collapse""
        aria-labelledby=""panelsStay_REPORTIDOpen-headingTwo"">
        <div class=""accordion-body"">

          <div id=""notes_1"" class=""report_section"">
            <h4>Dates</h4>
            <p>This report handles item added dates, date last borrowed dates, and date last seen dates in the following manner:<br><br>Item added dates that are older than 2000 are filtered as if they were added on January 2, 2000<br>this means that if you want to search for items added before January 1, 2000, enter January 1, 2000 as date1<br><br>Item added dates that are newer than today are filtered as if they were added today<br>this means that if you want to search for items that were added after today (i.e. dates with mistakes), enter tomorrow as date2<br><br>Date last borrowed dates that are older than 2000 or are blank are filtered as if they were added on January 2, 2000<br>this means that if you want to search for items that have a date last borrowed older than January 1, 2000 or a blank date last borrowed, enter January 1, 2000 as date1<br><br>Date last seen dates that are blank or older than 2000 are filtered as if they were added on January 2, 2000<br>this means that if you want to search for items that have a date last seen older than January 1, 2000 or a blank date last seen, enter January 1, 2000 as date1<br><br>All of these dates will still show the actual dates in the appropriate columns, but you will not need to adjust the filters earlier than January 1, 2000 in order to identify dates prior to 2000. If you run this report and specify dates before January 1, 2000, you will be able to see these items, but you cannot specify dates older than January 1, 2000, and expect to be limited to the specified date range.</p>
          </div>

          <div id=""notes_2"" class=""report_section"">
            <h4>Publication date</h4>
            <p>Publication year data comes from the 264$c or 260$c subfield. If the data in 264$c or 260$c is not entered as a 4 digit year, or contains non-standard date information, the data may be problematic. If 264$c and/or 260$c subfields are blank, the result in this report will be blank.<br><br>For example, if the 264$c is entered as ""Nineteen Seventy Five"", the data will be weird. If the 264$c is ""Copyright 1975,"" the data will be weird. If the 264$c is ©1975, the date should be as expected, but if it's 📅1975, the data will be problematic.</p>
          </div>

          <div id=""notes_3"" class=""report_section"">
            <h4>Replaces these reports</h4>
            <p>2731 (GHW - Flexible Shelflist Report)<br>664 (Full Shelf List)<br>2686 (Collection Code Super Weeder)<br>1013 (Item Type Super Weeder)<br>1442 (Super Weeder by Callnumber)<br>2471 (BCPL.SuperWeeder.by.Callnumber)<br>1017 (Items with NO checkouts (all items))<br>1151 (Date last borrowed, Call number and Title limited by Item type)<br>1426 (Last seen on a specific date or earlier)<br>1807 (Items with NO checkouts -- limited by CCode)<br>2202 (Items with NO checkouts (limited to a collection code and location))<br>2203 (Items with NO checkouts (limited to a collection code))<br>2241 (Last Seen Date, limited by Collection Code)<br>2392 (Date last borrowed, Call number and Title limited by Ccode and Location)<br>2411 (Date last borrowed)<br>1408 (Shelf List of Specific Item Type)<br>1409 (Shelf List of Specific CCode and Location)<br>1410 (Shelf List of Specific Item Type and Location)<br>3014 (GHW - Shelflist with left anchored call number limit)<br>2809 (GHW - List of items with display locations)<br>886 Videogames Circ List<br>536 New acquisitions for a specific month</p>
          </div>

          <div id=""notes_4"" class=""report_section report_hidden"">
            <h4> NOTE_FOUR_TITLE </h4>
            <p> NOTE_FOUR_CONTENT </p>
          </div>

          <div id=""notes_5"" class=""report_section report_hidden"">
            <h4> NOTE_FIVE_TITLE </h4>
            <p> NOTE_FIVE_CONTENT </p>
          </div>

        </div>
      </div>

    </div>

<!-- Hashtag section -->
  <div class=""next_report_hashtags"" style=""display: none;"">
    <p>#corereport</p>
    <p>#2731</p>
    <p>#shelflist</p>
    <p>#lost</p>
    <p>#missing</p>
    <p>#open records</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
  </div>

</div>

----------
*/

Select 
Concat(
    '<a class="btn btn-default noprint" ',
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',
    item_information.biblionumber,
    '\" target="_blank">Go to title</a>',
    '<br>&nbsp;<br>',
    '<a class="btn btn-default noprint" ',
    'href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',
    item_information.biblionumber,
    '&itemnumber=',
    item_information.itemnumber,
    '#edititem\" target="_blank">Edit item</a>',
    '<br>&nbsp;<br>',
    '<a class="btn btn-default noprint" ',
    'href=\"https://nextkansas.org/Record/',
    item_information.biblionumber,
    '\" target="_blank">View title in<br>Aspen Discovery</a>'
  ) As LINK_ONE,
  item_information.biblionumber As BIBLIO_NUMBER,
  item_information.itemnumber As ITEM_NUMBER,
  item_information.barcode As BARCODE,
  home_branches.branchname As HOME_LIBRARY,
  current_branches.branchname As CURRENT_LIBRARY,
  permanent_locations.lib As ITEM_PERMANENT_LOCATION,
  locations.lib As ITEM_CURRENT_LOCATION,
  item_information.BIB_LOC AS BIB_LOCATION,
  itemtypes.description As ITEM_ITYPE,
  item_information.BIB_ITYPE AS BIB_ITYPE,
  ccodes.lib As ITEM_COLLECTION_CODE,
  item_information.BIB_CCODE AS BIB_COLLECTION_CODE,
  item_information.itemcallnumber As CALL_NUMBER,
  item_information.author As AUTHOR,
  item_information.FULL_TITLE,
  item_information.publicationyear,
  item_information.isbn,
  item_information.issn,
  item_information.UPC,
  item_information.dateaccessioned,
  item_information.datelastborrowed,
  item_information.datelastseen,
  item_information.issues,
  item_information.renewals,
  item_information.CKO_PLUS_RENEW,
  last_twelve.count As CKO_LAST_12M,
  item_information.CHECKED_OUT_NOW,
  not_loans.lib As NOT_FOR_LOAN,
  item_information.STATUS_PROBLEMS,
  Concat_Ws(
    '',
    If(
      Coalesce(damageds.lib, '') = '',
      '',
      Concat_Ws(
        '',
        damageds.lib,
        ' -- ',
        Coalesce(item_information.damaged_on, 'Date not known')
      )
    ),
    If(item_information.status_score > 18, ' / ', ''),
    If(
      Coalesce(losts.lib, 'x') = 'x',
      '',
      Concat_Ws(
        '',
        losts.lib,
        ' -- ',
        Coalesce(
          item_information.itemlost_on,
          'Date not known'
        )
      )
    ),
    If(
      item_information.status_score = 18,
      ' / ',
      If(item_information.status_score = 35, ' / ', '')
    ),
    If(
      Coalesce(withdrawns.lib, '') = '',
      '',
      Concat_Ws(
        '',
        withdrawns.lib,
        ' -- ',
        Coalesce(item_information.withdrawn_on, 'Date not known')
      )
    )
  ) As STATUSES,
  item_information.itemnotes,
  item_information.itemnotes_nonpublic,
  item_information.copynumber,
  item_information.replacementprice,
  local_count.Count_itemnumber As LOCAL_COPIES,
  system_count.Count_itemnumber As SYSTEM_COPIES,
  Concat(
    '<a class="btn btn-default noprint" ',
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',
    item_information.biblionumber,
    '\" target="_blank">Go to title</a>',
    '<br>',
    '<a class="btn btn-default noprint" ',
    'href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',
    item_information.biblionumber,
    '&itemnumber=',
    item_information.itemnumber,
    '#edititem\" target="_blank">Edit item</a>'
  ) As LINK_TWO
From (
    Select items.biblionumber,
      items.itemnumber,
      IF(
        LEFT(
          Trim(items.barcode), 1
        ) = '0', 
        Concat_Ws('', '-', items.barcode, '-'), 
        Trim(items.barcode)
      ) As barcode,
      items.homebranch,
      items.holdingbranch,
      items.permanent_location,
      items.location,
      items.itype,
      items.ccode,
      items.itemcallnumber,
      biblio.author,
      Concat_Ws(
        " ",
        biblio.title,
        ExtractValue(
          biblio_metadata.metadata,
          '//datafield[@tag="245"]/subfield[@code="h"]'
        ),
        ExtractValue(
          biblio_metadata.metadata,
          '//datafield[@tag="245"]/subfield[@code="b"]'
        ),
        ExtractValue(
          biblio_metadata.metadata,
          '//datafield[@tag="245"]/subfield[@code="p"]'
        ),
        ExtractValue(
          biblio_metadata.metadata,
          '//datafield[@tag="245"]/subfield[@code="n"]'
        )
      ) As FULL_TITLE,
      biblioitems.publicationyear,
      biblioitems.isbn,
      biblioitems.issn,
      ExtractValue(
        biblio_metadata.metadata,
        '//datafield[@tag="024"]/subfield[@code="a"]'
      ) As UPC,
      ExtractValue(
          biblio_metadata.metadata,
          '//datafield[@tag="942"]/subfield[@code="e"]'
      ) AS BIB_LOC,
      ExtractValue(
        biblio_metadata.metadata,
        '//datafield[@tag="942"]/subfield[@code="c"]'
      ) AS BIB_ITYPE,
      ExtractValue(
        biblio_metadata.metadata,
        '//datafield[@tag="942"]/subfield[@code="h"]'
      ) AS BIB_CCODE,
      items.dateaccessioned
      ,
      If(
        Coalesce(items.dateaccessioned, '2000-01-02') < '2000-01-01', 
        '2000-01-02', 
        If(
          items.dateaccessioned > Now(), 
          '2000-01-03', 
          items.dateaccessioned
        )
      ) AS dateaccessioned_normalized,
      items.datelastborrowed,
      items.datelastseen,
      items.issues,
      items.renewals,
      (
        Coalesce(items.issues, 0) + Coalesce(items.renewals, 0)
      ) As CKO_PLUS_RENEW,
      If(items.onloan Is Null, 'No', 'Yes') As CHECKED_OUT_NOW,
      items.notforloan,
      If(
        Sum(
          Coalesce(items.damaged, 0) + Coalesce(items.itemlost, 0) + Coalesce(items.withdrawn, 0)
        ) = 0,
        'No',
        'Yes'
      ) As STATUS_PROBLEMS,
      items.damaged,
      items.damaged_on,
      items.itemlost,
      items.itemlost_on,
      items.withdrawn,
      items.withdrawn_on,
      If((items.damaged * 10) != 0, 17, 0) As damage_score,
      If((items.itemlost * 10) != 0, 11, 0) As lost_score,
      If((items.withdrawn * 10) != 0, 7, 0) As withdrawn_score,
      (
        If((items.damaged * 10) != 0, 17, 0) + If((items.itemlost * 10) != 0, 11, 0) + If((items.withdrawn * 10) != 0, 7, 0)
      ) As status_score,
      items.itemnotes,
      items.itemnotes_nonpublic,
      items.copynumber,
      items.replacementprice,
      '' As LOCAL_COPIES,
      '' As SYSTEM_COPIES
    From items
      Join biblio On items.biblionumber = biblio.biblionumber
      Inner Join biblio_metadata On biblio_metadata.biblionumber = biblio.biblionumber
      Inner Join biblioitems On biblioitems.biblionumber = biblio.biblionumber
    Where 
      Coalesce(items.homebranch, 'NEKLS') LIKE <<Item home library|ZBRAN>> AND
      Coalesce(items.permanent_location, "-") LIKE <<Item permanent shelving location|LLOC>> AND 
      Coalesce(items.itype, 'PUNC') LIKE <<Item type|LITYPES>> AND
      Coalesce(items.ccode, 'XXX') LIKE <<Item collection code|LCCODE>> AND 
      Coalesce(items.itemcallnumber, '-') LIKE Concat(<<Enter first part of call number or a % symbol>>, "%") AND 
      IF(Coalesce(items.notforloan, 0) = 0, 'X', items.notforloan) REGEXP <<Not for loan status|LNOT_LOAN>> AND 
      (
        If(
          Coalesce(items.dateaccessioned, '2000-01-02') < '2000-01-01', 
          '2000-01-02', 
          If(
            items.dateaccessioned > Now(), 
            Cast(now() As Date), 
            items.dateaccessioned
          )
        ) BETWEEN <<Item added between date1|date>> AND <<and-date2|date>>
      ) AND 
      (
        If( 
          Coalesce(Year(Coalesce(items.datelastborrowed)), '1999') < '2000', 
          '2000-01-02', 
          items.datelastborrowed 
        ) BETWEEN <<Item last borrowed between date1|date>> AND <<and--date2|date>>
      ) AND 
      (
        If( 
          Coalesce(Year(Coalesce(items.datelastseen)), '1999') < '2000', 
          CAST('2000-01-02' AS DATE), 
          Date(items.datelastseen) 
        ) BETWEEN <<Item last seen between date1|date>> AND <<and---date2|date>> 
      )
    Group By items.itemnumber
  ) item_information
  Left Join branches home_branches 
    On home_branches.branchcode = item_information.homebranch
  Left Join branches current_branches 
    On current_branches.branchcode = item_information.holdingbranch
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'LOC'
  ) permanent_locations 
    On permanent_locations.authorised_value = item_information.permanent_location
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'LOC'
  ) locations 
    On locations.authorised_value = item_information.location
  Left Join itemtypes 
    On itemtypes.itemtype = item_information.itype
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'CCODE'
  ) ccodes 
    On ccodes.authorised_value = item_information.ccode
  Left Join (
    Select statistics.itemnumber,
      Count(*) As count
    From statistics
    Where statistics.datetime < CurDate() - Interval 1 Year
      And (
        statistics.type = 'issue'
        Or statistics.type = 'renew'
      )
    Group By statistics.itemnumber
  ) last_twelve 
    On last_twelve.itemnumber = item_information.itemnumber
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'not_loan'
  ) not_loans 
    On not_loans.authorised_value = item_information.notforloan
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'damaged'
  ) damageds 
    On damageds.authorised_value = item_information.damaged
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'lost'
  ) losts 
    On losts.authorised_value = item_information.itemlost
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'withdrawn'
  ) withdrawns 
    On withdrawns.authorised_value = item_information.withdrawn
  Left Join (
    Select items.biblionumber,
      Count(items.itemnumber) As Count_itemnumber,
      items.homebranch
    From items
    Where 
      Coalesce(items.homebranch, 'NEKLS') LIKE <<Item home library|ZBRAN>>
    Group By items.biblionumber
  ) local_count 
    On local_count.biblionumber = item_information.biblionumber
  Left Join (
    Select items.biblionumber,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Group By items.biblionumber
  ) system_count 
    On system_count.biblionumber = item_information.biblionumber
WHERE
  Coalesce(item_information.STATUS_PROBLEMS, 'No') LIKE <<Display lost, missing, and withdrawn items|ZYES_NO>> AND
  Coalesce(item_information.damaged, 0) LIKE <<Damaged status|DAMAGED:all>> AND
  Coalesce(losts.lib_opac, '-') LIKE <<Lost status|LLOST>> AND 
  Coalesce(item_information.withdrawn, 0) LIKE <<Withdrawn status|WITHDRAWN:all>> AND 
  Coalesce(item_information.CKO_PLUS_RENEW, 0) <= <<With X or fewer checkouts|ZNUMBERS>> AND 
  Coalesce(item_information.CHECKED_OUT_NOW, 'No') LIKE <<Display checked out items|ZYES_NO>> AND 
  Coalesce(local_count.Count_itemnumber, 0) >= <<With X or more copies at this library|YNUMBER>> AND 
  Coalesce(system_count.Count_itemnumber, 0) >= <<With X or more copies at throughout the catalog|YNUMBER>>
Order By 
  HOME_LIBRARY,
  ITEM_PERMANENT_LOCATION,
  ITEM_ITYPE,
  ITEM_COLLECTION_CODE,
  CALL_NUMBER,
  AUTHOR,
  item_information.FULL_TITLE,
  ITEM_NUMBER DESC
/*
R.003868

----------

Name: GHW - Waiting requests cancelled in the last 7 days
Created by: George Williams

----------

Group: -
     -

Created on: 2024-11-08 17:56:09
Modified on: 2025-05-19 10:12:50
Date last run: 2025-05-19 10:14:11

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

  <div id="next_report_introduction-3868" class="">
    <p class="">Shows items cancelled from hold shelf in the last 7 days</p>
    <p class=""><strong>Report created by: </strong>GHW</p>
  </div>

  <div id="next_report_accordion-3868" class="accordion accordion-flush">

    <div id="next_report_function" class="accordion-item ">
      <h2 class="accordion-header" id="headingOne">
        <button class="accordion-button next_report_function" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne-3868" aria-expanded="true" aria-controls="collapseOne">
            Report function:
        </button>
      </h2>

      <div id="collapseOne-3868" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#next_report_accordion-3868">
        <div class="accordion-body">
          <ul>
            <li>Shows the items waiting on the hold shelf for pickup where the hold was cancelled in the last 7 days</li>
            <li>on the hold shelf at the library you specify</li>
            <li>grouped by reserve_id number</li>
            <li>sorted by library where the item was held and the card number of the borrower the item was held for</li>
            <li>links to the bibliogrpahic record of the item</li>
          </ul>

        </div>
      </div>
    </div>

    <div id="next_report_notes" class="accordion-item ">
      <h2 class="accordion-header" id="headingTwo">
        <button class="accordion-button collapsed next_report_notes" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo-3868" aria-expanded="false" aria-controls="collapseTwo">
          Report notes:
        </button>
      </h2>
      <div id="collapseTwo-3868" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#next_report_accordion-3868">
        <div class="accordion-body">

          <div id="next_report_notes-1" class="next_report_section ">
            <h3>HELD_FOR_CARD_NUMBER</h3>
            <p>The report only shows the first 3 letters of the borrower's lat name and the last 6 digits of the borrower's card number in order to protect the borrower's privacy.</p>
          </div>

          <div id="next_report_notes-2" class="next_report_section ">
            <h3>CANCELLED_BY</h3>
            <p>The report shows the home library and borrower category of the user that cancelled the request</p>
          </div>

          <div id="next_report_notes-3" class="next_report_section ">
            <h3>CANCELLED_USING_THE</h3>
            <p><ul>  <li>API = probably cancelled using Aspen Discovery or Aspen Lida</li>  <li>Cron job = cancelled automatically by Koha</li>  <li>Koha staff client = A library staff member cancelled this request</li>  <li>OPAC = Cancelled via the Koha OPAC</li></ul></p>
          </div>

          <div id="next_report_notes-4" class="next_report_section next_hidden">
            <h3>~Notes heading 4~</h3>
            <p>~Notes sample 4~</p>
          </div>

          <div id="next_report_notes-5" class="next_report_section next_hidden">
            <h3>~Notes heading 5~</h3>
            <p>~Notes sample 5~</p>
          </div>

        </div>
      </div>
    </div>

    <div id="next_report_instruction" class="accordion-item next_hidden">
      <h2 class="accordion-header" id="headingThree">
        <button class="accordion-button collapsed next_report_instruction" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree-3868" aria-expanded="false" aria-controls="collapseThree">
          Report instructions:
        </button>
      </h2>
      <div id="collapseThree-3868" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#next_report_accordion-3868">
        <div class="accordion-body">

          <div class="next_report_section next_hidden">
            <h3>~heading 1~</h3>
            <p id="next_report_instruction-1">
              Instructions go here
            </p>
          </div>

          <div class="next_report_section next_hidden">
            <h3>~heading 2~</h3>
            <p id="next_report_instruction-2">
              Instructions go here
            </p>
          </div>

          <div class="next_report_section next_hidden">
            <h3>~heading 3~</h3>
            <p id="next_report_instruction-3">
              Instructions go here
            </p>
          </div>

          <div class="next_report_section next_hidden">
            <h3>~heading 4~</h3>
            <p id="next_report_instruction-4">
              Instructions go here
            </p>
          </div>

          <div class="next_report_section ">
            <h3>~heading 5~</h3>
            <p id="next_report_instruction-5">
              Instructions go here
            </p>
          </div>

        </div>
      </div>
    </div>

    <div id="next_report_resources" class="accordion-item next_hidden">
      <h2 class="accordion-header" id="headingFour">
        <button class="accordion-button collapsed next_report_resources" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour-3868" aria-expanded="false" aria-controls="collapseFour">
          Report external resources:
        </button>
      </h2>

      <div id="collapseFour-3868" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#next_report_accordion-3868">
        <div class="accordion-body">

          <ul style="list-style-type: none;">

            <li class="next_hidden"></li>
              ~Link 1 description~<br>
              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2">~Link 1~</a><br>
            </li>

            <li class="next_hidden"></li>
              ~Link 2 description~<br>
              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2">~Link 2~</a><br>
            </li>

            <li class="next_hidden"></li>
              ~Link 3 description~<br>
              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2">~Link 3~</a><br>
            </li>

            <li class="next_hidden"></li>
              ~Link 4 description~<br>
              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2">~Link 4~</a><br>
            </li>

            <li class="next_hidden"></li>
              ~Link 5 description~<br>
              <a href="/cgi-bin/koha/mainpage.pl" target="_blank" class="next_btn next_violet next_embiggen2">~Link 5~</a><br>
            </li>

          </ul>

        </div>
      </div>
    </div>

  </div>

  <div id="next_report_tags" class="next_hidden">
    <p>
      #requests: 
      #holds: 
      #hold shelf: 
      #cancellations: 

    </p>
  </div>

  <div id="next_report_training" class="next_report_training next_hidden">
    <br><br>
    <a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/mainpage.pl" target="_blank">Training page for report 3868 <i class="bi bi-arrow-up-right-square"></i></a>
    <br>
    <a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/mainpage.pl" target="_blank">Printable instructions for report 3868 <i class="bi bi-download"></i></a>
    <br>
    <a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/mainpage.pl" target="_blank">Training video for report 3868 <i class="bi bi-play-btn-fill"></i></a>
  </div>

  <div id="next_direct_download" class="next_direct_download next_hidden">
    <br><br>
    <a class="next_btn next_indigo next_embiggen2" href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3868" target="_blank">Download this report as a csv file <i class="bi bi-download"></i></a>
    <br>
  </div>

  <div class="next_report_note_collapse next_hidden">
    <br><br>
    <button type="button" id="next_report_notes_hide" class="next_btn next_indigo next_report_notes_close">Collapse report notes</button>
    <br>
  </div>

</div>


----------
*/



SELECT
  branches.branchname AS HELD_AT,
  Concat_Ws('<br>', 
    Concat(Left(borrowers.surname, 3)),
    Concat(Right(borrowers.cardnumber, 6))
  ) AS HELD_FOR_CARD_NUMBER,
  Concat_Ws('<br>', 
    Concat(homebranches.branchname), 
    Concat(locs.lib),
    Concat(itemtypes.description), 
    Concat(ccodes.lib),
    Concat(items.itemcallnumber), 
    Concat(biblio.author), 
    Concat(biblio.title),
    Concat(items.barcode)
  ) AS ITEM_HELD,
  old_reserves.cancellationdate AS CANCELLED_ON,
  Concat_Ws(' ', 
    staffs.branchcode, 
    staffs.categorycode
  ) AS CANCELLED_BY,
  CASE
    WHEN action_logs.interface = 'api' THEN 'API'
    WHEN action_logs.interface = 'cron' THEN 'Cron job'
    WHEN action_logs.interface = 'intranet' THEN 'Koha staff client'
    WHEN action_logs.interface = 'opac' THEN 'OPAC'
    ELSE action_logs.interface
  END AS CANCELLED_USING_THE,
  Concat( 
    '<a class="btn btn-default noprint" ', 
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    old_reserves.biblionumber, 
    '\" target="_blank">Go to title</a>' 
  ) AS LINK_TO_RECORD
FROM
  old_reserves JOIN
  action_logs ON action_logs.object = old_reserves.reserve_id RIGHT JOIN
  branches ON old_reserves.branchcode = branches.branchcode LEFT JOIN
  items ON old_reserves.itemnumber = items.itemnumber JOIN
  biblio ON items.biblionumber = biblio.biblionumber LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) locs 
    ON locs.authorised_value = items.permanent_location 
  LEFT JOIN branches homebranches 
    ON homebranches.branchcode = items.homebranch 
  LEFT JOIN itemtypes 
    ON itemtypes.itemtype = items.itype 
  LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
  ) ccodes ON ccodes.authorised_value = items.ccode 
  LEFT JOIN borrowers 
    ON borrowers.borrowernumber = old_reserves.borrowernumber 
  LEFT JOIN borrowers staffs 
    ON staffs.borrowernumber = action_logs.user
WHERE
  branches.branchcode LIKE <<Choose your library|branches:all>> AND
  action_logs.module = 'HOLDS' AND
  action_logs.action = 'CANCEL' AND
  old_reserves.found = 'W' AND
  old_reserves.cancellationdate > Now() - INTERVAL 7 DAY
GROUP BY
  old_reserves.reserve_id
ORDER BY
  HELD_AT,
  HELD_FOR_CARD_NUMBER


























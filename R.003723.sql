/*
R.003723

----------

Name: GHW - BASEHOR e-mails by date range
Created by: George H Williams

----------

Group:  BASEHOR
     -

Created on: 2023-04-03 15:50:55
Modified on: 2023-04-04 09:56:36
Date last run: 2023-04-29 14:57:42

----------

Public: 0
Expiry: 300

----------

<div id="reportinfo" class="noprint reportInfo"> 
 
  <div class="reportInfoContent"> 
 
    <p>Generates a list of e-mail addresses for borrowers with a BASEHOR home library based on borrowers date enrolled.</p> 
 
    <ul> 
      <li>Shows borrower emails with an enrollment date during the date range you specify.</li> 
      <li>at BASEHOR</li> 
      <li>grouped and sorted by email address</li> 
    </ul> 
 
  </div>

  <div class="reportInfoNotes">

    <p> 

    </p> 
 
    <p> 
      BASEHOR was previously using report 555 to accomplish this function.
     </p> 

    <p> 
 
    </p> 
   
  </div> 
 
  <div id="reportInfoLinks"> 
 
    <input id="report_data_copy_btn" type="button" style="display: none;" value="Copy table data to clipboard">
 
  </div>

  <div id="reportInfoTags">

    <p style="display: none;">
      #basehor 
      #email 
    </p>

  </div>
 
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 

</div> 

----------
*/



SELECT
  borrowers.email AS EMAIL
FROM
  borrowers JOIN
  categories ON borrowers.categorycode = categories.categorycode
WHERE
  borrowers.email NOT LIKE '' AND
  borrowers.branchcode = 'BASEHOR' AND
  borrowers.categorycode LIKE <<Borrower cateogory|categorycode:all>> AND
  borrowers.dateenrolled BETWEEN <<Between date1|date>> AND <<and date2|date>>
GROUP BY
  borrowers.email
LIMIT
  250


























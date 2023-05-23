/*
R.001907

----------

Name: GHW - Notices sent to a specific borrower
Created by: Heather Braum

----------

Group: Notices
     -

Created on: 2013-06-11 15:32:54
Modified on: 2023-03-29 16:25:19
Date last run: 2023-03-29 16:32:31

----------

Public: 0
Expiry: 0

----------

<div id="reportinfo" class="noprint reportInfo"> 
 
  <div class="report_info_instructions"> 
 
    <p> 
      Generates a report of all notices automatically sent to a borrower. 
    </p> 
 
    <ul> 
      <li>Shows messages that were queued within the previous 190 days</li> 
      <li>For the borrower you choose</li> 
      <li>grouped by message ID number</li> 
      <li>sorted by newest date to oldest date</li> 
    </ul> 
 
    <p> 
      <ins>Notes:</ins> 
    </p> 
 
    <p> 
 
    </p> 
 
    <p> 
      Notice templates can include HTML code.  When we upgraded to Koha 22.11 the way that sent notices display on a borrower's "Notices" tab has changed.  Due to some of the HTML we use in our notice templates and the changes in Koha, sometimes the content of sent notices does not display as expected in Koha 22.11.  This report allows you to view sent notices that may not be visible on a borrower's "Notices" tab. 
    </p> 
 
    <p> 
      The long-term fix for this problem is to update the CSS and HTML in all sent notices so that they will no longer conflict with the "Notices" tab. 
    </p> 
 
  </div> 
 
  <div class="report_info_tags" style="display: none;"> 
 
    <p class="notetags"> 
      #notices 
    </p> 
 
  </div> 
 
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
 
</div> 

----------
*/



Select 
  Concat_Ws( 
    '<br />', 
    Concat('Subject: ', message_queue.subject), 
    '', 
    Concat( 
      'Message type: ', 
      message_queue.message_transport_type 
    ), 
    Concat('Message status: ', message_queue.status), 
    '', 
    Concat('To: ', message_queue.to_address), 
    Concat('From: ', message_queue.from_address), 
    '', 
    Concat('Time created: ', message_queue.time_queued), 
    Concat('Time sent: ', message_queue.updated_on) 
  ) As META_DATA, 
  message_queue.content As MESSAGE_CONTENT 
From message_queue 
  Join borrowers On message_queue.borrowernumber = borrowers.borrowernumber 
Where 
  borrowers.cardnumber Like <<Enter library card number>> 
Group By 
  message_queue.time_queued, 
  message_queue.updated_on, 
  message_queue.subject, 
  message_queue.message_id 
Order By 
  message_queue.message_id Desc 


























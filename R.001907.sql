/*
R.001907

----------

Name: GHW - Notices sent to a specific borrower
Created by: Heather Braum

----------

Group: Notices
     -

Created on: 2013-06-11 15:32:54
Modified on: 2024-01-17 11:15:24
Date last run: 2023-03-29 16:32:31

----------

Public: 0
Expiry: 0

----------

 
 
   
 
     
      Generates a report of all notices automatically sent to a borrower. 
     
 
     
      Shows messages that were queued within the previous 190 days 
      For the borrower you choose 
      grouped by message ID number 
      sorted by newest date to oldest date 
     
 
     
      Notes: 
     
 
     
 
     
 
     
      Notice templates can include HTML code.  When we upgraded to Koha 22.11 the way that sent notices display on a borrower's "Notices" tab has changed.  Due to some of the HTML we use in our notice templates and the changes in Koha, sometimes the content of sent notices does not display as expected in Koha 22.11.  This report allows you to view sent notices that may not be visible on a borrower's "Notices" tab. 
     
 
     
      The long-term fix for this problem is to update the CSS and HTML in all sent notices so that they will no longer conflict with the "Notices" tab. 
     
 
   
 
   
 
     
      #notices 
     
 
   
 
   
 
 

----------
*/



Select 
  Concat_Ws( 
    '', 
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
  borrowers.cardnumber Like &lt;&gt; 
Group By 
  message_queue.time_queued, 
  message_queue.updated_on, 
  message_queue.subject, 
  message_queue.message_id 
Order By 
  message_queue.message_id Desc 


























/*
R.003723

----------

Name: GHW - BASEHOR e-mails by date range
Created by: George Williams

----------

Group:  BASEHOR
     -

Created on: 2023-04-03 15:50:55
Modified on: 2025-07-03 10:34:34
Date last run: 2026-01-26 15:47:50

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt;  
 
  &lt;div class="reportInfoContent"&gt; 
 
    &lt;p&gt;Generates a list of e-mail addresses for borrowers with a BASEHOR home library based on borrowers date enrolled.&lt;/p&gt; 
 
    &lt;ul&gt; 
      &lt;li&gt;Shows borrower emails with an enrollment date during the date range you specify.&lt;/li&gt; 
      &lt;li&gt;at BASEHOR&lt;/li&gt; 
      &lt;li&gt;grouped and sorted by email address&lt;/li&gt; 
    &lt;/ul&gt; 
 
  &lt;/div&gt;

  &lt;div class="reportInfoNotes"&gt;

    &lt;p&gt; 

    &lt;/p&gt; 
 
    &lt;p&gt; 
      BASEHOR was previously using report 555 to accomplish this function.
     &lt;/p&gt; 

    &lt;p&gt; 
 
    &lt;/p&gt; 
   
  &lt;/div&gt; 
 
  &lt;div id="reportInfoLinks"&gt; 
 
    &lt;input id="report_data_copy_btn" type="button" style="display: none;" value="Copy table data to clipboard"&gt;
 
  &lt;/div&gt;

  &lt;div id="reportInfoTags"&gt;

    &lt;p style="display: none;"&gt;
      #basehor 
      #email 
    &lt;/p&gt;

  &lt;/div&gt;
 
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 

&lt;/div&gt; 

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
  borrowers.categorycode LIKE &lt;&gt; AND
  borrowers.dateenrolled BETWEEN &lt;&gt; AND &lt;&gt;
GROUP BY
  borrowers.email
LIMIT
  250


























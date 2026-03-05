/*
R.003788

----------

Name: GHW - Local use statistics by bibliogrpahic record
Created by: George Williams

----------

Group: -
     -

Created on: 2023-12-20 17:32:59
Modified on: 2024-03-01 16:34:55
Date last run: 2024-03-18 09:47:53

----------

Public: 0
Expiry: 300

----------

&lt;div id="reportinfo" class="reportInfo noprint"&gt; 
 
  &lt;div class="reportInfoContent"&gt; 
 
    &lt;p&gt;Shows bibliographic records by author and title that had "localuse" checkouts&lt;/p&gt; 
 
    &lt;ul&gt; 
      &lt;li&gt;during the previous calendar month&lt;/li&gt; 
      &lt;li&gt;at the library you specify&lt;/li&gt; 
      &lt;li&gt;grouped and sorted by library, author, and title&lt;/li&gt;  
    &lt;/ul&gt; 
 
  &lt;/div&gt; 
 
  &lt;div class="reportInfoNotes"&gt; 

    &lt;p&gt; 
 
    &lt;/p&gt; 

    &lt;p&gt;Collecting local use data requires the use of a "Staff - statistical purposes" library card.&lt;/p&gt;

    &lt;p&gt; 
 
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoTags"&gt; 
 
    &lt;p style="display: none;"&gt; 
      #localuse
      #statistics
      #previous_month 
    &lt;/p&gt; 
 
  &lt;/div&gt; 

----------
*/



SELECT
  branches.branchname AS LIBRARY,
  biblio.author,
  biblio.title,
  Count(statistics.datetime) AS LOCAL_USE_COUNT
FROM
  branches 
    JOIN statistics 
      ON statistics.branch = branches.branchcode 
    LEFT JOIN items 
      ON items.itemnumber = statistics.itemnumber 
    LEFT JOIN biblio 
      ON items.biblionumber = biblio.biblionumber
WHERE
  statistics.type = 'localuse' AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  branches.branchcode LIKE &lt;&gt;
GROUP BY
  branches.branchname,
  biblio.author,
  biblio.title
ORDER BY 
  branches.branchname,
  biblio.author,
  biblio.title


























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

<div id="reportinfo" class="reportInfo noprint"> 
 
  <div class="reportInfoContent"> 
 
    <p>Shows bibliographic records by author and title that had "localuse" checkouts</p> 
 
    <ul> 
      <li>during the previous calendar month</li> 
      <li>at the library you specify</li> 
      <li>grouped and sorted by library, author, and title</li>  
    </ul> 
 
  </div> 
 
  <div class="reportInfoNotes"> 

    <p> 
 
    </p> 

    <p>Collecting local use data requires the use of a "Staff - statistical purposes" library card.</p>

    <p> 
 
    </p> 
 
  </div> 
 
  <div id="reportInfoTags"> 
 
    <p style="display: none;"> 
      #localuse
      #statistics
      #previous_month 
    </p> 
 
  </div> 

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


























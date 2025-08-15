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

 
 
   
 
    Shows bibliographic records by author and title that had "localuse" checkouts 
 
     
      during the previous calendar month 
      at the library you specify 
      grouped and sorted by library, author, and title  
     
 
   
 
   

     
 
     

    Collecting local use data requires the use of a "Staff - statistical purposes" library card.

     
 
     
 
   
 
   
 
     
      #localuse
      #statistics
      #previous_month 
     
 
   

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


























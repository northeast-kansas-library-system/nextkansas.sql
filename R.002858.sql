/*
R.002858

----------

Name: GHW - Items more than XX days overdue
Created by: George Williams

----------

Group: Fines/Fees
     -

Created on: 2016-12-15 16:10:39
Modified on: 2024-01-17 11:46:41
Date last run: 2025-09-24 11:22:34

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Lists patrons with items more than XX days overdue at a specified library&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows patrons who currently have overdues&lt;/li&gt;
&lt;li&gt;that were checked out at the specified location&lt;/li&gt;
&lt;li&gt;grouped by&lt;/li&gt;
&lt;li&gt;sorted by patron name, card number, and date due&lt;/li&gt;
&lt;li&gt;links to the patron record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Report created at the request of HIAWATHA.&lt;/p&gt;
&lt;p&gt;Essentially the same as report 350 - just with fewer fields.&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2858&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat_Ws('', 
    Concat(
      borrowers.firstname, 
      ' ', 
      borrowers.surname
    ),  
    (
      IF(
        borrowers.address2 = "", 
        borrowers.address, 
        Concat(borrowers.address, '', borrowers.address2)
      )
    ), 
    Concat(
      borrowers.city, 
      ', ',  
      borrowers.state, 
      ' ', 
      borrowers.zipcode
    ),
    borrowers.categorycode
  ) AS ADDRESS,
  borrowers.firstname,
  borrowers.surname,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  (To_Days(CurDate()) - To_Days(issues.date_due)) AS DAYS_OVERDUE,
  items.replacementprice
FROM
  borrowers JOIN
  issues
    ON borrowers.borrowernumber = issues.borrowernumber JOIN
  items
    ON issues.itemnumber = items.itemnumber JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  biblioitems
    ON biblio.biblionumber = biblioitems.biblionumber
WHERE
  (To_Days(CurDate()) - To_Days(issues.date_due)) &gt; &lt;&gt; AND
  issues.branchcode LIKE &lt;&gt;
GROUP BY
  items.itemnumber,
  issues.date_due
ORDER BY
  borrowers.surname,
  borrowers.firstname,
  borrowers.cardnumber,
  issues.date_due


























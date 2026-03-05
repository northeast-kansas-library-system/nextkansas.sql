/*
R.003267

----------

Name: GHW - ISBN errors
Created by: George Williams

----------

Group: -
     -

Created on: 2019-09-25 09:45:18
Modified on: 2024-01-17 12:09:03
Date last run: 2026-01-09 09:55:07

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of bibliographic records with parentheses in the 020$a field&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows records where the ISBN contains data that should go in the 020$q field rather than the $a field&lt;/li&gt;
&lt;li&gt;lists records at all libraries&lt;/li&gt;
&lt;li&gt;grouped and sorted by biblionumber&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3267&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3267"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  biblio.biblionumber,
  biblio.author,
  biblio.title,
  biblioitems.isbn,
  biblioitems.itemtype
FROM
  biblio
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber
WHERE
  biblioitems.isbn LIKE '%(%' AND
  biblioitems.itemtype &lt;&gt; 'DIGITAL'
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.biblionumber DESC


























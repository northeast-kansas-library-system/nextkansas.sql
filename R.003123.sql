/*
R.003123

----------

Name: GHW - Checkout count by index term
Created by: George Williams

----------

Group: -
     -

Created on: 2018-09-19 10:13:02
Modified on: 2024-01-17 11:57:50
Date last run: 2024-08-26 23:39:55

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Counts checkouts and renewals at a library based on an index term (marc field 655$a)&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows circulation in the previous 24 months (will not include current month or partial months)&lt;/li&gt;
&lt;li&gt;checked out at the library you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by year, month, and owning library&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;The search will be conducted based on the term or terms you enter.  For example, if you enter "Fiction" you will see all results where at least one 655$a contains the word "Fiction" - i.e. Fiction, Fantasy fiction, Legal fiction, Horror fiction, Romance fiction, etc.  If you put in "Fantasy fiction" you will only see results where at least one 655$a contains the phrase "Fantasy fiction" in that order with the space between the two words.  The search is not case sensitive so "legal" and "Legal" will return the same results.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Also note that any home branch code that ends with "-deleted" indicates a title that checked out in the month specified but has been deleted from the catalog within the last 13 months.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;To check a word or phrase to see how many titles in the catalog contain that word or phrase in the 655$a, run report 3124 (&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3124&phase=Run%20this%20report"  target="_blank"&gt;click here to run report 3124 in a new window.&lt;/a&gt;)&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3123&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  statistics.branch AS CKO_BRANCH,
  Year(statistics.datetime) AS YEAR,
  Date_Format(statistics.datetime, '%m') AS MONTH,
  items.homebranch AS HOMEBRANCH,
  Count(DISTINCT statistics.itemnumber) AS ISSUE_RENEW
FROM
  statistics
  LEFT JOIN items ON statistics.itemnumber = items.itemnumber
  LEFT JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
WHERE
  statistics.datetime &gt; AddDate(Last_Day(SubDate(Now(), INTERVAL 25 MONTH)), 1) AND
  statistics.datetime &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
  (statistics.type = 'issue' OR
    statistics.type = 'renew') AND
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="655"]/subfield[@code="a"]') LIKE @subj := CONCAT("%", &lt;&gt;, "%") COLLATE utf8mb4_unicode_ci) AND
  (statistics.branch LIKE @brn := &lt;&gt; COLLATE utf8mb4_unicode_ci)
GROUP BY
  statistics.branch,
  Year(statistics.datetime),
  Date_Format(statistics.datetime, '%m'),
  items.homebranch
UNION
SELECT
  statistics.branch AS CKO_BRANCH,
  Year(statistics.datetime) AS YEAR,
  Date_Format(statistics.datetime, '%m') AS MONTH,
  Concat(deleteditems.homebranch, "-deleted item") AS HOMEBRANCH,
  Count(DISTINCT statistics.itemnumber) AS ISSUE_RENEW
FROM
  statistics
  LEFT JOIN deleteditems ON statistics.itemnumber = deleteditems.itemnumber
  LEFT JOIN deletedbiblio_metadata ON deleteditems.biblionumber = deletedbiblio_metadata.biblionumber
WHERE
  statistics.datetime &gt; AddDate(Last_Day(SubDate(Now(), INTERVAL 25 MONTH)), 1) AND
  statistics.datetime &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
  (statistics.type = 'issue' OR
    statistics.type = 'renew') AND
  (ExtractValue(deletedbiblio_metadata.metadata, '//datafield[@tag="655"]/subfield[@code="a"]') LIKE @subj) AND
  (statistics.branch LIKE @brn)
GROUP BY
  statistics.branch,
  Year(statistics.datetime),
  Date_Format(statistics.datetime, '%m'),
  deleteditems.homebranch
UNION
SELECT
  statistics.branch AS CKO_BRANCH,
  Year(statistics.datetime) AS YEAR,
  Date_Format(statistics.datetime, '%m') AS MONTH,
  Concat(deleteditems.homebranch, "-deleted item") AS HOMEBRANCH,
  Count(DISTINCT statistics.itemnumber) AS ISSUE_RENEW
FROM
  statistics
  LEFT JOIN deleteditems ON statistics.itemnumber = deleteditems.itemnumber
  LEFT JOIN biblio_metadata ON deleteditems.biblionumber = biblio_metadata.biblionumber
WHERE
  statistics.datetime &gt; AddDate(Last_Day(SubDate(Now(), INTERVAL 25 MONTH)), 1) AND
  statistics.datetime &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) AND
  (statistics.type = 'issue' OR
    statistics.type = 'renew') AND
  (ExtractValue(biblio_metadata.metadata, '//datafield[@tag="655"]/subfield[@code="a"]') LIKE @subj) AND
  (statistics.branch LIKE @brn)
GROUP BY
  statistics.branch,
  Year(statistics.datetime),
  Date_Format(statistics.datetime, '%m'),
  deleteditems.homebranch
ORDER BY
  YEAR,
  MONTH,
  HOMEBRANCH


























/*
R.002804

----------

Name: GHW - Accelerated Reader - Search by Interest level, Reading level, or Points
Created by: George Williams

----------

Group: Catalog Records and Items
     Reading Program Reports

Created on: 2016-10-11 19:15:05
Modified on: 2024-10-18 13:39:10
Date last run: 2024-10-18 13:39:32

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Accelerated reader report&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items currently in the catalog with "Accelerated Reader" information in the 526a field&lt;/li&gt;
&lt;li&gt;at a specified branch&lt;/li&gt;
&lt;li&gt;grouped by item home branch, call number information, author, and title&lt;/li&gt;
&lt;li&gt;sorted by interest level, grade level, and AR points&lt;/li&gt;
&lt;li&gt;contains links to the title's bibliographic record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2804&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  items.homebranch,
  items.itype,
  Concat_Ws('', items.location, authorised_values.lib, items.itemcallnumber) AS CALL_NUMBER,
  biblio.author,
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="a"]') AS PROGRAM,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="b"]') AS INTEREST_LEVEL,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="c"]') AS READING_LEVEL,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="526"]//subfield[@code="d"]') AS POINTS,
  Concat('Go to staff client') AS LINK_TO_STAFF,
  Concat('Go to OPAC') AS LINK_TO_OPAC
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN authorised_values ON items.ccode = authorised_values.authorised_value
  JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
WHERE
  items.homebranch LIKE &lt;&gt; AND
  authorised_values.category = "CCODE"
GROUP BY
  items.itemnumber
HAVING
  PROGRAM LIKE "Accelerated Reader%" AND
  INTEREST_LEVEL LIKE &lt;&gt; AND
  READING_LEVEL LIKE &lt;&gt; AND
  POINTS LIKE &lt;&gt;
ORDER BY
  PROGRAM,
  INTEREST_LEVEL,
  READING_LEVEL,
  POINTS


























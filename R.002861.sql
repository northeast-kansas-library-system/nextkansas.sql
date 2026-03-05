/*
R.002861

----------

Name: GHW - Top 200 circulations
Created by: George Williams

----------

Group: Circulation
     Circ Stats

Created on: 2016-12-19 10:09:30
Modified on: 2024-01-17 11:46:37
Date last run: 2026-01-15 15:37:41

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows the check-out count for the top 200 most circulated items&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows check-outs during the specified date range&lt;br /&gt;(between the beginning of the day on the specified "START DATE" to the end of the day on the specified "END DATE")&lt;/li&gt;
&lt;li&gt;Can be limited to items checked out at a specified library, with a specified home branch, shelving location, item type, and collection code&lt;/li&gt;
&lt;li&gt;grouped by author and title&lt;/li&gt;
&lt;li&gt;sorted by most check-outs to least check-outs&lt;/li&gt;
&lt;li&gt;limited to 200 rows&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report was updated and fixed on January 5, 2022&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Please note that, because this report gathers data from the issues and oldissues tables in Koha, you cannot see accurate data from more than 13 months old.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Also note that this report cannot count the circulation of items that have been deleted.  If an item circulates 50 times on Tuesday, but is deleted on Wednesday, it will not be counted by this report if the report is run on Thursday.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;ins&gt;The report will almost certainly fail if you use extremely broad parameters.  If you try to run this report with "All libraries" as the checkout branch, "All libraries" as the item home branch, and no limits on shelving locations, item types, or collection codes and a date range longer than just a few weeks, the report will almost certainly fail and may slow down Koha while it runs.&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2861&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat(
    '', 
    items.biblionumber, 
    ''
  ) AS LINK_TO_TITLE,
  Concat_Ws(' / ', 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]')
  ) AS LOC_TYPE_CCODE,
  biblio.author,
  Concat_Ws(' ', 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS TITLE,
  Count(DISTINCT allissues.issue_id) AS CIRCULATION_COUNT
FROM
  (SELECT
      issues.issue_id,
      issues.itemnumber,
      issues.branchcode,
      issues.issuedate
    FROM
      issues
    WHERE
      issues.branchcode LIKE &lt;&gt; AND
      issues.issuedate BETWEEN 
        &lt;&gt; AND 
        (&lt;&gt; + INTERVAL 1 DAY)
    GROUP BY
      issues.issue_id,
      issues.itemnumber,
      issues.branchcode,
      issues.issuedate
    UNION
    SELECT
      old_issues.issue_id,
      old_issues.itemnumber,
      old_issues.branchcode,
      old_issues.issuedate
    FROM
      old_issues
    WHERE
      old_issues.branchcode LIKE &lt;&gt; AND
      old_issues.issuedate BETWEEN 
        &lt;&gt; AND 
        (&lt;&gt; + INTERVAL 1 DAY)
    GROUP BY
      old_issues.issue_id,
      old_issues.itemnumber,
      old_issues.branchcode,
      old_issues.issuedate) allissues  JOIN
  items ON items.itemnumber = allissues.itemnumber  JOIN
  biblio ON items.biblionumber = biblio.biblionumber  JOIN
  biblio_metadata ON biblio_metadata.biblionumber = items.biblionumber
WHERE
  items.homebranch LIKE &lt;&gt; AND
  items.permanent_location LIKE &lt;&gt; AND
  items.itype LIKE &lt;&gt; AND
  items.ccode LIKE &lt;&gt;
GROUP BY
  biblio.biblionumber
ORDER BY
  CIRCULATION_COUNT DESC
LIMIT 200


























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
Date last run: 2025-06-17 10:06:03

----------

Public: 0
Expiry: 0

----------

 
Shows the check-out count for the top 200 most circulated items
Shows check-outs during the specified date range(between the beginning of the day on the specified "START DATE" to the end of the day on the specified "END DATE")
Can be limited to items checked out at a specified library, with a specified home branch, shelving location, item type, and collection code
grouped by author and title
sorted by most check-outs to least check-outs
limited to 200 rows

Notes:

This report was updated and fixed on January 5, 2022

Please note that, because this report gathers data from the issues and oldissues tables in Koha, you cannot see accurate data from more than 13 months old.

Also note that this report cannot count the circulation of items that have been deleted.  If an item circulates 50 times on Tuesday, but is deleted on Wednesday, it will not be counted by this report if the report is run on Thursday.

The report will almost certainly fail if you use extremely broad parameters.  If you try to run this report with "All libraries" as the checkout branch, "All libraries" as the item home branch, and no limits on shelving locations, item types, or collection codes and a date range longer than just a few weeks, the report will almost certainly fail and may slow down Koha while it runs.
Click here to run in a new window


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


























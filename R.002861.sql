/*
R.002861

----------

Name: GHW - Top 200 circulations
Created by: George H Williams

----------

Group: Circulation
     Circ Stats

Created on: 2016-12-19 10:09:30
Modified on: 2022-01-05 12:12:15
Date last run: 2022-01-05 14:07:20

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows the check-out count for the top 200 most circulated items</p>
<ul><li>Shows check-outs during the specified date range<br />(between the beginning of the day on the specified "START DATE" to the end of the day on the specified "END DATE")</li>
<li>Can be limited to items checked out at a specified library, with a specified home branch, shelving location, item type, and collection code</li>
<li>grouped by author and title</li>
<li>sorted by most check-outs to least check-outs</li>
<li>limited to 200 rows</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report was updated and fixed on January 5, 2022</p>
<p></p>
<p>Please note that, because this report gathers data from the issues and oldissues tables in Koha, you cannot see accurate data from more than 13 months old.</p>
<p></p>
<p>Also note that this report cannot count the circulation of items that have been deleted.  If an item circulates 50 times on Tuesday, but is deleted on Wednesday, it will not be counted by this report if the report is run on Thursday.</p>
<p></p>
<p><ins>The report will almost certainly fail if you use extremely broad parameters.  If you try to run this report with "All libraries" as the checkout branch, "All libraries" as the item home branch, and no limits on shelving locations, item types, or collection codes and a date range longer than just a few weeks, the report will almost certainly fail and may slow down Koha while it runs.</ins></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2861&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',
  items.biblionumber, '\" target="_blank">', items.biblionumber, '</a>') AS
  LINK_TO_TITLE,
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
      issues.branchcode LIKE <<Choose check-out branch|ZBRAN>> AND
      issues.issuedate BETWEEN 
        <<Count checkouts between the beginning of the day on|date>> AND 
        (<<and the end of the day on|date>> + INTERVAL 1 DAY)
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
      old_issues.branchcode LIKE <<Choose check-out branch|ZBRAN>> AND
      old_issues.issuedate BETWEEN 
        <<Count checkouts between the beginning of the day on|date>> AND 
        (<<and the end of the day on|date>> + INTERVAL 1 DAY)
    GROUP BY
      old_issues.issue_id,
      old_issues.itemnumber,
      old_issues.branchcode,
      old_issues.issuedate) allissues  JOIN
  items ON items.itemnumber = allissues.itemnumber  JOIN
  biblio ON items.biblionumber = biblio.biblionumber  JOIN
  biblio_metadata ON biblio_metadata.biblionumber = items.biblionumber
WHERE
  items.homebranch LIKE <<Choose item homebranch|LBRANCH>> AND
  items.permanent_location LIKE <<Choose item permanent shelving location|LLOC>> AND
  items.itype LIKE <<Choose item type|LITYPES>> AND
  items.ccode LIKE <<Choose item collection code|LCCODE>>
GROUP BY
  biblio.biblionumber
ORDER BY
  CIRCULATION_COUNT DESC
LIMIT 200


























/*
R.002861

----------

Name: GHW - Top 200 circulations
Created by: George H Williams

----------

Group: Circulation
     Circ Stats

Created on: 2016-12-19 10:09:30
Modified on: 2018-11-01 12:03:20
Date last run: 2019-09-05 16:42:15

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
<p><ins>The report will almost certainly fail if you use extremely broad parameters.  If you try to run this report with "All libraries" as the checkout branch, "All libraries" as the item home branch, and no limits on shelving locations, item types, or collection codes and a date range longer than just a few weeks, the report will almost certainly fail and may slow down Koha while it runs.</ins></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2861&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', items.biblionumber, '\" target="_blank">', items.biblionumber, '</a>') AS LINK_TO_TITLE,
  biblio.author,
  Concat_Ws(' ',
    biblio.title,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS TITLE,
  Count(all_issues.issue_id) AS Count_issue_id
FROM
  items JOIN
  (SELECT
    issues.issue_id,
    issues.itemnumber,
    issues.branchcode,
    issues.renewals,
    issues.issuedate
  FROM
    issues
  UNION
  SELECT
    old_issues.issue_id,
    old_issues.itemnumber,
    old_issues.branchcode,
    old_issues.renewals,
    old_issues.issuedate
  FROM
    old_issues) all_issues
        ON items.itemnumber = all_issues.itemnumber JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  all_issues.branchcode LIKE <<Choose check-out branch|ZBRAN>> AND
  items.homebranch LIKE <<Choose item homebranch|LBRANCH>> AND
  items.location LIKE <<Choose item shelving location|LLOC>> AND
  items.itype LIKE <<Choose item type|LITYPES>> AND
  items.ccode LIKE <<Choose item collection code|LCCODE>> AND
  all_issues.issuedate BETWEEN <<Count checkouts between start date|date>> AND (<<and end date|date>> + interval 1 day)
GROUP BY
  biblio.author, biblio.title
ORDER BY
  Count_issue_id DESC, biblio.author, biblio.title ASC
LIMIT 200




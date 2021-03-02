/*
R.003406

----------

Name: koha-US Test 2106
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-01-15 12:23:01
Modified on: 2021-01-15 13:02:07
Date last run: 2021-01-15 16:14:11

----------

Public: 0
Expiry: 300

----------

Top 200 circs last year

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
  items.itype LIKE <<Choose item type|LITYPES>> AND
  items.ccode LIKE <<Choose item collection code|LCCODE>> AND
  YEAR(all_issues.issuedate) = 2020
GROUP BY
  biblio.author, biblio.title
ORDER BY
  Count_issue_id DESC, biblio.author, biblio.title ASC
LIMIT 200




/*
R.003193

----------

Name: GHW - Bibliographic records scheduled for auto-deletion
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-04-08 23:53:17
Modified on: 2019-04-10 09:01:50
Date last run: 2020-11-10 15:57:41

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>List of bibliographic records that will be deleted on Sunday morning.</p>
<ul><li>Shows bibliographic records that currently meet the criteria for deletion</li>
<li>at all locations</li>
<li>grouped by biblionumber</li>
<li>sorted by author and title</li>
<li>contains links to the bibliographic records</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="https://will1410.github.io/next.training/cronjobs/cronjobs.html#empty-bibliographic-record-deletion"  target="_blank">Click here</a> for more information</p>
<p></p>
<p>Replaces reports 1061 and 2356</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3193&limit=500"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3193">Click here to download as a csv file</a></p>
</div>

----------
*/

SELECT
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY) + INTERVAL 1 WEEK AS SCHEDULED_DELETION,
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">LINK</a>') AS LINK,
  biblio.biblionumber,
  biblio.author,
  biblio.title,
  biblio.datecreated,
  lastdeletes.Max_timestamp AS LAST_DELETED_ON,
  borrowers.branchcode AS LAST_DELETED_AT
FROM
  biblio
  LEFT JOIN items
    ON biblio.biblionumber = items.biblionumber
  JOIN biblioitems
    ON biblio.biblionumber = biblioitems.biblionumber
  LEFT JOIN (
    SELECT
      deleteditems.itemnumber,
      deleteditems.biblionumber,
      Max(deleteditems.timestamp) AS Max_timestamp
    FROM
      deleteditems
    GROUP BY
      deleteditems.biblionumber
  ) lastdeletes
    ON lastdeletes.biblionumber = biblio.biblionumber
  LEFT JOIN action_logs
    ON action_logs.object = lastdeletes.itemnumber
  LEFT JOIN borrowers
    ON borrowers.borrowernumber = action_logs.user
WHERE
  items.itemnumber IS NULL AND
  biblioitems.url IS NULL AND
  biblio.datecreated < Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) AND
  action_logs.action LIKE 'del%'
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.author,
  biblio.title
  ASC




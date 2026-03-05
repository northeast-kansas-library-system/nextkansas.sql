/*
R.003193

----------

Name: GHW - Bibliographic records scheduled for auto-deletion
Created by: George Williams

----------

Group: -
     -

Created on: 2019-04-08 23:53:17
Modified on: 2024-01-17 11:54:39
Date last run: 2020-11-10 15:57:41

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;List of bibliographic records that will be deleted on Sunday morning.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows bibliographic records that currently meet the criteria for deletion&lt;/li&gt;
&lt;li&gt;at all locations&lt;/li&gt;
&lt;li&gt;grouped by biblionumber&lt;/li&gt;
&lt;li&gt;sorted by author and title&lt;/li&gt;
&lt;li&gt;contains links to the bibliographic records&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="https://will1410.github.io/next.training/cronjobs/cronjobs.html#empty-bibliographic-record-deletion"  target="_blank"&gt;Click here&lt;/a&gt; for more information&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Replaces reports 1061 and 2356&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3193&limit=500"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3193"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) - 1 DAY) + INTERVAL 1 WEEK AS SCHEDULED_DELETION,
  Concat('LINK') AS LINK,
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
  biblio.datecreated &lt; Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) AND
  action_logs.action LIKE 'del%'
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.author,
  biblio.title
  ASC


























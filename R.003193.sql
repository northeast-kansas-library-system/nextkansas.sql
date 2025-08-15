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

 
List of bibliographic records that will be deleted on Sunday morning.
Shows bibliographic records that currently meet the criteria for deletion
at all locations
grouped by biblionumber
sorted by author and title
contains links to the bibliographic records

Notes:

Click here for more information

Replaces reports 1061 and 2356

Click here to run in a new window
Click here to download as a csv file


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


























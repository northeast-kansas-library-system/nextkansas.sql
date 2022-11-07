/*
R.003670

----------

Name: GHW - Circulation last month by list name
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-10-06 12:24:20
Modified on: 2022-10-20 15:18:00
Date last run: 2022-10-21 15:19:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
  <p>Shows count of issues and renewal counts for items that are on public lists (virtualshelves)</p>
  <ul>
    <li>Shows checkout and renewal counts for the previous calendar month</li>
    <li>at all Next Search Catalog libraries</li>
    <li>grouped and sorted by shelf name</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Written at the request of Dan Alexander.</p>
  <p></p>
  <p class= "notetags" style="display: none;">#lists #circulation_statistics</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div> 

----------
*/



SELECT
  Concat(
    '<a class="btn btn-default btn-xs noprint"', 
    'href="/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=',
    virtualshelves.shelfnumber,
    '" target="_blank">Staff interface</a>'
  ) as STAFF,
  virtualshelves.shelfname AS LIST_NAME,
  Count(DISTINCT virtualshelfcontents.biblionumber) AS TITLES_IN_LIST,
  Sum(list_cko_data.Sum_CKO_COUNT) AS CIRC_RENEW_COUNT_LM,
  Concat(
    '<a class="btn btn-default btn-xs noprint"', 
    'href="https://nextkansas.org/cgi-bin/koha/opac-shelves.pl?op=view&shelfnumber=',
    virtualshelves.shelfnumber,
    '" target="_blank">OPAC</a>'
  ) as STAFF
FROM
  virtualshelves 
  JOIN
    virtualshelfcontents 
  ON virtualshelfcontents.shelfnumber = virtualshelves.shelfnumber 
  LEFT JOIN
    (
      SELECT
        items.biblionumber,
        Sum(item_cko_data.CKO_COUNT) AS Sum_CKO_COUNT
      FROM
        items 
        JOIN
          (
            SELECT
              statistics.itemnumber,
              Count(*) AS CKO_COUNT
            FROM
              statistics
            WHERE
              (statistics.type = 'issue' OR
                statistics.type = 'renew') AND
              Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
              Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH)
            GROUP BY
              statistics.itemnumber
            ORDER BY
              CKO_COUNT DESC
          ) item_cko_data 
        ON item_cko_data.itemnumber =  items.itemnumber
      GROUP BY
        items.biblionumber
    ) list_cko_data 
  ON list_cko_data.biblionumber = virtualshelfcontents.biblionumber
WHERE
  virtualshelves.public = 1
GROUP BY
  virtualshelves.shelfname
ORDER BY
  LIST_NAME


























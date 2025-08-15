/*
R.003670

----------

Name: GHW - Circulation last month by list name
Created by: George Williams

----------

Group: -
     -

Created on: 2022-10-06 12:24:20
Modified on: 2024-01-17 11:29:27
Date last run: 2022-10-21 15:19:01

----------

Public: 0
Expiry: 300

----------

 
  Shows count of issues and renewal counts for items that are on public lists (virtualshelves)
  
    Shows checkout and renewal counts for the previous calendar month
    at all Next Search Catalog libraries
    grouped and sorted by shelf name
  
  Notes:
  
  Written at the request of Dan Alexander.
  
  #lists #circulation_statistics
  
 

----------
*/



SELECT
  Concat(
    'Staff interface'
  ) as STAFF,
  virtualshelves.shelfname AS LIST_NAME,
  Count(DISTINCT virtualshelfcontents.biblionumber) AS TITLES_IN_LIST,
  Sum(list_cko_data.Sum_CKO_COUNT) AS CIRC_RENEW_COUNT_LM,
  Concat(
    'OPAC'
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


























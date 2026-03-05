/*
R.003866

----------

Name: GHW - Circulation last month by biblio
Created by: George Williams

----------

Group: -
     -

Created on: 2024-10-23 16:51:21
Modified on: 2024-10-30 11:08:31
Date last run: 2024-10-23 17:53:23

----------

Public: 0
Expiry: 300

----------

Work in progress - do not run

----------
*/



SELECT
  branches.branchname AS SHOWS,
  titles.permanent_location,
  titles.title,
  current_item_count.count AS ITEMS_IN_CATALOG,
  added_lm.count AS ADDED_LM,
  deleted_lm.count AS DELETED_LM,
  cko_renew_lm.count AS CKO_RENEW_LM,
  localuse_lm.count AS LOCAL_USE_LM
FROM
  branches JOIN
  (SELECT
      biblio.biblionumber,
      biblio.title,
      Coalesce(items.homebranch, deleteditems.homebranch) AS homebranch,
      Coalesce(items_loc.lib, deleteditems.permanent_location) AS
      permanent_location
    FROM
      items RIGHT JOIN
      biblio ON items.biblionumber = biblio.biblionumber LEFT JOIN
      deleteditems ON deleteditems.biblionumber = biblio.biblionumber LEFT JOIN
      authorised_values items_loc ON items_loc.authorised_value =
          items.permanent_location
    WHERE
      items.homebranch = 'horton' AND
      items.itype LIKE 'P_MAG%' AND
      items_loc.category = 'LOC'
    GROUP BY
      biblio.biblionumber,
      biblio.title,
      Coalesce(items_loc.lib, deleteditems.permanent_location),
      items.homebranch
    UNION
    SELECT
      deletedbiblio.biblionumber,
      deletedbiblio.title,
      deleteditems.homebranch,
      authorised_values.lib AS location
    FROM
      deletedbiblio LEFT JOIN
      deleteditems ON deleteditems.biblionumber = deletedbiblio.biblionumber
      JOIN
      authorised_values ON authorised_values.authorised_value =
          deleteditems.permanent_location
    WHERE
      deleteditems.homebranch LIKE 'HORTON' AND
      deleteditems.itype LIKE 'P_MAG%' AND
      authorised_values.category = 'LOC'
    GROUP BY
      deletedbiblio.biblionumber,
      deletedbiblio.title,
      deleteditems.homebranch,
      authorised_values.lib) titles ON titles.homebranch = branches.branchcode
  LEFT JOIN
  (SELECT
      items.biblionumber,
      Count(DISTINCT items.itemnumber) AS count
    FROM
      items
    WHERE
      items.homebranch LIKE 'HORTON' AND
      items.itype LIKE 'P_MAG%'
    GROUP BY
      items.biblionumber) current_item_count ON current_item_count.biblionumber
      = titles.biblionumber LEFT JOIN
  (SELECT
      items.biblionumber,
      Count(DISTINCT items.itemnumber) AS count
    FROM
      items
    WHERE
      items.itype LIKE 'P_MAG%' AND
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
      items.homebranch LIKE 'HORTON'
    GROUP BY
      items.biblionumber) added_lm ON added_lm.biblionumber =
      titles.biblionumber LEFT JOIN
  (SELECT
      deleteditems.biblionumber,
      Count(DISTINCT deleteditems.itemnumber) AS count
    FROM
      deleteditems
    WHERE
      deleteditems.itype LIKE 'P_MAG%' AND
      Month(deleteditems.deleted_on) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(deleteditems.deleted_on) = Year(Now() - INTERVAL 1 MONTH) AND
      deleteditems.homebranch LIKE 'HORTON'
    GROUP BY
      deleteditems.biblionumber) deleted_lm ON deleted_lm.biblionumber =
      titles.biblionumber LEFT JOIN
  (SELECT
      Coalesce(items.biblionumber, deleteditems.biblionumber) AS biblionumber,
      statistics.branch,
      statistics.itemtype,
      Count(statistics.datetime) AS count
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN
      deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      statistics.branch LIKE 'HORTON' AND
      statistics.itemtype LIKE 'P_MAG%' AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      Coalesce(items.biblionumber, deleteditems.biblionumber)) cko_renew_lm ON
      cko_renew_lm.biblionumber = titles.biblionumber LEFT JOIN
  (SELECT
      Coalesce(items.biblionumber, deleteditems.biblionumber) AS biblionumber,
      statistics.branch,
      statistics.itemtype,
      Count(statistics.datetime) AS count
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN
      deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      statistics.branch LIKE 'HORTON' AND
      statistics.itemtype LIKE 'P_MAG%' AND
      statistics.type = 'localuse' AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      Coalesce(items.biblionumber, deleteditems.biblionumber)) localuse_lm ON
      localuse_lm.biblionumber = titles.biblionumber
ORDER BY
  titles.permanent_location,
  branches.branchname,
  titles.title


























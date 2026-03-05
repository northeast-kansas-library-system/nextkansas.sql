/*
R.003873

----------

Name: koha-us 003
Created by: George Williams

----------

Group: -
     -

Created on: 2025-01-14 16:38:23
Modified on: 2025-01-14 23:10:11
Date last run: 2025-01-14 23:10:33

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  items_subquery.title,
  items_subquery.barcode,
  items_subquery.dateaccessioned,
  items_subquery.datelastborrowed,
  items_subquery.issues,
  items_subquery.renewals,
  items_subquery.onloan,
  items_subquery.biblionumber,
  items_subquery.itemnumber,
  items_subquery.description,
  annual_statistics.Group_Concat_datetime,
  Coalesce(annual_statistics.COUNT, 0) as COUNT
From
  (
    Select
      biblio.title,
      items.barcode,
      items.dateaccessioned,
      items.datelastborrowed,
      items.issues,
      items.renewals,
      items.onloan,
      itemtypes.description,
      items.biblionumber,
      items.itemnumber
    From
      biblio Join
      items On items.biblionumber = biblio.biblionumber Inner Join
      itemtypes On itemtypes.itemtype = items.itype
    Where
      items.itype LIKE &lt;&gt;
    Order By
      biblio.title
  ) items_subquery 
  Left Join
  (
    Select
      statistics.itemnumber,
      Group_Concat(
        statistics.datetime 
        ORDER BY statistics.datetime 
        DESC Separator ' // '
      ) As Group_Concat_datetime,
      Count(statistics.datetime) As COUNT
    From
      statistics
    Where
      (statistics.type = 'issue' Or
       statistics.type = 'renew') And
      Year(statistics.datetime) 
        Like &lt;&gt; And
      Month(statistics.datetime) 
        Like Concat('%', &lt;&gt; , '%')
    Group By
      statistics.itemnumber
  ) annual_statistics 
  On annual_statistics.itemnumber = items_subquery.itemnumber
Group By
  items_subquery.itemnumber,
  annual_statistics.Group_Concat_datetime,
  annual_statistics.COUNT


























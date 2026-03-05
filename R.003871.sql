/*
R.003871

----------

Name: koha-us 001
Created by: George Williams

----------

Group: -
     -

Created on: 2025-01-14 16:28:54
Modified on: 2025-01-14 16:39:09
Date last run: 2025-01-14 17:35:37

----------

Public: 0
Expiry: 300

----------



----------
*/



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


























/*
R.003125

----------

Name: GHW - Circulation desk transactions on a specified date
Created by: George Williams

----------

Group: -
     -

Created on: 2018-09-26 11:42:19
Modified on: 2024-01-17 11:56:17
Date last run: 2025-08-20 10:45:43

----------

Public: 0
Expiry: 300

----------

 
List of transactions at the circulation desk at the library you specify
Shows transactions on the date you specify
shows transactions that occurred at the library you specify
grouped and sorted by library, time the transaction occurred, and the item number

Notes:

This report cannot be used to show any transactions more than 25 months old.
Shelving location information was not stored in the transaction logs until we upgraded to Koha 17.11 on 2018.07.28.

Report changed to show item permanent location in addition to current location at time of circulation.

Click here to run in a new window


----------
*/



SELECT
  statistics.branch AS TRANSACTION_BRANCH,
  If(statistics.type = "issue", "checkout", statistics.type) AS STATISTIC_TYPE,
  statistics.datetime,
  Upper(Coalesce(items.barcode, deleteditems.barcode)) AS ITEM_BC,
  permlocs.lib AS PERMANENT_LOCATION,
  locations.lib AS SHELVING_LOCATION,
  itemtypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  Coalesce(items.itemcallnumber, deleteditems.itemcallnumber) AS CALL_NUMBER,
  biblio.author,
  biblio.title AS `TITLE (245$a only)`,
  If(deleteditems.barcode IS NOT NULL, 
    "Item has been deleted", 
    If(statistics.type = "payment", 
      "No item data for payments", 
      If(statistics.type = "writeoff", 
        "No item data for writeoffs", 
        If(statistics.type = "return", 
          "Shelving loction not recorded for returns", 
          "-"
        )
      )
    )) AS NOTES
FROM
  statistics LEFT JOIN
  items ON statistics.itemnumber = items.itemnumber LEFT JOIN
  deleteditems ON statistics.itemnumber = deleteditems.itemnumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc') locations ON statistics.location =
      locations.authorised_value LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itemtypes ON statistics.itemtype = itemtypes.itemtype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON statistics.ccode =
      ccodes.authorised_value LEFT JOIN
  biblio ON items.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc') permlocs ON permlocs.authorised_value = items.permanent_location
WHERE
  statistics.branch like &lt;&gt; AND
  statistics.datetime LIKE Concat(&lt;&gt;, "%") AND
  If(
    statistics.type = "renew",
    "renew-issue",
    If(
      statistics.type = "issue",
      "issue-renew", statistics.type
    )
  ) LIKE &lt;&gt;
GROUP BY
  statistics.branch,
  statistics.datetime,
  permlocs.lib,
  statistics.itemnumber
ORDER BY
  TRANSACTION_BRANCH,
  statistics.datetime,
  statistics.itemnumber


























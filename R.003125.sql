/*
R.003125

----------

Name: GHW - Circulation desk transactions on a specified date
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-09-26 11:42:19
Modified on: 2021-10-26 12:23:30
Date last run: 2022-07-25 11:49:32

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>List of transactions at the circulation desk at the library you specify</p>
<ul><li>Shows transactions on the date you specify</li>
<li>shows transactions that occurred at the library you specify</li>
<li>grouped and sorted by library, time the transaction occurred, and the item number</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report cannot be used to show any transactions more than 25 months old.</p>
<p>Shelving location information was not stored in the transaction logs until we upgraded to Koha 17.11 on 2018.07.28.</p>
<p></p>
<p class="updated">Report changed to show item permanent location in addition to current location at time of circulation.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3125&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
  statistics.branch like <<Choose the circulating library|branches>> AND
  statistics.datetime LIKE Concat(<<Choose a date|date>>, "%") AND
  If(
    statistics.type = "renew",
    "renew-issue",
    If(
      statistics.type = "issue",
      "issue-renew", statistics.type
    )
  ) LIKE <<Choose a transaction type|LSTATTYPE>>
GROUP BY
  statistics.branch,
  statistics.datetime,
  permlocs.lib,
  statistics.itemnumber
ORDER BY
  TRANSACTION_BRANCH,
  statistics.datetime,
  statistics.itemnumber


























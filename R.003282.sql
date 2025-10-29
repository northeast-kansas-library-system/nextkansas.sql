/*
R.003282

----------

Name: GHW - Item dashboard
Created by: George Williams

----------

Group: -
     -

Created on: 2019-11-22 13:25:34
Modified on: 2025-04-07 13:35:11
Date last run: 2025-10-27 11:21:13

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Retrieves data and associated reports information based on an item barcode number</p>
<ul><li>Shows current data</li>
<li>for the item barcode number you specify</li>
<li>grouped and sorted by item number</li>
<li>links to the item record, the item's bibliographic record, report 2785, report 3342, report 2784, and report 3039 -- unless the item has already been deleted</li>
<li>if the item has already been deleted, there are links to report 3009</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Replaces report 3113</p>
<p></p>
<p class= "notetags" style="display: none;">dashboard</p>
</div>

----------
*/



SELECT
  Concat_Ws('',
    'This item is currently in the catalog',
    Concat('You searched for: "', Trim(&lt;&gt;), '"'),
    Concat('Item homebranch: ', items.homebranch),
    Concat('Current branch: ', items.holdingbranch),
    Concat('Permanent shelving location: ', items.permanent_location),
    Concat('Current shelving location: ', items.location),
    Concat('Item type: ', items.itype),
    Concat('Collection code: ', ccodes.lib),
    Concat('Call#: ', items.itemcallnumber),
    Concat('Author: ', biblio.author),
    Concat('Title: ',
      UPPER(
        Concat_Ws(' ',
          biblio.title,
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
          ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
        )
      )
    ),
    Concat('Item barcode: ', Upper(items.barcode)),
    Concat('Public notes: ', items.itemnotes),
    Concat('Non-public notes: ', items.itemnotes_nonpublic),
    Concat('Total circulation: ', (Sum((Coalesce(items.issues, 0)) + (Coalesce(items.renewals, 0))))),
    Concat('(', items.issues, ' checkouts + ', items.renewals, ' renewals)'),
    Concat('Date added: ', items.dateaccessioned),
    Concat('Last borrowed: ', items.datelastborrowed),
    Concat('Last seen: ', items.datelastseen),
    Concat('Circs in the previous 12 months: ', statistics_one.last_one),
    Concat('Circs in the previous 24 months: ', statistics_two.last_two),
    Concat('Item record last modified: ', items.timestamp),
    Concat('Due date: ', If(issuesi.date_due IS NULL, "-", Date_Format(issuesi.date_due, "%Y.%m.%d"))),
    Concat("Not for loan status: ", If(items.notforloan = 0, "-", If(items.notforloan IS NULL, "-", nfl.lib))),
    Concat("Damaged status: ", If(items.damaged = 0, "-", If(items.damaged IS NULL, "-", damagedi.lib))),
    Concat("Lost status: ", If(items.itemlost = 0, "-", If(items.itemlost IS NULL, "-", Concat(losti.lib, " on ", items.itemlost_on)))),
    Concat("Withdrawn status: ", If(items.withdrawn = 0, "-", If(items.withdrawn IS NULL, "- ", Concat(withdrawni.lib, " on ", items.withdrawn_on)))),
    Concat(" In transit from ", If(transfersi.frombranch IS NULL, "-", Concat(transfersi.frombranch, " to ", transfersi.tobranch, " since ", transfersi.datesent))),
    Concat("Link to borrower: ", If(issuesi.date_due IS NULL, "-", Concat("go to the borrower's account"))),
    Concat("Link to title: ", Concat("go to the bibliographic record")),
    Concat("Link to item: ", Concat("go to the item record")),
    Concat("Item circ history: ", Concat("see item circ history")),
    Concat("Item action log history: ", Concat("see action log history")), 
    Concat("Item in transit history: ", Concat("see item transit history")), 
    Concat("Request history on this title: ", Concat("see title's request history")),    
    Concat("Request history on this item: ", Concat("see item's request history")), 
    Concat("Search payment and fee notes and descriptions for this item barcode number"),
    'This item is currently in the catalogit has not been deleted'
  ) AS INFO
FROM
  items
  JOIN biblio
    ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber AND
      items.biblionumber = biblio_metadata.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
  ) ccodes
    ON items.ccode = ccodes.authorised_value
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN'
  ) nfl
    ON items.notforloan = nfl.authorised_value
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damagedi
    ON items.damaged = damagedi.authorised_value
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losti
    ON items.itemlost = losti.authorised_value
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) withdrawni
    ON items.withdrawn = withdrawni.authorised_value
  LEFT JOIN (
    SELECT
      branchtransfers.itemnumber,
      branchtransfers.frombranch,
      branchtransfers.datesent,
      branchtransfers.tobranch,
      branchtransfers.datearrived
    FROM
      branchtransfers
    WHERE
      branchtransfers.datearrived IS NULL
  ) transfersi
    ON items.itemnumber = transfersi.itemnumber
  LEFT JOIN (
    SELECT
      issues.itemnumber,
      issues.date_due,
      issues.borrowernumber
    FROM
      issues
  ) issuesi
    ON items.itemnumber = issuesi.itemnumber 
  LEFT JOIN (
    SELECT
      statistics.itemnumber,
      Count(*) AS last_one
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      statistics.datetime &gt; CurDate() - INTERVAL 1 YEAR
    GROUP BY
      statistics.itemnumber) statistics_one ON statistics_one.itemnumber = items.itemnumber 
  LEFT JOIN (
     SELECT
      statistics.itemnumber,
      Count(*) AS last_two
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      statistics.datetime &gt; CurDate() - INTERVAL 2 YEAR
    GROUP BY
      statistics.itemnumber) statistics_two ON statistics_two.itemnumber = items.itemnumber
WHERE
  items.barcode LIKE Concat("%", Trim(&lt;&gt;), "%")
GROUP BY
  items.itemnumber
UNION
SELECT
  Concat_Ws('',
    'This item has been deleted',
    Concat('You searched for: "', Trim(&lt;&gt;), '"'),
    Concat('At the time of its deletion on:  ', deleteditems.timestamp, " this item's information was as follows:"),
    Concat('Item homebranch: ', deleteditems.homebranch),
    Concat('Current branch: ', deleteditems.holdingbranch),
    Concat('Permanent shelving location: ', deleteditems.permanent_location),
    Concat('Current shelving location: ', deleteditems.location),
    Concat('Item type: ', deleteditems.itype),
    Concat('Collection code: ', ccodes.lib),
    Concat('Call#: ', deleteditems.itemcallnumber),
    Concat('Author: ', Coalesce(biblio.author, deletedbiblio.author)),
    Concat('Title: ', UPPER(Coalesce(biblio.title, deletedbiblio.title))),
    Concat('Item barcode: ', deleteditems.barcode),
    Concat('Replacement price: ', deleteditems.replacementprice),
    Concat('Item id number: ', deleteditems.itemnumber),
    Concat("Damaged status: ", If(deleteditems.damaged = 0, "-", If(deleteditems.damaged IS NULL, "-", damagedi.lib))),
    Concat("Lost status: ", If(deleteditems.itemlost = 0, "-", If(deleteditems.itemlost IS NULL, "-", Concat(losti.lib, " on ", deleteditems.itemlost_on)))),
    Concat("Withdrawn status: ", If(deleteditems.withdrawn = 0, "-", If(deleteditems.withdrawn IS NULL, "- ", Concat(deletedwithdrawni.lib, " on ", deleteditems.withdrawn_on)))),
    If(biblio.biblionumber IS NULL, "-- Bibliographic record has been deleted --", Concat("Go to the bibliographic record")),
    Concat("Search payment and fee notes and descriptions for this item barcode number"),
    'This item was deleted from the catalogwithin the past 13 months'
  ) AS INFO
FROM
  deleteditems
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
  ) ccodes
    ON deleteditems.ccode = ccodes.authorised_value
  LEFT JOIN biblio
    ON deleteditems.biblionumber = biblio.biblionumber
  LEFT JOIN deletedbiblio
    ON deleteditems.biblionumber = deletedbiblio.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damagedi
    ON damagedi.authorised_value = deleteditems.damaged
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losti
    ON losti.authorised_value = deleteditems.itemlost
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) deletedwithdrawni
    ON deletedwithdrawni.authorised_value = deleteditems.withdrawn
WHERE
  deleteditems.barcode LIKE Concat("%", Trim(&lt;&gt;), "%")
GROUP BY
  deleteditems.itemnumber
UNION
SELECT 
  Concat_WS('', 
    'Run report 3840 for close barcode matches',
    Concat('You searched for: "', Trim(&lt;&gt;), '"'),
    'Running report 3480 will look up the owning libraries for other barcode numbers close in sequence to this one.', 
    'For example, if you look up barcode number 10005, this report will tell you which libraries own barcode numbers 10001, 10002, 10003, 10004, 10006, 10007, 10008, etc.', 
    Concat(
      "Adjacent barcodes: ", 
      Concat(
        '&gt;), Char(43), "%2B"), Char(47), "%2F"), Char(32), "%20"), Char(45), "%2D"), Char(36), "%24"), Char(37), "%25"), Char(46), "%2E"), 
        '&op=run" target="_blank"&gt;Run report 3840 for barcode number ', Trim(&lt;&gt;), ''
      ),
      'Run report 3840 for close barcode matches'
    )
  ) AS INFO


























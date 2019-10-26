/*
R.002842

----------

Name: GHW - Single item reports dashboard
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-11-29 09:09:19
Modified on: 2019-08-14 13:26:53
Date last run: 2019-09-30 16:20:23

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Gives quick and easy data on a single item</p>
<ul><li>Shows current data on the item you specify</li>
<li>grouped by item number</li>
<li>sorted by the normal NExpress classification scheme</li>
<li>contains links to the borrower (if checked out), the title and item records and request history as well as the in-transit history</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Contains active links to reports 2784 and 3039</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2842&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat_Ws('<br />',
    Concat('Item homebranch: ', items.homebranch),
    Concat('Current branch: ', items.holdingbranch),
    Concat('Shelving location: ', items.location),
    Concat('Item type: ', items.itype),
    Concat('Collection code: ', ccodes.lib),
    Concat('Call#: ', items.itemcallnumber),
    Concat('Author: ', biblio.author),
    Concat('Title: ',
      Concat_Ws(' ',
        '<span style="text-transform: uppercase">',
        biblio.title,
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
        '</span>')),
    Concat('Item barcode: ', UPPER(items.barcode)),

    Concat('<br />Public notes: ', items.itemnotes),
    Concat('Non-public notes: ', items.itemnotes_nonpublic),

    Concat('<br />Total circ: ', (Sum((Coalesce(items.issues, 0)) + (Coalesce(items.renewals, 0))))),
    Concat('(', items.issues, ' checkouts + ', items.renewals, ' renewals)'),

    Concat('<br />Date added: ', items.dateaccessioned),
    Concat('Last borrowed: ', items.datelastborrowed),
    Concat('Last seen: ', items.datelastseen),
    Concat('Item record last modified: ', items.timestamp),

    Concat('<br />Due date: ', IF(issuesi.date_due is null, "-", DATE_FORMAT(issuesi.date_due, "%Y.%m.%d"))),
    Concat("Not for loan status: ", If(items.notforloan=0, "-", If(items.notforloan is null, "-", nfl.lib))),
    Concat("Damaged status: ", If(items.damaged=0, "-", If(items.damaged is null, "-", damagedi.lib))),
    Concat("Lost status: ", If(items.itemlost=0, "-", If(items.itemlost is null, "-", Concat(losti.lib, " on ", items.itemlost_on)))),
    Concat("Withdrawn status: ", If(items.withdrawn=0, "-", If(items.withdrawn is null, "- ", Concat(withdrawni.lib, " on ", items.withdrawn_on)))),

    Concat("<br /> In transit from ", If(transfersi.frombranch is null, "-", Concat(transfersi.frombranch, " to ", transfersi.tobranch, " since ", transfersi.datesent) ) ),

    Concat("<br />Link to borrower: ", IF(issuesi.date_due is null, "-", Concat("<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", issuesi.borrowernumber, "' target='_blank'>go to the borrower's account</a>"))),
    Concat("Link to title: ", Concat("<a href='/cgi-bin/koha/catalogue/detail.pl?biblionumber=", biblio.biblionumber, "' target='_blank'>go to the bibliographic record</a>")),
    Concat("Link to item: ", Concat("<a href='/cgi-bin/koha/catalogue/moredetail.pl?itemnumber=", items.itemnumber, "&biblionumber=", biblio.biblionumber, "' target='_blank'>go to the item record</a>")),
    Concat("Item in transit history: ", Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?reports=2784&phase=Run+this+report&sql_params=", items.barcode, "' target='_blank'>see item transit history</a>")),
    Concat("Request history on this title: ", Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?reports=3039&phase=Run+this+report&sql_params=%25&sql_params=%25&sql_params=%25&sql_params=%25&sql_params=%25&sql_params=", biblio.biblionumber, "&sql_params=%25' target='_blank'>see title's request history</a>")),
    Concat("Request history on this item: ", Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?reports=3039&phase=Run+this+report&sql_params=%25&sql_params=%25&sql_params=%25&sql_params=%25&sql_params=%25&sql_params=%25&sql_params=", items.barcode, "' target='_blank'>see item's request history</a>"))
    ) AS ITEM
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber AND items.biblionumber =
    biblio_metadata.biblionumber
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'CCODE'
      GROUP BY
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib) ccodes ON items.ccode = ccodes.authorised_value
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'NOT_LOAN'
      GROUP BY
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib) nfl ON items.notforloan = nfl.authorised_value
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'DAMAGED'
      GROUP BY
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib) damagedi ON items.damaged = damagedi.authorised_value
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'LOST'
      GROUP BY
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib) losti ON items.itemlost = losti.authorised_value
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'WITHDRAWN'
      GROUP BY
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib) withdrawni ON items.withdrawn = withdrawni.authorised_value
  LEFT JOIN (SELECT
        branchtransfers.itemnumber,
        branchtransfers.frombranch,
        branchtransfers.datesent,
        branchtransfers.tobranch,
        branchtransfers.datearrived
      FROM
        branchtransfers
      WHERE
        branchtransfers.datearrived IS NULL
      GROUP BY
        branchtransfers.itemnumber,
        branchtransfers.frombranch,
        branchtransfers.datesent,
        branchtransfers.tobranch,
        branchtransfers.datearrived) transfersi ON items.itemnumber = transfersi.itemnumber
  LEFT JOIN (SELECT
        issues.itemnumber,
        issues.date_due,
        issues.borrowernumber
      FROM
        issues) issuesi ON items.itemnumber = issuesi.itemnumber
WHERE
  items.barcode LIKE Concat("%", <<Enter item barcode number>>, "%")
GROUP BY
  items.itemnumber
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  ccodes.lib,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.barcode




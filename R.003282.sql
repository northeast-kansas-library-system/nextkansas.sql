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
Date last run: 2026-07-27 15:38:12

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
  Concat_Ws('<br />',
    '<h3 class="next_green next_banner">This item is currently in the catalog</h3>',
    Concat('<h4>You searched for: "', Trim(<<Enter barcode number>>), '"</h4>'),
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
    Concat('<br />Public notes: ', items.itemnotes),
    Concat('Non-public notes: ', items.itemnotes_nonpublic),
    Concat('<br />Total circulation: ', (Sum((Coalesce(items.issues, 0)) + (Coalesce(items.renewals, 0))))),
    Concat('(', items.issues, ' checkouts + ', items.renewals, ' renewals)'),
    Concat('<br />Date added: ', items.dateaccessioned),
    Concat('Last borrowed: ', items.datelastborrowed),
    Concat('Last seen: ', items.datelastseen),
    Concat('<br />Circs in the previous 12 months: ', statistics_one.last_one),
    Concat('Circs in the previous 24 months: ', statistics_two.last_two),
    Concat('<br />Item record last modified: ', items.timestamp),
    Concat('<br />Due date: ', If(issuesi.date_due IS NULL, "-", Date_Format(issuesi.date_due, "%Y.%m.%d"))),
    Concat("Not for loan status: ", If(items.notforloan = 0, "-", If(items.notforloan IS NULL, "-", nfl.lib))),
    Concat("Damaged status: ", If(items.damaged = 0, "-", If(items.damaged IS NULL, "-", damagedi.lib))),
    Concat("Lost status: ", If(items.itemlost = 0, "-", If(items.itemlost IS NULL, "-", Concat(losti.lib, " on ", items.itemlost_on)))),
    Concat("Withdrawn status: ", If(items.withdrawn = 0, "-", If(items.withdrawn IS NULL, "- ", Concat(withdrawni.lib, " on ", items.withdrawn_on)))),
    Concat("<br /> In transit from ", If(transfersi.frombranch IS NULL, "-", Concat(transfersi.frombranch, " to ", transfersi.tobranch, " since ", transfersi.datesent))),
    Concat("<br />Link to borrower: ", If(issuesi.date_due IS NULL, "-", Concat("<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", issuesi.borrowernumber, "' target='_blank'>go to the borrower's account</a>"))),
    Concat("Link to title: ", Concat("<a href='/cgi-bin/koha/catalogue/detail.pl?biblionumber=", biblio.biblionumber, "' target='_blank'>go to the bibliographic record</a>")),
    Concat("Link to item: ", Concat("<a href='/cgi-bin/koha/catalogue/moredetail.pl?itemnumber=", items.itemnumber, "&biblionumber=", biblio.biblionumber, "' target='_blank'>go to the item record</a>")),
    Concat("Item circ history: ", Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?id=2785&param_name=Enter+item+barcode+number&sql_params=", items.barcode, "&op=run' target='_blank'>see item circ history</a>")),
    Concat("Item action log history: ", Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?id=3342&param_name=Enter+item+number&sql_params=", items.itemnumber, "&op=run' target='_blank'>see action log history</a>")), 
    Concat("Item in transit history: ", Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?id=2784&param_name=Enter+item+barcode+number&sql_params=", items.barcode, "&op=run' target='_blank'>see item transit history</a>")), 
    Concat("Request history on this title: ", Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?id=3039&param_name=Choose+pickup+library|LBRANCH&sql_params=%25&param_name=Choose+request+status|LHOLDACT&sql_params=%25&param_name=Choose+request+progress|LHOLDPROG&sql_params=%25&param_name=Choose+suspended+status|LHOLDSUS&sql_params=%25&param_name=Enter+library+card+number+or+a+%25+symbol&sql_params=%25&param_name=Enter+title+biblio+number+or+a+%25+symbol&sql_params=", biblio.biblionumber, "&param_name=Enter+item+barcode+number+or+a+%25+symbol&sql_params=%25&op=run' target='_blank'>see title's request history</a>")),    
    Concat("Request history on this item: ", Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?id=3039&param_name=Choose+pickup+library|LBRANCH&sql_params=%25&param_name=Choose+request+status|LHOLDACT&sql_params=%25&param_name=Choose+request+progress|LHOLDPROG&sql_params=%25&param_name=Choose+suspended+status|LHOLDSUS&sql_params=%25&param_name=Enter+library+card+number+or+a+%25+symbol&sql_params=%25&param_name=Enter+title+biblio+number+or+a+%25+symbol&sql_params=%25&param_name=Enter+item+barcode+number+or+a+%25+symbol&sql_params=", items.barcode, "&op=run' target='_blank'>see item's request history</a>")), 
    Concat("<br /><br /><a href='/cgi-bin/koha/reports/guided_reports.pl?id=3009&param_name=Enter+item+barcode+number+or+other+search+terms&sql_params=", Replace(Replace(Replace(Replace(Replace(Replace(Replace(items.barcode, Char(43), "%2B"), Char(47), "%2F"), Char(32), "%20"), Char(45), "%2D"), Char(36), "%24"), Char(37), "%25"), Char(46), "%2E"), "&op=run&limit=50' target='_blank'>Search payment and fee notes and descriptions for this item barcode number</a>"),
    '<br /><h3 class="next_green next_banner">This item is currently in the catalog<br />it has not been deleted</h3>'
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
      statistics.datetime > CurDate() - INTERVAL 1 YEAR
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
      statistics.datetime > CurDate() - INTERVAL 2 YEAR
    GROUP BY
      statistics.itemnumber) statistics_two ON statistics_two.itemnumber = items.itemnumber
WHERE
  items.barcode LIKE Concat("%", Trim(<<Enter barcode number>>), "%")
GROUP BY
  items.itemnumber
UNION
SELECT
  Concat_Ws('<br />',
    '<h2 class="next_red next_banner">This item has been deleted</h2>',
    Concat('<h4>You searched for: "', Trim(<<Enter barcode number>>), '"</h4>'),
    Concat('At the time of its deletion on:  <ins><strong>', deleteditems.timestamp, "<br /></strong></ins> this item's information was as follows:<br />"),
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
    Concat("<br />Damaged status: ", If(deleteditems.damaged = 0, "-", If(deleteditems.damaged IS NULL, "-", damagedi.lib))),
    Concat("Lost status: ", If(deleteditems.itemlost = 0, "-", If(deleteditems.itemlost IS NULL, "-", Concat(losti.lib, " on ", deleteditems.itemlost_on)))),
    Concat("Withdrawn status: ", If(deleteditems.withdrawn = 0, "-", If(deleteditems.withdrawn IS NULL, "- ", Concat(deletedwithdrawni.lib, " on ", deleteditems.withdrawn_on)))),
    If(biblio.biblionumber IS NULL, "<br />-- Bibliographic record has been deleted --", Concat("<br /><a href='/cgi-bin/koha/catalogue/detail.pl?biblionumber=", biblio.biblionumber, "' target='_blank'>Go to the bibliographic record</a>")),
    Concat("<br /><br /><a href='/cgi-bin/koha/reports/guided_reports.pl?id=3009&param_name=Enter+item+barcode+number+or+other+search+terms&sql_params=", Replace(Replace(Replace(Replace(Replace(Replace(Replace(deleteditems.barcode, Char(43), "%2B"), Char(47), "%2F"), Char(32), "%20"), Char(45), "%2D"), Char(36), "%24"), Char(37), "%25"), Char(46), "%2E"), "&op=run&limit=50' target='_blank'>Search payment and fee notes and descriptions for this item barcode number</a>"),
    '<br /><h2 class="next_red next_banner">This item was deleted from the catalog<br />within the past 13 months</h2>'
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
  deleteditems.barcode LIKE Concat("%", Trim(<<Enter barcode number>>), "%")
GROUP BY
  deleteditems.itemnumber
UNION
SELECT 
  Concat_WS('<br />', 
    '<h2 class="next_violet next_banner">Run report 3840 for close barcode matches</h2>',
    Concat('<h4>You searched for: "', Trim(<<Enter barcode number>>), '"</h4>'),
    '<p>Running report 3480 will look up the owning libraries for other barcode numbers close in sequence to this one.</p>', 
    '<p>For example, if you look up barcode number 10005, this report will tell you which libraries own barcode numbers 10001, 10002, 10003, 10004, 10006, 10007, 10008, etc.</p>', 
    Concat(
      "Adjacent barcodes: ", 
      Concat(
        '<a href="/cgi-bin/koha/reports/guided_reports.pl?id=3840&param_name=Enter+barcode+number&sql_params=', 
        Replace(Replace(Replace(Replace(Replace(Replace(Replace(Trim(<<Enter barcode number>>), Char(43), "%2B"), Char(47), "%2F"), Char(32), "%20"), Char(45), "%2D"), Char(36), "%24"), Char(37), "%25"), Char(46), "%2E"), 
        '&op=run" target="_blank">Run report 3840 for barcode number ', Trim(<<Enter barcode number>>), '</a>'
      ),
      '<br /><h2 class="next_violet next_banner">Run report 3840 for close barcode matches</h2>'
    )
  ) AS INFO


























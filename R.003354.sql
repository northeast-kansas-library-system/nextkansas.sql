/*
R.003354

----------

Name: GHW - Items marked as "Withdrawn" in the previous calendar month at OTTAWA
Created by: George H Williams

----------

Group:  OTTAWA
     -

Created on: 2020-09-29 23:37:01
Modified on: 2021-08-16 13:44:19
Date last run: 2023-05-01 05:00:04

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates a list of items that were marked as "Withdrawn" in the previous calendar month at OTTAWA and shows the last patron to have had the item billed to their account</p>
<ul><li>Only shows items marked as "Withdrawn" in the previous calendar month</li>
<li>where OTTAWA is the item home branch</li>
<li>grouped by item number and biblionumber</li>
<li>sorted by home library, shelf location, item type, collection code, call number, author, and title</li>
<li>contains raw HTML links to the bibliographic record and to the borrower's account page</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Scheduled to automatically e-mail to OTTAWA staff on the first of each month.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3354&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3354">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">#ottawa, #withdrawn, #scheduled</p>
</div>

----------
*/



SELECT
  Concat('https://staff.nextkansas.org/cgi-bin/koha/catalogue/detail.pl?biblionumber=', items.biblionumber) AS LINK_TO_TITLE,
  items.itemnumber AS ITEM_NUMBER,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS ITEM_BARCODE,
  Concat_Ws(" // ", 
    items.homebranch, 
    items.holdingbranch, 
    Coalesce(locs.lib, "-"), 
    Coalesce(itypes.description, "-"), 
    Coalesce(ccodes.lib, "-"), 
    items.itemcallnumber, 
    items.copynumber, 
    biblio.author, 
    Concat_Ws(" ", 
      biblio.title, 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
    )
  ) AS ITEM_INFO,
  items.replacementprice,
  Date_Format(fees.date_due, '%Y-%m-%d') AS ITEM_DUE_DATE,
  withdrawnst.lib AS WITHDRAWN_STATUS,
  items.withdrawn_on,
  Concat_Ws(" | ", 
    Concat("Due on: ", items.onloan), 
    If(notloanst.lib = "", "", Concat("Not for loan status: ", notloanst.lib)), 
    Concat("Damaged status: ", damagedst.lib, "on", items.damaged_on), 
    Concat("Lost status: ", lostst.lib, "on", items.itemlost_on)
  ) AS OTHER_STATUSES,
  Concat('https://staff.nextkansas.org/cgi-bin/koha/members/pay.pl?borrowernumber=', fees.borrowernumber) AS LINK_TO_BORROWER,
  fees.cardnumber,
  Concat_Ws(", ", fees.surname, fees.firstname) AS BORROWERNAME,
  fees.date AS BILLING_DATE,
  fees.amountoutstanding,
  fees.branchcode AS CKO_AT,
  fees.debit_type_code,
  fees.description AS FEE_DESCRIPTION
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber JOIN
  biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN') notloanst ON
      notloanst.authorised_value = items.notforloan LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypes ON itypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED') damagedst ON
      damagedst.authorised_value = items.damaged LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST') lostst ON lostst.authorised_value =
      items.itemlost LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN') withdrawnst ON
      withdrawnst.authorised_value = items.withdrawn LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.location JOIN
  (SELECT
      accountlines.itemnumber,
      accountlines.issue_id,
      accountlines.borrowernumber,
      accountlines.date,
      accountlines.amountoutstanding,
      old_issues.branchcode,
      accountlines.debit_type_code,
      accountlines.description,
      accountlines.status,
      borrowers.cardnumber,
      borrowers.surname,
      borrowers.firstname,
      old_issues.date_due
    FROM
      accountlines JOIN
      old_issues ON old_issues.issue_id = accountlines.issue_id JOIN
      borrowers ON accountlines.borrowernumber = borrowers.borrowernumber
    WHERE
      accountlines.debit_type_code = 'LOST') fees ON fees.itemnumber =
      items.itemnumber
WHERE
  items.homebranch = "OTTAWA" AND
  withdrawnst.lib <> "" AND
  Month(items.withdrawn_on) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(items.withdrawn_on) = Year(Now() - INTERVAL 1 MONTH)
GROUP BY
  items.itemnumber,
  biblio.biblionumber
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  Trim(REGEXP_REPLACE(biblio.author, "[.,:;\/]", "")),
  Trim(REGEXP_REPLACE(Trim(LEADING 'a ' FROM Trim(LEADING 'an ' FROM Trim(LEADING 'the ' FROM Lower(biblio.title)))), "[.:;\"\'\/]", "")), 
  Trim(REGEXP_REPLACE(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), "[.:;\"\'\/]", "")), 
  Trim(REGEXP_REPLACE(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), "[.:;\"\'\/]", "")), 
  Trim(REGEXP_REPLACE(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), "[.:;\"\'\/]", ""))


























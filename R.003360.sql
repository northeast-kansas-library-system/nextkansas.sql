/*
R.003360

----------

Name: GHW - Borrowers who may owe money on lost items checked out at your library
Created by: George Williams

----------

Group: -
     -

Created on: 2020-10-28 17:01:35
Modified on: 2024-01-17 12:03:57
Date last run: 2026-01-29 09:48:40

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of borrowers who may owe money on lost items that were checked out at your library&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows borrowers who may owe money now&lt;/li&gt;
&lt;li&gt;on lost items that were checked out at the library you select&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber and item number&lt;/li&gt;
&lt;li&gt;sorted by borrower name and normal Next classification scheme&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3360&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;#lost #fees #borrowers&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  items.holdingbranch AS CKO_BRANCH,
  borrowers.cardnumber,
  CONCAT(
    If(borrowers.firstname &lt;&gt; '', Concat_Ws(', ', borrowers.surname, borrowers.firstname), borrowers.surname), 
    If(borrowers.othernames = '', '', Concat(', (', borrowers.othernames, ')'))
  ) AS NAME,
  CONCAT_WS(' | ', 
    borrowers.address, 
    borrowers.address2, 
    borrowers.city, 
    borrowers.state, 
    borrowers.zipcode
  ) AS ADDRESS,
  borrowers.phone,
  borrowers.email,
  FORMAT(borroweraccountlines.Sum_amountoutstanding, 2) AS TOTAL_FEES_DUE,
  FORMAT(itemaccountlines.amountoutstanding, 2) AS DUE_THIS_ITEM,
  items.barcode AS ITEM_BARCODE,
  CONCAT_WS(' | ', 
    items.homebranch, 
    locs.lib, 
    itemtypes.description, 
    ccodes.lib, 
    items.itemcallnumber, 
    biblio.author, 
    CONCAT_WS(' ', 
      biblio.title, 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
    )
  ) AS ITEM_INFO,
  losts.lib AS LOST_STATUS,
  items.replacementprice
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = "CCODE") ccodes ON items.ccode =
      ccodes.authorised_value LEFT JOIN
  (SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST') losts ON items.itemlost =
      losts.authorised_value JOIN
  biblio_metadata ON biblio.biblionumber = biblio_metadata.biblionumber
  LEFT JOIN
  items_last_borrower ON items_last_borrower.itemnumber = items.itemnumber
  LEFT JOIN
  itemtypes ON itemtypes.itemtype = items.itype JOIN
  borrowers ON items_last_borrower.borrowernumber = borrowers.borrowernumber
  JOIN
  (SELECT
      accountlines.borrowernumber,
      Sum(accountlines.amountoutstanding) AS Sum_amountoutstanding,
      accountlines.itemnumber
    FROM
      accountlines
    GROUP BY
      accountlines.borrowernumber
    HAVING
      Sum(accountlines.amountoutstanding) &lt;&gt; 0) borroweraccountlines ON
      borroweraccountlines.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.permanent_location LEFT JOIN
  (SELECT
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.amountoutstanding,
      accountlines.debit_type_code,
      accountlines.status
    FROM
      accountlines
    WHERE
      accountlines.amountoutstanding &lt;&gt; 0
    GROUP BY
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.amountoutstanding,
      accountlines.debit_type_code,
      accountlines.status) itemaccountlines ON itemaccountlines.borrowernumber =
      borrowers.borrowernumber AND
      itemaccountlines.itemnumber = items.itemnumber
WHERE
  items.holdingbranch LIKE &lt;&gt;
GROUP BY
  borrowers.borrowernumber,
  items.itemnumber
HAVING
  LOST_STATUS LIKE &lt;&gt;
ORDER BY
  borrowers.surname DESC,
  borrowers.firstname,
  items.homebranch,
  locs.lib,
  itemtypes.description,
  ccodes.lib,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')


























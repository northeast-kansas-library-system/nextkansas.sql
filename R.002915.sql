/*
R.002915

----------

Name: GHW - Flexible Item Status Report
Created by: George Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2017-03-01 09:17:47
Modified on: 2024-01-17 11:49:12
Date last run: 2026-01-12 12:51:57

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of items based on their status&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items currently in the system&lt;/li&gt;
&lt;li&gt;At the library you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by the normal Next Search Catalog classification scheme&lt;/li&gt;
&lt;li&gt;contains links to the item's bibliographic record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Replaces the following reports:&lt;/p&gt;
&lt;ul&gt;
&lt;li&gt;1420 - Items with a Lost Status&lt;/li&gt;
&lt;/ul&gt;
&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2915&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;


----------
*/



SELECT
  Concat(
    '', 
    biblio.biblionumber,
    ''
  ) AS LINK_TO_TITLE,
  items.itemnumber AS itemnumber,
  Concat("-", items.barcode, "-") AS BARCODE,
  items.homebranch,
  items.holdingbranch,
  permlocs.lib AS PERM_LOCATION,
  locs.lib AS LOCATION,
  itypes.description AS ITYPE,
  CCODES.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  items.copynumber,
  items.onloan,
  items.datelastborrowed,
  items.datelastseen,
  Coalesce(withdrawn.lib, "-") AS WITHDRAWN_STATUS,
  items.withdrawn_on,
  Coalesce(lost.lib, "-") AS LOST_STATUS,
  items.itemlost_on,
  Coalesce(damaged.lib, "-") AS DAMAGED_STATUS,
  Coalesce(not_for_loan.lib, "-") AS NOT_FOR_LOAN_STATUS,
  items.replacementprice,
  If(paidfor.amountoutstanding = 0, "$0.00 outstanding lost fees", "") AS OUTSTANDING_FEES,
  not_for_loan.lib_opac
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber AND
      items.biblionumber = biblio_metadata.biblionumber JOIN
  authorised_values ccode ON items.ccode = ccode.authorised_value LEFT JOIN
  (SELECT
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN') not_for_loan ON
      items.notforloan = not_for_loan.authorised_value LEFT JOIN
  (SELECT
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN') withdrawn ON
      items.withdrawn = withdrawn.authorised_value LEFT JOIN
  (SELECT
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST') lost ON items.itemlost =
      lost.authorised_value LEFT JOIN
  (SELECT
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.category,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED') damaged ON items.damaged =
      damaged.authorised_value LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypes ON itypes.itemtype = items.itype LEFT JOIN
  (SELECT
      accountlines.itemnumber,
      accountlines.amountoutstanding,
      accountlines.note,
      accountlines.credit_type_code,
      accountlines.debit_type_code
    FROM
      accountlines
    WHERE
      accountlines.amountoutstanding = 0 AND
      accountlines.debit_type_code LIKE 'L%') paidfor ON paidfor.itemnumber =
      items.itemnumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') permlocs ON
      permlocs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values) locs ON locs.authorised_value = items.location
  LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') CCODES ON CCODES.authorised_value =
      items.ccode
WHERE
  items.homebranch LIKE &lt;&gt; AND 
  Coalesce(lost.lib, "-") LIKE &lt;&gt; AND 
  items.damaged LIKE &lt;&gt; AND 
  items.withdrawn LIKE &lt;&gt; AND 
  Coalesce(not_for_loan.lib_opac, "-") LIKE &lt;&gt; 
GROUP BY
  items.itemnumber,
  CCODES.lib,
  not_for_loan.lib_opac,
  biblio.biblionumber
ORDER BY
  items.homebranch,
  PERM_LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE


























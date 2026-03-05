/*
R.003234

----------

Name: GHW - Patron count by extended attribute
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2019-07-24 13:40:33
Modified on: 2024-01-17 12:08:31
Date last run: 2025-02-10 14:52:48

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a count of patrons with extended attributes at your library&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Counts current patrons with attributes&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;allows you to specify a minimum patron count for displaying an attribute count (i.e. only show attributes assigned to at least X patrons)&lt;/li&gt;
&lt;li&gt;grouped and sorted by patron home branch, attribute category, and attribute&lt;/li&gt;
&lt;li&gt;contains links to report 3235 which will list all of the patrons at your library with the attribute specified&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Patrons can have multiple extended attributes on their accounts.  Similarly, patrons may not have any extended attributes on their accounts.  A total count of patrons from all of the rows of this report will not indicate an accurate count of total patrons at your library.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3234&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  columncreator.branchcode AS LIBRARY,
  Concat_Ws(' // ', columncreator.CAT_DESC, columncreator.AV_DESC) AS EXTENDED_ATTRIBUTE,
  Count(borrowerss.borrowernumber) AS PATRON_COUNT,
  Concat('Go to detailed report') AS LINK_TO_DETAILED_REPORT
FROM
  (
    SELECT
      branches.branchcode,
      attributess.CAT_DESC,
      attributess.CAT_CODE,
      attributess.AV_DESC,
      attributess.AV_CODE
    FROM
      branches,
      (
        SELECT
          borrower_attribute_types.code AS CAT_CODE,
          borrower_attribute_types.description AS CAT_DESC,
          If(authorised_values.authorised_value IS NULL, 'X', authorised_values.authorised_value) AS AV_CODE,
          authorised_values.lib AS AV_DESC
        FROM
          borrower_attribute_types
          LEFT JOIN authorised_values
            ON authorised_values.category = borrower_attribute_types.authorised_value_category
      ) attributess
    ORDER BY
      branches.branchcode
  ) columncreator
  LEFT JOIN (
    SELECT
      borrowers.branchcode,
      borrower_attributes.code,
      borrower_attributes.borrowernumber,
      If(borrower_attribute_types.authorised_value_category = '', 'X', borrower_attributes.attribute) AS attribute,
      borrower_attribute_types.authorised_value_category
    FROM
      borrowers
      INNER JOIN borrower_attributes
        ON borrower_attributes.borrowernumber = borrowers.borrowernumber
      LEFT JOIN borrower_attribute_types
        ON borrower_attributes.code = borrower_attribute_types.code
    ORDER BY
      borrowers.branchcode,
      borrower_attributes.code,
      borrower_attributes.attribute,
      borrower_attributes.borrowernumber
  ) borrowerss
    ON borrowerss.branchcode = columncreator.branchcode AND
      borrowerss.code = columncreator.CAT_CODE AND
      borrowerss.attribute = columncreator.AV_CODE
WHERE
  columncreator.branchcode LIKE &lt;&gt; AND
  columncreator.CAT_CODE LIKE &lt;&gt;
GROUP BY
  columncreator.branchcode,
  columncreator.CAT_CODE,
  columncreator.AV_CODE
HAVING
  PATRON_COUNT &gt;= &lt;&gt;
ORDER BY
  LIBRARY,
  EXTENDED_ATTRIBUTE


























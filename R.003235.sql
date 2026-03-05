/*
R.003235

----------

Name: GHW - Patrons at a specific library with a specific attribute
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2019-07-24 14:19:18
Modified on: 2024-01-17 12:08:34
Date last run: 2026-01-08 11:41:15

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Lists all patrons at your library with the extended attribute category and attribute you specify&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Lists current patrons with the attribute information you specify&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by patron home library, patron attribute category, and patron attribute&lt;/li&gt;
&lt;li&gt;links to the patron's account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Designed to work in conjunction with report 3234.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Patrons can have multiple extended attributes on their accounts.  Similarly, patrons may not have any extended attributes on their accounts.  If this report is configured to report on multiple attributes at one time, it is possible that some patrons will show up on this list multiple times.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;For more detailed information than this report provides use the following reports:&lt;/p&gt;
&lt;ul&gt;
&lt;li&gt;3086 - GHW - Patron attributes - Newsletter permissions &lt;/li&gt;
&lt;li&gt;3087 - GHW - Patron attributes - Movie permissions &lt;/li&gt;
&lt;li&gt;3088 - GHW - Patron attributes - Internet permissions&lt;/li&gt;
&lt;li&gt;3089 - GHW - Patron attributes - Special locations &lt;/li&gt;
&lt;li&gt;3090 - GHW - Patron attributes - Holds contact&lt;/li&gt;
&lt;li&gt;3091 - GHW - Patron attributes - Account expired&lt;/li&gt;
&lt;li&gt;3092 - GHW - Patron attributes - Collection agency&lt;/li&gt;
&lt;li&gt;3093 - GHW - Patron attributes - Other attributes 1 / Other attributes 2 / Registration library&lt;/li&gt;
&lt;/ul&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3235&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat('Go to patron account') AS LINK,
  borrowers.branchcode,
  borrowers.cardnumber,
  Concat_Ws('', borrowers.surname, ' / ', borrowers.firstname, If(borrowers.othernames = '', '', Concat_Ws('', ' (', borrowers.othernames, ')'))) AS NAME,
  categories.description AS PATRON_CATEGORY,
  borrower_attribute_types.description AS ATTRIBUTE_TYPE,
  If(authorised_values.lib IS NULL, borrower_attributes.attribute, authorised_values.lib) AS ATTRIBUTE_TEXT,
  borrower_attributes.attribute
FROM
  borrower_attributes
  JOIN borrowers
    ON borrower_attributes.borrowernumber = borrowers.borrowernumber
  JOIN borrower_attribute_types
    ON borrower_attributes.code = borrower_attribute_types.code
  LEFT JOIN authorised_values
    ON authorised_values.category = borrower_attribute_types.authorised_value_category AND
      authorised_values.authorised_value = borrower_attributes.attribute
  JOIN categories
    ON borrowers.categorycode = categories.categorycode
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrower_attributes.code LIKE &lt;&gt; AND
  borrower_attributes.attribute LIKE &lt;&gt;
ORDER BY
  borrowers.branchcode,
  NAME,
  borrowers.cardnumber


























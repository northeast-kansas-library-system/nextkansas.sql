/*
R.003015

----------

Name: GHW - Hold Contact Method
Created by: George H Williams

----------

Group: Borrowers
     -

Created on: 2017-12-08 18:58:23
Modified on: 2018-04-16 11:11:01
Date last run: 2020-04-30 14:34:26

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of patrons based on their holds contact method</p>
<ul><li>Shows current data only</li>
<li>for patrons at the library you specify</li>
<li>grouped by card number</li>
<li>sorted by homebranch and name</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3015&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  borrowers.branchcode,
  borrowers.cardnumber,
  Concat(borrowers.surname, ", ", borrowers.firstname) AS BORROWER_NAME,
  Coalesce(Concat(hold.code, ", ", hold.lib), "-") AS METHOD,
  IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Book%", "Book club", IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Email%", IF(borrowers.email = "", "<span style='background-color: red'>---</span>", borrowers.email), IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Home%", "Home delivery", IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Post%", "Postcard", IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Phone%", IF(borrowers.phone = "", "<span style='background-color: red'>---</span>", borrowers.phone), IF(Coalesce(Concat(hold.code, ", ", hold.lib), "-") LIKE "%Text%", IF(borrowers.smsalertnumber < 1, "<span style='background-color: red'>---</span>", IF(borrowers.smsalertnumber IS NULL, "<span style='background-color: red'>---</span>", borrowers.smsalertnumber)), "-")))))) AS CONTACT_AT
FROM
  borrowers
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        borrower_attributes.code,
        authorised_values.lib,
        authorised_values.authorised_value
      FROM
        borrower_attributes
        JOIN borrower_attribute_types ON borrower_attributes.code = borrower_attribute_types.code
        JOIN authorised_values ON borrower_attribute_types.authorised_value_category = authorised_values.category
          AND borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'HOLD') hold ON borrowers.borrowernumber = hold.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose patron home branch|ZBRAN>> AND
  Coalesce(hold.authorised_value, '-') LIKE <<Hold contact method|YHOLDCON>>
GROUP BY
  borrowers.cardnumber
ORDER BY
  borrowers.branchcode,
  BORROWER_NAME


























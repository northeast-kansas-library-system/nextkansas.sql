/*
R.003244

----------

Name: GHW - Patron Purge 104
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-02 23:34:40
Modified on: 2020-02-07 17:06:57
Date last run: 2020-02-23 18:58:04

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Part 4 of the patron purge process - part 4 - change extended attribute to 4</p>
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3244">Click here to download as a csv file</a></p>
</div>

----------
*/

Select
  Concat('<a href="https://staff.nexpresslibrary.org/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '" target="_blank">Link to patron</a>') As LINK_TO_PATRON,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  If((AddDate(Last_Day(SubDate(borrowers.dateexpiry, Interval -37 Month)), 1) + Interval 14 Day) < Cast('2018-04-15' As Date), Cast('2018-04-15' As Date), (AddDate(Last_Day(SubDate(borrowers.dateexpiry, Interval -37 Month)), 1) + Interval 14 Day)) As PROJECTED_DELETION,
  Coalesce(accountlinesx.DUE_SUM, 0) As AMT_DUE,
  Coalesce(issuesx.ICOUNT, 0) As CHECKOUTS,
  Coalesce(guaranteesx.GCOUNT, 0) As GUARANTEES,
  Coalesce(requestsx.Count_reserve_id, 0) As REQUESTS,
  expired_attribute.lib As ATTRIBUTE
From
  borrowers Left Join
  (Select
      Count(borrowers.borrowernumber) As GCOUNT,
      borrowers.guarantorid
    From
      borrowers
    Group By
      borrowers.guarantorid) guaranteesx On borrowers.borrowernumber = guaranteesx.guarantorid Left Join
  (Select
      accountlines.borrowernumber,
      Format(Sum(accountlines.amountoutstanding), 2) As DUE_SUM
    From
      accountlines
    Group By
      accountlines.borrowernumber) accountlinesx On borrowers.borrowernumber = accountlinesx.borrowernumber Left Join
  (Select
      issues.borrowernumber,
      Count(issues.issue_id) As ICOUNT
    From
      issues
    Group By
      issues.borrowernumber) issuesx On borrowers.borrowernumber = issuesx.borrowernumber Left Join
  (Select
      reserves.borrowernumber,
      Count(reserves.reserve_id) As Count_reserve_id
    From
      reserves
    Group By
      reserves.borrowernumber) requestsx On borrowers.borrowernumber = requestsx.borrowernumber Left Join
  (Select
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      authorised_values.lib,
      authorised_values.category
    From
      borrower_attributes Join
      authorised_values On borrower_attributes.attribute = authorised_values.authorised_value
    Where
      borrower_attributes.code = 'expired' And
      authorised_values.category = 'expired') expired_attribute On borrowers.borrowernumber = expired_attribute.borrowernumber
Where
  borrowers.dateexpiry < CurDate() - Interval 3 Year And
  borrowers.branchcode Like '%' And
  borrowers.othernames Not Like "%SIP%" And
  borrowers.categorycode <> 'STAFF' And
  borrowers.categorycode <> 'ILL' And
  borrowers.categorycode <> 'HOOPLA' And
  (Coalesce(accountlinesx.DUE_SUM, 0) <> 0 Or
      Coalesce(issuesx.ICOUNT, 0) <> 0 Or
      Coalesce(guaranteesx.GCOUNT, 0) <> 0 Or
      Coalesce(requestsx.Count_reserve_id, 0) <> 0) And
  expired_attribute.attribute <> 4
Group By
  borrowers.borrowernumber
Order By
  borrowers.dateexpiry,
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.borrowernumber




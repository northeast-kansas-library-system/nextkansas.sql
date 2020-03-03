/*
R.002490

----------

Name: Fines paid on a specific date or date range
Created by: Heather Braum

----------

Group: Circulation
     Charges

Created on: 2015-04-14 17:04:30
Modified on: 2019-12-26 11:46:15
Date last run: 2020-02-24 10:48:17

----------

Public: 0
Expiry: 0

----------

Set the date range (for a single date, put that date in twice) and choose your branch. Will return cardnumber and link to a patron's fines page, amount  paid and date paid. 
<p><span style="color: yellow; background-color: red; font-size: 200%;">References accountlines.accounttype.  Needs to be updated after January 4, 2020</span></p>

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/members/boraccount.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.cardnumber,'</a>') AS "Link to Fines", round(accountlines.amount,2) AS 'Fines Paid', accountlines.date FROM accountlines LEFT JOIN borrowers USING(borrowernumber) WHERE accounttype = 'pay' AND date BETWEEN <<Between (YYYY-MM-DD)>> AND <<and (YYYY-MM-DD>> AND borrowers.branchcode=<<choose branch|branches>> ORDER BY date ASC





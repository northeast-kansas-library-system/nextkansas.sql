/*
R.002609

----------

Name: Orphaned holds
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2015-09-24 17:47:27
Modified on: 2017-10-05 16:41:40
Date last run: 2020-08-12 17:46:31

----------

Public: 0
Expiry: 0

----------

The report returns patron's holds on records where, at the time of the hold placing, the record had items available to fulfill holds, but for a number of reasons, no items remain available at this time to fulfill the holds, due to:<br />
<br />
1) Last item available is overdue by 30+ days. <br />
2) Last item available is marked lost/damaged/withdrawn.<br />
3) Last item available is now not for loan (report ignores items with on-order status)<br />
<br />
The report returns a link to your patron's account, the patron's name, when the hold was placed and a link to the record.<br />
<br />
Please do the following to clean these up: <br />
<br />
1) Determine if your patron still wants the requested material. <br />
2) If the patron does still want the item, delete the hold, and either see if another record of the same title, similar format, is available in NExpress or request through ILL.<br />
3) If your patron does not want the item, please delete the hold. <br />
<br />
credit: Jesse Weaver @ ByWater

----------
*/

SELECT
  CONCAT('<a href="/cgi-bin/koha/members/moremember.pl?borrowernumber=', b.borrowernumber, '" target="_blank">'"Link to Patrons Account"'</a>') AS 'Link to Patrons Account',
  b.cardnumber, b.surname AS 'Surname',
  b.firstname AS 'First name', r.reservedate, r.expirationdate, bi.title as "'Record with Orphaned Hold", 
  CONCAT('<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=', r.biblionumber, '" target="_blank">'"Link to Record"'</a>') AS "Link to Record"
FROM
  reserves r
  LEFT JOIN borrowers b USING (borrowernumber)
  LEFT JOIN items i ON (i.biblionumber = r.biblionumber AND (i.onloan IS NULL OR i.onloan >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)) AND NOT (i.itemlost > 0 OR i.damaged > 0 OR i.withdrawn > 0 OR i.notforloan > 0))
  LEFT JOIN biblio bi ON (bi.biblionumber = r.biblionumber)
WHERE
  i.itemnumber IS NULL AND r.branchcode=<<choose library|branches>>
GROUP BY r.reserve_id
ORDER BY b.surname, bi.title




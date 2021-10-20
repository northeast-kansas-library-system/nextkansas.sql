/*
R.003267

----------

Name: GHW - ISBN errors
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-25 09:45:18
Modified on: 2019-11-04 15:51:57
Date last run: 2019-11-04 15:52:00

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of bibliographic records with parentheses in the 020$a field</p>
<ul><li>Shows records where the ISBN contains data that should go in the 020$q field rather than the $a field</li>
<li>lists records at all libraries</li>
<li>grouped and sorted by biblionumber</li>
</ul><br />
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3267&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3267">Click here to download as a csv file</a></p>
</div>

----------
*/



SELECT
  biblio.biblionumber,
  biblio.author,
  biblio.title,
  biblioitems.isbn,
  biblioitems.itemtype
FROM
  biblio
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber
WHERE
  biblioitems.isbn LIKE '%(%' AND
  biblioitems.itemtype <> 'DIGITAL'
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.biblionumber DESC


























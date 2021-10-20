/*
R.003148

----------

Name: GHW - 7 New Additions - ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-12-19 13:18:23
Modified on: 2018-12-19 13:45:31
Date last run: 2019-01-29 22:02:31

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat("Recently added book: ", biblio.title, "<br /><br />Summary:<br /><br />",
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="520"]//subfield[@code="a"]'),
  "<br /><br />Find this title in our catalog at<br /><br />https://nextkansas.org//cgi-bin/koha/opac-detail.pl?biblionumber=", biblio.biblionumber) AS POST
FROM
  biblio
  INNER JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  INNER JOIN items ON items.biblionumber = biblio.biblionumber
WHERE
  biblio.timestamp >= Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) - INTERVAL 1 WEEK AND
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="520"]//subfield[@code="a"]') <> ""
GROUP BY
  Concat("Recently added book: ", biblio.title, "<br /><br />Summary:<br /><br />",
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="520"]//subfield[@code="a"]'),
  "<br /><br />Find this title in our catalog at<br /><br />https://nextkansas.org//cgi-bin/koha/opac-detail.pl?biblionumber=", biblio.biblionumber),
  biblio.biblionumber
HAVING
  Group_Concat(items.itype) LIKE "%BOOK%" AND
  Group_Concat(items.notforloan) LIKE "%0%" AND
  Group_Concat(items.location) LIKE "ADULT%"
LIMIT 1
UNION
SELECT
  Concat("Recently added book: ", biblio.title, "<br /><br />Summary:<br /><br />",
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="520"]//subfield[@code="a"]'),
  "<br /><br />Find this title in our catalog at<br /><br />https://nextkansas.org//cgi-bin/koha/opac-detail.pl?biblionumber=", biblio.biblionumber) AS POST
FROM
  biblio
  INNER JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  INNER JOIN items ON items.biblionumber = biblio.biblionumber
WHERE
  biblio.timestamp >= Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 6 DAY) - INTERVAL 1 WEEK AND
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="520"]//subfield[@code="a"]') <> ""
GROUP BY
  Concat("Recently added children's video: ", biblio.title, "<br /><br />Summary:<br /><br />",
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="520"]//subfield[@code="a"]'),
  "<br /><br />Find this title in our catalog at<br /><br />https://nextkansas.org//cgi-bin/koha/opac-detail.pl?biblionumber=", biblio.biblionumber),
  biblio.biblionumber
HAVING
  Group_Concat(items.itype) LIKE "%MEDIA%" AND
  Group_Concat(items.notforloan) LIKE "%0%" AND
  Group_Concat(items.location) LIKE "CHILD%"
LIMIT 1


























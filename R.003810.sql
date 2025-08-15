/*
R.003810

----------

Name: Sandbox Search by LEADER 8 ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-08 17:10:43
Modified on: 2024-03-08 17:17:32
Date last run: 2025-07-22 13:44:51

----------

Public: 0
Expiry: 300

----------

a- Language material
c- Notated music
d- Manuscript notated music
e- Cartographic material
f - Manuscript cartographic material
g - Projected medium
i - Nonmusical sound recording
j - Musical sound recording
k - Two-dimensional nonprojectable graphic
m - Computer file
o - Kit
p - Mixed materials
r - Three-dimensional artifact or naturally occurring object
t - Manuscript language material

----------
*/



SELECT
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) AS
  metadata,
  biblio_metadata.biblionumber AS BIBS
FROM
  biblio_metadata
WHERE
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ) = &lt;&gt;
GROUP BY
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') FROM 7 FOR 1 ),
  biblio_metadata.biblionumber
ORDER BY
  BIBS


























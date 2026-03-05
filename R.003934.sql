/*
R.003934

----------

Name: GHW - LDR - Itype miss-match
Created by: George Williams

----------

Group: -
     -

Created on: 2025-12-30 21:21:53
Modified on: 2025-12-30 21:37:09
Date last run: 2026-01-01 21:23:37

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  Concat(
    'Bibliographic record'
  ) As LINK,
  biblio.biblionumber,
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 7 For 1 ) As TYPE_OF_RECORD,
  biblioitems.itemtype
From
  biblio_metadata Inner Join
  biblio On biblio_metadata.biblionumber = biblio.biblionumber Inner Join
  biblioitems On biblioitems.biblionumber = biblio.biblionumber
Where
  SubString(ExtractValue(biblio_metadata.metadata, '//leader') From 7 For 1 ) &lt;&gt; 'g' And
  biblioitems.itemtype Like 'NVI%'
Group By
  biblio.biblionumber
ORDER BY 
  biblio.biblionumber ASC


























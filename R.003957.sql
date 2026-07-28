/*
R.003957

----------

Name: Report example - extract marc fields from 245
Created by: George Williams

----------

Group: -
     -

Created on: 2026-04-20 08:44:14
Modified on: 2026-04-27 10:18:36
Date last run: 2026-04-27 10:18:41

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  biblio_metadata.biblionumber,
  ExtractValue (biblio_metadata.metadata, '//datafield[@tag="245"]/@ind1') AS '245 Indicator 1',
  ExtractValue (biblio_metadata.metadata, '//datafield[@tag="245"]/@ind2') AS '245 Indicator 2',
  ExtractValue (biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="a"]') AS '245 Title',
  ExtractValue (biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') AS '245 Medium',
  ExtractValue (biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]') AS '245 Remainder of title',
  ExtractValue (biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]') AS '245 Number of part / section of work',
  ExtractValue (biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]') AS '245 Name of part / section of work',
  ExtractValue (biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]') AS '245 Statement of responsibility, etc.'
FROM biblio_metadata
WHERE 
  biblio_metadata.biblionumber Like <<Enter biblio number>>
GROUP BY biblio_metadata.biblionumber


























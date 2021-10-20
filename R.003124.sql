/*
R.003124

----------

Name: GHW - Genre Terms count
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-09-19 11:36:49
Modified on: 2018-09-25 10:03:36
Date last run: 2021-04-12 14:54:56

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Shows a count of how many bibliographic records contain a specified index term in their bibliographic records (Marc 655$a).</p>
<ul><li>Shows terms and their counts currently in the catalog.</li>
<li>At all libraries</li>
<li>grouped and sorted by index term</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Enter an index term or a partial index term and this report will show you how many records contain that term.  Best to use for partial terms (i.e. for "Erotic stories," type in "erot" to get a list of all terms containing the characters "erot" in that order).</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3124&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="655"]/subfield[@code="a"]') AS INDEX_TERM,
  Count(DISTINCT biblio_metadata.biblionumber) AS BIBLIO_COUNT
FROM
  biblio_metadata
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="655"]/subfield[@code="a"]') LIKE Concat("%", <<Enter part of an index term (Marc 655 subfield a) or a % symbol>>, "%")
GROUP BY
  INDEX_TERM


























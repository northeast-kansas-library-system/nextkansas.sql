/*
R.002777

----------

Name: GHW - News block dump
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-09-23 10:17:30
Modified on: 2019-08-16 15:17:21
Date last run: 2019-08-16 15:17:23

----------

Public: 0
Expiry: 300

----------

Dump of old news items

----------
*/



SELECT
  opac_news.idnew,
  opac_news.branchcode,
  opac_news.title,
  Replace(opac_news.content, '\r\n', CONCAT(Char(13),Char(10))) AS content,
  opac_news.lang,
  opac_news.timestamp,
  opac_news.expirationdate,
  opac_news.number,
  opac_news.borrowernumber
FROM
  opac_news
WHERE
  opac_news.title LIKE "%Useful links for%"
ORDER BY
  opac_news.branchcode


























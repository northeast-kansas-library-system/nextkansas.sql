/*
R.003816

----------

Name: Bibliographic records by 'biblioitems.itemtype'
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-28 14:37:49
Modified on: 2024-03-28 15:06:58
Date last run: 2024-03-29 16:16:37

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblioitems.biblionumber,
  Concat(
    '',
    'Go to bibliographic record',
    ''
  ) AS LINK_TO_BIBLIO,
    Concat(
    '',
    'Edit record',
    ''
  ) AS LINK_TO_EDIT,
  biblioitems.itemtype
FROM
  biblioitems
WHERE
  biblioitems.itemtype LIKE <>


























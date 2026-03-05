/*
R.003758

----------

Name: MIT count
Created by: George Williams

----------

Group: -
     -

Created on: 2023-09-11 14:28:13
Modified on: 2023-09-11 14:28:13
Date last run: 2023-10-13 12:39:19

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Count(branchtransfers.itemnumber) AS Count_itemnumber
FROM
  branchtransfers JOIN
  items ON branchtransfers.itemnumber = items.itemnumber
WHERE
  branchtransfers.datearrived IS NULL AND
  branchtransfers.datecancelled IS NULL AND
  Concat_Ws(" ", branchtransfers.frombranch, branchtransfers.tobranch,
  items.homebranch) LIKE Concat("%", <<Choose your library|ZBRAN>> ,"%") AND
  branchtransfers.datesent < CurDate() - INTERVAL 7 DAY


























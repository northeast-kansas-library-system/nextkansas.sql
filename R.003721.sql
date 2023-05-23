/*
R.003721

----------

Name: Wok in progress
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-03-27 23:48:23
Modified on: 2023-03-28 15:06:11
Date last run: 2023-03-29 10:37:23

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branches.branchname,
  statistics.datetime,
  borrowers.cardnumber As BORROWER,
  statistics.type As TRANSACTION_TYPE
From
  statistics Left Join
  branches On branches.branchcode = statistics.branch Left Join
  borrowers On borrowers.borrowernumber = statistics.borrowernumber
Where
  (statistics.type = 'issue' Or
      statistics.type = 'payment' Or
      statistics.type = 'renew' Or
      statistics.type = 'writeoff') And
  statistics.branch LIKE <<Choose your library|branches>> And
  statistics.datetime Between <<Choose a date|date>> And (<<Choose a date|date>> + interval 1 day)
Order By
  statistics.datetime


























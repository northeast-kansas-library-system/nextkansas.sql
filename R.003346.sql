/*
R.003346

----------

Name: GHW - Sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-14 15:14:53
Modified on: 2023-01-30 14:48:59
Date last run: 2023-01-30 14:49:01

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
    borrowers.borrowernumber,
    borrowers.cardnumber,
    borrowers.surname,
    borrowers.firstname,
    borrowers.email,
    borrowers.emailpro
From
    borrowers
Where
    (borrowers.email Not Like '%_@__%.__%' And
        borrowers.email Is Not Null And
        borrowers.email Not Like '') Or
    (borrowers.emailpro Not Like '%_@__%.__%' And
        borrowers.emailpro Is Not Null And
        borrowers.emailpro Not Like '')


























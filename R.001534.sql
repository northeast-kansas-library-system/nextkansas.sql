/*
R.001534

----------

Name: Borrowers in a given zipcode for a given branch
Created by: Heather Braum

----------

Group: Borrowers
     -

Created on: 2012-09-05 10:56:12
Modified on: 2013-06-17 01:08:56
Date last run: 2020-12-07 10:31:06

----------

Public: 0
Expiry: 0

----------

Enhanced: RUN AS IS. This report will report all patrons/addresses in a given zipcode for a given library.

----------
*/

select firstname,surname, address from borrowers where zipcode = <<enter zip code>> and branchcode =<<Select your Library|branches>>




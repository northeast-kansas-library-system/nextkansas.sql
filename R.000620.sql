/*
R.000620

----------

Name: Identify patron by email address
Created by:  Tongie Book Club

----------

Group: Patrons
     -

Created on: 2009-06-30 09:42:05
Modified on: 2013-06-17 02:07:04
Date last run: 2018-08-27 13:27:30

----------

Public: 0
Expiry: 0

----------

Run the report and then type in the "enter email address" box the email address you want to look up. 

----------
*/

select cardnumber, surname, firstname, branchcode, email, emailpro, b_email from borrowers where <<enter email address>> in (B_email, email, emailpro)




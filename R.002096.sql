/*
R.002096

----------

Name: Purchase Suggestions
Created by: -

----------

Group: Administrative Reports
     Acquistions-admin

Created on: 2013-11-14 09:34:28
Modified on: 2014-01-15 15:21:10
Date last run: -

----------

Public: 0
Expiry: 0

----------

NOT limited by branch

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/suggestion/suggestion.pl?suggestionid=',suggestions.suggestionid,'&op=edit\" target="_blank">'"Answer Request"'</a>') AS Request, CONCAT('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.firstname, ', ', borrowers.surname,'</a>') AS patron, CONCAT(borrowers.firstname,' ',borrowers.surname) as name, suggestions.branchcode, suggestions.suggesteddate, suggestions.status, suggestions.title, suggestions.author, suggestions.itemtype, suggestions.copyrightdate, suggestions.isbn, suggestions.note FROM borrowers, suggestions WHERE borrowers.borrowernumber=suggestions.suggestedby AND suggestions.status='ASKED' ORDER BY suggestions.branchcode, suggestions.suggesteddate DESC




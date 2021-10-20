/*
R.001561

----------

Name: Pending Purchase Suggestions (by Branch)
Created by: Heather Braum

----------

Group: Acquisitions
     Purchase Requests

Created on: 2012-09-27 11:50:07
Modified on: 2018-07-02 09:32:01
Date last run: 2021-01-19 09:46:03

----------

Public: 0
Expiry: 0

----------

Limited by Branch. Edit requests directly from this report by clicking on the Answer Request link. #special

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/suggestion/suggestion.pl#ASKED\" target="_blank">All Pending Suggestions</a>') AS "All Pending Suggestions",
  Concat('<a href=\"/cgi-bin/koha/suggestion/suggestion.pl?suggestionid=', suggestions.suggestionid, '&op=edit\" target="_blank">Answer Request</a>') AS Request,
  Concat('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">', borrowers.surname, ', ', borrowers.firstname, '</a>') AS patron,
  suggestions.suggesteddate,
  suggestions.STATUS,
  suggestions.title,
  suggestions.author,
  suggestions.itemtype,
  suggestions.copyrightdate,
  suggestions.isbn,
  suggestions.note
FROM
  borrowers,
  suggestions
WHERE
  borrowers.borrowernumber = suggestions.suggestedby AND
  suggestions.branchcode LIKE <<branch|LBRANCH>> AND
  suggestions.STATUS = 'ASKED'
ORDER BY
  suggestions.suggesteddate DESC


























/*
R.003822

----------

Name: Save file so I can work on it from home
Created by: George Williams

----------

Group: -
     -

Created on: 2024-04-05 15:18:04
Modified on: 2024-04-08 22:37:37
Date last run: 2024-04-09 10:19:02

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT Concat_Ws(
    '',
    Concat_Ws(
      '',
      '<h3>Account summary: ',
      borrowers.firstname,
      ' ',
      borrowers.surname,
      ' (',
      borrowers.cardnumber,
      ')</h3>'
    ),
    '<ul>',
    If(
      Coalesce(borrowers.address2, '') = '',
      Concat('<li>', borrowers.address, '</li>'),
      Concat(
        '<li>',
        borrowers.address,
        '</li><li>',
        borrowers.address2,
        '</li>'
      )
    ),
    Concat_Ws(
      '',
      '<li>',
      borrowers.city,
      ', ',
      borrowers.state,
      ' ',
      borrowers.zipcode,
      '</li>'
    ),
    If(
      Coalesce(borrowers.phone, '') = '',
      '',
      Concat('<li>', borrowers.phone, '</li>')
    ),
    If(
      Coalesce(borrowers.email, '') = '',
      '',
      Concat('<li>', borrowers.email, '</li>')
    ),
    If(
      Coalesce(borrowers.emailpro, '') = '',
      '',
      Concat('<li>', borrowers.emailpro, '</li>')
    ),
    If(
      Coalesce(borrowers.dateenrolled, '') = '',
      '',
      Concat(
        '<li>Account registration date: ',
        borrowers.dateenrolled,
        '</li>'
      )
    ),
    If(
      Coalesce(borrowers.date_renewed, '') = '',
      '',
      Concat(
        '<li>Most recent account renewal: ',
        borrowers.date_renewed,
        '</li>'
      )
    ),
    If(
      Coalesce(borrowers.dateexpiry, '') = '',
      '',
      Concat(
        '<li>Account expiration date: ',
        borrowers.dateexpiry,
        '</li>'
      )
    ),
    If(
      Coalesce(branches.branchname, '') = '',
      '',
      Concat(
        '<li>Home library: ',
        branches.branchname,
        '</li>'
      )
    ),
    If(
      Coalesce(categories.description, '') = '',
      '',
      Concat(
        '<li>Account category: ',
        categories.description,
        '</li>'
      )
    ),
    '</ul>'
  ) AS address_info,
  If(
    Coalesce(checkouts.current_checkouts, '') = '',
    'No items currently checked out',
    Concat_Ws(
      '',
      '<h3>Current checkouts:</h3><ul>',
      checkouts.current_checkouts,
      '</ul>'
    )
  ) AS current_checkouts,
  If(
    Coalesce(requests.current_requests, '') = '',
    'No current requests',
    Concat_Ws(
      '',
      '<h3>Current requests:</h3><ul>',
      requests.current_requests,
      '</ul>'
    )
  ) AS current_requests,
  If(
    Coalesce(unpaid_fees.fees, '') = '',
    'No unpaid fees',
    Concat_Ws(
      '',
      '<h3>Unpaid fees</h3><ul>',
      unpaid_fees.fees,
      '</ul>'
    )
  ) AS unpaid_fees
FROM borrowers
  JOIN branches ON borrowers.branchcode = branches.branchcode
  JOIN categories ON borrowers.categorycode = categories.categorycode
  LEFT JOIN (
    SELECT issues.borrowernumber,
      GROUP_CONCAT(
        DISTINCT Concat_Ws(
          '',
          Concat_Ws(
            ' ',
            '<li>Title: ',
            biblio.title,
            biblio.subtitle,
            '<br />'
          ),
          If(
            Coalesce(biblio.author, '') = '',
            '',
            Concat('Author: ', biblio.author, '<br />')
          ),
          If(
            Coalesce(items.itemcallnumber, '') = '',
            '',
            Concat(
              'Call number: ',
              items.itemcallnumber,
              '<br />'
            )
          ),
          If(
            Coalesce(itemtypes.description, '') = '',
            '',
            Concat('Item type: ', itemtypes.description, '<br />')
          ),
          If(
            Coalesce(issues.date_due, '') = '',
            '',
            Concat(
              'Due date: ',
              Date_Format(issues.date_due, '%Y-%m-%d'),
              '<br />'
            )
          ),
          If(
            Coalesce(branches.branchname, '') = '',
            '',
            Concat(
              'Borrowed from: ',
              branches.branchname,
              '<br />'
            )
          ),
          If(
            Coalesce(items.barcode, '') = '',
            '',
            Concat('Item barcode: ', items.barcode, '<br />')
          ),
          If(
            Coalesce(items.replacementprice, '') = '',
            '',
            Concat(
              'Replacement price: ',
              items.replacementprice,
              '<br />'
            )
          ),
          If(
            issues.date_due > CurDate(),
            '',
            'Status: Overdue<br />'
          )
        )
        ORDER BY issues.date_due
      ) AS current_checkouts
    FROM issues
      JOIN items ON issues.itemnumber = items.itemnumber
      JOIN biblio ON items.biblionumber = biblio.biblionumber
      LEFT JOIN itemtypes ON itemtypes.itemtype = items.itype
      LEFT JOIN branches ON branches.branchcode = issues.branchcode
    GROUP BY issues.borrowernumber
    ORDER BY issues.date_due
  ) checkouts ON checkouts.borrowernumber = borrowers.borrowernumber
  LEFT JOIN (
    SELECT reserves.borrowernumber,
      GROUP_CONCAT(
        Concat_Ws(
          '',
          '<li>',
          Concat_Ws(
            '',
            'Title: ',
            biblio.title,
            biblio.subtitle,
            '<br />'
          ),
          If(
            Coalesce(biblio.author, '') = '',
            '',
            Concat('Author: ', biblio.author, '<br />')
          ),
          If(
            Coalesce(branches.branchname, '') = '',
            '',
            Concat(
              'Pickup at: ',
              branches.branchname,
              '<br />'
            )
          ),
          If(
            Coalesce(reserves.reservedate, '') = '',
            '',
            Concat_Ws(
              '',
              'Request date: ',
              Date_Format(reserves.reservedate, '%Y-%m-%d'),
              '<br />'
            )
          ),
          If(
            Coalesce(reserves.expirationdate, '') = '',
            '',
            Concat_Ws(
              '',
              'Request expires: ',
              Date_Format(reserves.expirationdate, '%Y-%m-%d'),
              '<br />'
            )
          ),
          If(
            Coalesce(reserves.found, '') = '',
            '',
            If(
              Coalesce(reserves.found, '') = 'W',
              'Status: Waiting for pickup<br />',
              If(
                Coalesce(reserves.suspend, '') = '1',
                'Status: Request is suspended',
                Concat_Ws('', 'Status: In transit<br />')
              )
            )
          ),
          If(
            Coalesce(reserves.suspend_until, '') = '',
            '',
            Concat_Ws(
              '',
              'Suspended until: ',
              Date_Format(reserves.suspend_until, '%Y-%m-%d'),
              '<br />'
            )
          ),
          If(
            Coalesce(reserves.waitingdate, '') = '',
            '',
            Concat_Ws(
              '',
              'Waiting since: ',
              Date_Format(reserves.waitingdate, '%Y-%m-%d'),
              '<br />'
            )
          ),
          '</li>'
        )
        ORDER BY reserves.timestamp DESC
      ) AS current_requests
    FROM reserves
      JOIN biblio ON reserves.biblionumber = biblio.biblionumber
      INNER JOIN branches ON reserves.branchcode = branches.branchcode
    GROUP BY reserves.borrowernumber
    ORDER BY reserves.expirationdate DESC
  ) requests ON requests.borrowernumber = borrowers.borrowernumber
  LEFT JOIN (
    SELECT accountlines.borrowernumber,
      GROUP_CONCAT(
        '<li>',
        If(
          Coalesce(accountlines.date, '') = '',
          '',
          Concat_Ws(
            '',
            'Date: ',
            Date_Format(accountlines.date, '%Y-%m-%d'),
            '<br />'
          )
        ),
        If(
          Coalesce(accountlines.description, '') = '',
          '',
          Concat_Ws(
            '',
            'Description: ',
            accountlines.description,
            '<br />'
          )
        ),
        If(
          Coalesce(accountlines.amount, '') = '',
          '',
          Concat_Ws(
            '',
            'Amount of fee: ',
            round(accountlines.amount, 2),
            '<br />'
          )
        ),
        If(
          Coalesce(accountlines.amountoutstanding, '') = '',
          '',
          Concat_Ws(
            '',
            'Amount still outstanding: ',
            Round(accountlines.amountoutstanding, 2),
            '<br />'
          )
        ),
        '</li>'
        ORDER BY accountlines.date DESC
      ) AS fees
    FROM accountlines
    WHERE accountlines.amountoutstanding <> 0
    GROUP BY accountlines.borrowernumber
  ) unpaid_fees ON unpaid_fees.borrowernumber = borrowers.borrowernumber
WHERE borrowers.borrowernumber LIKE <<Enter borrower id number>>
GROUP BY borrowers.borrowernumber


























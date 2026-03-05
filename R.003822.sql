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
      'Account summary: ',
      borrowers.firstname,
      ' ',
      borrowers.surname,
      ' (',
      borrowers.cardnumber,
      ')'
    ),
    '',
    If(
      Coalesce(borrowers.address2, '') = '',
      Concat('', borrowers.address, ''),
      Concat(
        '',
        borrowers.address,
        '',
        borrowers.address2,
        ''
      )
    ),
    Concat_Ws(
      '',
      '',
      borrowers.city,
      ', ',
      borrowers.state,
      ' ',
      borrowers.zipcode,
      ''
    ),
    If(
      Coalesce(borrowers.phone, '') = '',
      '',
      Concat('', borrowers.phone, '')
    ),
    If(
      Coalesce(borrowers.email, '') = '',
      '',
      Concat('', borrowers.email, '')
    ),
    If(
      Coalesce(borrowers.emailpro, '') = '',
      '',
      Concat('', borrowers.emailpro, '')
    ),
    If(
      Coalesce(borrowers.dateenrolled, '') = '',
      '',
      Concat(
        'Account registration date: ',
        borrowers.dateenrolled,
        ''
      )
    ),
    If(
      Coalesce(borrowers.date_renewed, '') = '',
      '',
      Concat(
        'Most recent account renewal: ',
        borrowers.date_renewed,
        ''
      )
    ),
    If(
      Coalesce(borrowers.dateexpiry, '') = '',
      '',
      Concat(
        'Account expiration date: ',
        borrowers.dateexpiry,
        ''
      )
    ),
    If(
      Coalesce(branches.branchname, '') = '',
      '',
      Concat(
        'Home library: ',
        branches.branchname,
        ''
      )
    ),
    If(
      Coalesce(categories.description, '') = '',
      '',
      Concat(
        'Account category: ',
        categories.description,
        ''
      )
    ),
    ''
  ) AS address_info,
  If(
    Coalesce(checkouts.current_checkouts, '') = '',
    'No items currently checked out',
    Concat_Ws(
      '',
      'Current checkouts:',
      checkouts.current_checkouts,
      ''
    )
  ) AS current_checkouts,
  If(
    Coalesce(requests.current_requests, '') = '',
    'No current requests',
    Concat_Ws(
      '',
      'Current requests:',
      requests.current_requests,
      ''
    )
  ) AS current_requests,
  If(
    Coalesce(unpaid_fees.fees, '') = '',
    'No unpaid fees',
    Concat_Ws(
      '',
      'Unpaid fees',
      unpaid_fees.fees,
      ''
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
            'Title: ',
            biblio.title,
            biblio.subtitle,
            ''
          ),
          If(
            Coalesce(biblio.author, '') = '',
            '',
            Concat('Author: ', biblio.author, '')
          ),
          If(
            Coalesce(items.itemcallnumber, '') = '',
            '',
            Concat(
              'Call number: ',
              items.itemcallnumber,
              ''
            )
          ),
          If(
            Coalesce(itemtypes.description, '') = '',
            '',
            Concat('Item type: ', itemtypes.description, '')
          ),
          If(
            Coalesce(issues.date_due, '') = '',
            '',
            Concat(
              'Due date: ',
              Date_Format(issues.date_due, '%Y-%m-%d'),
              ''
            )
          ),
          If(
            Coalesce(branches.branchname, '') = '',
            '',
            Concat(
              'Borrowed from: ',
              branches.branchname,
              ''
            )
          ),
          If(
            Coalesce(items.barcode, '') = '',
            '',
            Concat('Item barcode: ', items.barcode, '')
          ),
          If(
            Coalesce(items.replacementprice, '') = '',
            '',
            Concat(
              'Replacement price: ',
              items.replacementprice,
              ''
            )
          ),
          If(
            issues.date_due &gt; CurDate(),
            '',
            'Status: Overdue'
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
          '',
          Concat_Ws(
            '',
            'Title: ',
            biblio.title,
            biblio.subtitle,
            ''
          ),
          If(
            Coalesce(biblio.author, '') = '',
            '',
            Concat('Author: ', biblio.author, '')
          ),
          If(
            Coalesce(branches.branchname, '') = '',
            '',
            Concat(
              'Pickup at: ',
              branches.branchname,
              ''
            )
          ),
          If(
            Coalesce(reserves.reservedate, '') = '',
            '',
            Concat_Ws(
              '',
              'Request date: ',
              Date_Format(reserves.reservedate, '%Y-%m-%d'),
              ''
            )
          ),
          If(
            Coalesce(reserves.expirationdate, '') = '',
            '',
            Concat_Ws(
              '',
              'Request expires: ',
              Date_Format(reserves.expirationdate, '%Y-%m-%d'),
              ''
            )
          ),
          If(
            Coalesce(reserves.found, '') = '',
            '',
            If(
              Coalesce(reserves.found, '') = 'W',
              'Status: Waiting for pickup',
              If(
                Coalesce(reserves.suspend, '') = '1',
                'Status: Request is suspended',
                Concat_Ws('', 'Status: In transit')
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
              ''
            )
          ),
          If(
            Coalesce(reserves.waitingdate, '') = '',
            '',
            Concat_Ws(
              '',
              'Waiting since: ',
              Date_Format(reserves.waitingdate, '%Y-%m-%d'),
              ''
            )
          ),
          ''
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
        '',
        If(
          Coalesce(accountlines.date, '') = '',
          '',
          Concat_Ws(
            '',
            'Date: ',
            Date_Format(accountlines.date, '%Y-%m-%d'),
            ''
          )
        ),
        If(
          Coalesce(accountlines.description, '') = '',
          '',
          Concat_Ws(
            '',
            'Description: ',
            accountlines.description,
            ''
          )
        ),
        If(
          Coalesce(accountlines.amount, '') = '',
          '',
          Concat_Ws(
            '',
            'Amount of fee: ',
            round(accountlines.amount, 2),
            ''
          )
        ),
        If(
          Coalesce(accountlines.amountoutstanding, '') = '',
          '',
          Concat_Ws(
            '',
            'Amount still outstanding: ',
            Round(accountlines.amountoutstanding, 2),
            ''
          )
        ),
        ''
        ORDER BY accountlines.date DESC
      ) AS fees
    FROM accountlines
    WHERE accountlines.amountoutstanding &lt;&gt; 0
    GROUP BY accountlines.borrowernumber
  ) unpaid_fees ON unpaid_fees.borrowernumber = borrowers.borrowernumber
WHERE borrowers.borrowernumber LIKE &lt;&gt;
GROUP BY borrowers.borrowernumber


























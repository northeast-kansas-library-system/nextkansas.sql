/*
R.003840

----------

Name: GHW - Barcode matching for "Item not found" barcodes
Created by: George Williams

----------

Group: -
     -

Created on: 2024-06-04 12:37:48
Modified on: 2025-04-07 13:32:55
Date last run: 2026-02-28 12:18:55

----------

Public: 0
Expiry: 300

----------

<div class="noprint" div="reportinfo"> 
 
  <div class="reportInfoContent"> 
 
    <p>Gives a count of barcode numbers with matching starting strings grouped by item home library</p> 
 
    <ul> 
      <li>Counts barcode numbers currently in the items and deleteditems tables</li> 
      <li>counts items by home library</li> 
      <li>grouped by home library</li> 
      <li>links to barcode numbers that are exact matches</li> 
    </ul> 
 
  </div> 
 
  <div class="reportInfoNotes"> 
 
    <p> 
 
    </p> 
 
    <p> 
      If you search for an item barcode number or check in an item barcode number and get zero results, you can use this report to find barcode numbers that have similar starting strings to that barcode number.  For example, if you scan barcode number 1234567891234 this report will search for:
    <ul>
      <li>1234567891234 as an exact match in items and deleteditems</li>
      <li>123456789123 as the beginning of any barcode in items and deleteditems</li>
      <li>12345678912 as the beginning of any barcode in items and deleteditems</li>
      <li>1234567891 as the beginning of any barcode in items and deleteditems</li>
    </ul>
    </p> 
 
    <p> 
      If you are trying to find the home library for an item, if there is an exact match for that barcode number, this report will show you that item's home library.  If there is no exact match, it will show you the home library for item barcodes extremely close in sequence - the more extremely close matches, the more likely it is that the home library of the item you cannot find was owned by that library.   If there are no extremely close matches, it will show you the home library for item barcodes close in sequence - the more close matches, the more likely it is that the home library of the item you cannot find was owned by that library.  If there are no close matches, it will show you the home library for item barcodes that are good matches - the more good matches, the more likely it is that the home library of the item you cannot find was owned by that library.
    </p> 
 
  </div> 
 
  <div id="reportInfoTags"> 
 
    <p style="display: none;"> 
      #itemnotfound
      #barcodematch 
    </p> 
 
  </div> 
 
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
 
</div> 

----------
*/



SELECT concat_ws(
    '<br /><br />',
    Concat(
      '<h3 class="next_green next_banner">You searched for: ',
      <<Enter barcode number>>,
      '</h3>'
    ),
    GROUP_CONCAT(
      DISTINCT first_level.match_one
      ORDER BY first_level.match_one DESC SEPARATOR '<br />'
    ),
    Concat( 
      'An exact match means that this barcode number matches an item currently in<br />', 
      'the catalog or that has been deleted in the previous 13 months<br /><br />',
      '==========<br />'
    ),
    GROUP_CONCAT(
      DISTINCT second_level.match_two
      ORDER BY second_level.match_two DESC SEPARATOR '<br />'
    ),
    Concat('<p><strong>An extremely close match means that the first ',
    (Length(Trim(<<Enter barcode number>>)) - 1),
    ' digits of this barcode number<br>match the first ',
    (Length(Trim(<<Enter barcode number>>)) - 1),
    ' digits of barcode numbers in the "items" or "deleteditems" tables</strong></p>',
    '<p>Generally speaking, there should be no more than 10 extremely close<br />',
    'matches possible unless some barcode numbers have been recycled.</p>',
    '==========<br />'),
    GROUP_CONCAT(
      DISTINCT third_level.match_three
      ORDER BY third_level.match_three DESC SEPARATOR '<br />'
    ),
    Concat('<p><strong>A close match means that the first ',
    (Length(Trim(<<Enter barcode number>>)) - 2),
    ' digits of this barcode number match the first ',
    (Length(Trim(<<Enter barcode number>>)) - 2),
    ' digits<br>of barcode numbers in the "items" or "deleteditems" tables</strong></p>',
    '<p>Generally speaking, there should be no more than 100 close<br>',
    'matches possible unless some barcode numbers have been recycled.</p>',
    '==========<br />'),
    GROUP_CONCAT(
      DISTINCT fourth_level.match_four
      ORDER BY fourth_level.match_four DESC SEPARATOR '<br />'
    ),
    Concat('<p><strong>A good match means that the first ',
    (Length(Trim(<<Enter barcode number>>)) - 3),
    ' digits of this barcode number match the first ',
    (Length(Trim(<<Enter barcode number>>)) - 3),
    ' digits<br>of barcode numbers in the "items" or "deleteditems" tables</strong></p>',
    '<p>Generally speaking, there should be no more than 1000 good<br>',
    'matches possible unless some barcode numbers have been recycled.</p>',
    '==========<br />')
  ) AS MATCHES
FROM (
    SELECT If(
        Coalesce(Count(DISTINCT items.itemnumber), 0) = 0,
        'EXTREMELY CLOSE MATCH - 000 matches for active items',
        Concat_Ws(
          '',
          'EXTREMELY CLOSE MATCH - ',
          Lpad(Count(DISTINCT items.itemnumber), 3, '0'),
          ' active items with a barcode beginning with ',
          Left(
            Trim(<<Enter barcode number>>),
            Length(Trim(<<Enter barcode number>>)) - 1
          ),
          ' at ',
          items.homebranch
        )
      ) AS match_two
    FROM items
    WHERE items.barcode LIKE Concat(
        Left(
          Trim(<<Enter barcode number>>),
          Length(Trim(<<Enter barcode number>>)) - 1
        ),
        '%'
      )
    UNION
    SELECT If(
        Coalesce(Count(DISTINCT deleteditems.itemnumber), 0) = 0,
        'EXTREMELY CLOSE MATCH - 000 matches for deleted items',
        Concat_Ws(
          '',
          'EXTREMELY CLOSE MATCH - ',
          Lpad(Count(DISTINCT deleteditems.itemnumber), 3, '0'),
          ' deleted items with a barcode beginning with ',
          Left(
            Trim(<<Enter barcode number>>),
            Length(Trim(<<Enter barcode number>>)) - 1
          ),
          ' at ',
          deleteditems.homebranch
        )
      )
    FROM deleteditems
    WHERE deleteditems.barcode LIKE Concat(
        Left(
          Trim(<<Enter barcode number>>),
          Length(Trim(<<Enter barcode number>>)) - 1
        ),
        '%'
      )
    GROUP BY deleteditems.homebranch
  ) second_level,
  (
    SELECT If(
        Coalesce(Count(DISTINCT items.itemnumber), 0) = 0,
        'CLOSE MATCH - 000 matches for active items',
        Concat_Ws(
          '',
          'CLOSE MATCH - ',
          Lpad(Count(DISTINCT items.itemnumber), 3, '0'),
          ' active items with a barcode beginning with ',
          Left(
            Trim(<<Enter barcode number>>),
            Length(Trim(<<Enter barcode number>>)) - 2
          ),
          ' at ',
          items.homebranch
        )
      ) AS match_three
    FROM items
    WHERE items.barcode LIKE Concat(
        Left(
          Trim(<<Enter barcode number>>),
          Length(Trim(<<Enter barcode number>>)) - 2
        ),
        '%'
      )
    UNION
    SELECT If(
        Coalesce(Count(DISTINCT deleteditems.itemnumber), 0) = 0,
        'CLOSE MATCH - 000 matches for deleted items',
        Concat_Ws(
          '',
          'CLOSE MATCH - ',
          Lpad(Count(DISTINCT deleteditems.itemnumber), 3, '0'),
          ' deleted items with a barcode beginning with ',
          Left(
            Trim(<<Enter barcode number>>),
            Length(Trim(<<Enter barcode number>>)) - 2
          ),
          ' at ',
          deleteditems.homebranch
        )
      )
    FROM deleteditems
    WHERE deleteditems.barcode LIKE Concat(
        Left(
          Trim(<<Enter barcode number>>),
          Length(Trim(<<Enter barcode number>>)) - 2
        ),
        '%'
      )
    GROUP BY deleteditems.homebranch
  ) third_level,
  (
    SELECT If(
        Coalesce(Count(DISTINCT items.itemnumber), 0) = 0,
        'GOOD MATCH - 000 matches for active items',
        Concat_Ws(
          '',
          'GOOD MATCH - ',
          Lpad(Count(DISTINCT items.itemnumber), 3, '0'),
          ' active items with a barcode beginning with ',
          Left(
            Trim(<<Enter barcode number>>),
            Length(Trim(<<Enter barcode number>>)) - 3
          ),
          ' at ',
          items.homebranch
        )
      ) AS match_four
    FROM items
    WHERE items.barcode LIKE Concat(
        Left(
          Trim(<<Enter barcode number>>),
          Length(Trim(<<Enter barcode number>>)) - 3
        ),
        '%'
      )
    UNION
    SELECT If(
        Coalesce(Count(DISTINCT deleteditems.itemnumber), 0) = 0,
        'GOOD MATCH - 000 matches for deleted items',
        Concat_Ws(
          '',
          'GOOD MATCH - ',
          Lpad(Count(DISTINCT deleteditems.itemnumber), 3, '0'),
          ' deleted items with a barcode beginning with ',
          Left(
            Trim(<<Enter barcode number>>),
            Length(Trim(<<Enter barcode number>>)) - 3
          ),
          ' at ',
          deleteditems.homebranch
        )
      )
    FROM deleteditems
    WHERE deleteditems.barcode LIKE Concat(
        Left(
          Trim(<<Enter barcode number>>),
          Length(Trim(<<Enter barcode number>>)) - 3
        ),
        '%'
      )
    GROUP BY deleteditems.homebranch
  ) fourth_level,
  (
    SELECT If(
        Coalesce(Count(DISTINCT items.itemnumber), 0) = 0,
        '0 exact matches for active items',
        Concat_Ws(
          '',
          'EXACT MATCH - ',
          Count(DISTINCT items.itemnumber),
          ' active items with a barcode beginning with ',
          Left(
            Trim(<<Enter barcode number>>),
            Length(Trim(<<Enter barcode number>>))
          ),
          ' at ',
          items.homebranch, 
          Concat( 
            ' <a class="next_btn next_green noprint" ',
            'style="margin-left: 10px" ',
            'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
            items.biblionumber, 
            '\" target="_blank">Go to biblio</a>' 
          )
        )
      ) AS match_one
    FROM items
    WHERE items.barcode LIKE Concat(
        Left(
          Trim(<<Enter barcode number>>),
          Length(Trim(<<Enter barcode number>>))
        ),
        '%'
      )
    UNION
    SELECT If(
        Coalesce(Count(DISTINCT deleteditems.itemnumber), 0) = 0,
        '0 exact matches for deleted items',
        Concat_Ws(
          '',
          'EXACT MATCH - ',
          Count(DISTINCT deleteditems.itemnumber),
          ' deleted items with a barcode beginning with ',
          Left(
            Trim(<<Enter barcode number>>),
            Length(Trim(<<Enter barcode number>>))
          ),
          ' at ',
          deleteditems.homebranch
        )
      )
    FROM deleteditems
    WHERE deleteditems.barcode LIKE Concat(
        Left(
          Trim(<<Enter barcode number>>),
          Length(Trim(<<Enter barcode number>>))
        ),
        '%'
      )
  ) first_level


























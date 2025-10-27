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
Date last run: 2025-10-22 09:29:54

----------

Public: 0
Expiry: 300

----------

 
 
   
 
    Gives a count of barcode numbers with matching starting strings grouped by item home library 
 
     
      Counts barcode numbers currently in the items and deleteditems tables 
      counts items by home library 
      grouped by home library 
      links to barcode numbers that are exact matches 
     
 
   
 
   
 
     
 
     
 
     
      If you search for an item barcode number or check in an item barcode number and get zero results, you can use this report to find barcode numbers that have similar starting strings to that barcode number.  For example, if you scan barcode number 1234567891234 this report will search for:
    
      1234567891234 as an exact match in items and deleteditems
      123456789123 as the beginning of any barcode in items and deleteditems
      12345678912 as the beginning of any barcode in items and deleteditems
      1234567891 as the beginning of any barcode in items and deleteditems
    
     
 
     
      If you are trying to find the home library for an item, if there is an exact match for that barcode number, this report will show you that item's home library.  If there is no exact match, it will show you the home library for item barcodes extremely close in sequence - the more extremely close matches, the more likely it is that the home library of the item you cannot find was owned by that library.   If there are no extremely close matches, it will show you the home library for item barcodes close in sequence - the more close matches, the more likely it is that the home library of the item you cannot find was owned by that library.  If there are no close matches, it will show you the home library for item barcodes that are good matches - the more good matches, the more likely it is that the home library of the item you cannot find was owned by that library.
     
 
   
 
   
 
     
      #itemnotfound
      #barcodematch 
     
 
   
 
   
 
 

----------
*/



SELECT concat_ws(
    '',
    Concat(
      'You searched for: ',
      &lt;&gt;,
      ''
    ),
    GROUP_CONCAT(
      DISTINCT first_level.match_one
      ORDER BY first_level.match_one DESC SEPARATOR ''
    ),
    Concat( 
      'An exact match means that this barcode number matches an item currently in', 
      'the catalog or that has been deleted in the previous 13 months',
      '=========='
    ),
    GROUP_CONCAT(
      DISTINCT second_level.match_two
      ORDER BY second_level.match_two DESC SEPARATOR ''
    ),
    Concat('An extremely close match means that the first ',
    (Length(Trim(&lt;&gt;)) - 1),
    ' digits of this barcode numbermatch the first ',
    (Length(Trim(&lt;&gt;)) - 1),
    ' digits of barcode numbers in the "items" or "deleteditems" tables',
    'Generally speaking, there should be no more than 10 extremely close',
    'matches possible unless some barcode numbers have been recycled.',
    '=========='),
    GROUP_CONCAT(
      DISTINCT third_level.match_three
      ORDER BY third_level.match_three DESC SEPARATOR ''
    ),
    Concat('A close match means that the first ',
    (Length(Trim(&lt;&gt;)) - 2),
    ' digits of this barcode number match the first ',
    (Length(Trim(&lt;&gt;)) - 2),
    ' digitsof barcode numbers in the "items" or "deleteditems" tables',
    'Generally speaking, there should be no more than 100 close',
    'matches possible unless some barcode numbers have been recycled.',
    '=========='),
    GROUP_CONCAT(
      DISTINCT fourth_level.match_four
      ORDER BY fourth_level.match_four DESC SEPARATOR ''
    ),
    Concat('A good match means that the first ',
    (Length(Trim(&lt;&gt;)) - 3),
    ' digits of this barcode number match the first ',
    (Length(Trim(&lt;&gt;)) - 3),
    ' digitsof barcode numbers in the "items" or "deleteditems" tables',
    'Generally speaking, there should be no more than 1000 good',
    'matches possible unless some barcode numbers have been recycled.',
    '==========')
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
            Trim(&lt;&gt;),
            Length(Trim(&lt;&gt;)) - 1
          ),
          ' at ',
          items.homebranch
        )
      ) AS match_two
    FROM items
    WHERE items.barcode LIKE Concat(
        Left(
          Trim(&lt;&gt;),
          Length(Trim(&lt;&gt;)) - 1
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
            Trim(&lt;&gt;),
            Length(Trim(&lt;&gt;)) - 1
          ),
          ' at ',
          deleteditems.homebranch
        )
      )
    FROM deleteditems
    WHERE deleteditems.barcode LIKE Concat(
        Left(
          Trim(&lt;&gt;),
          Length(Trim(&lt;&gt;)) - 1
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
            Trim(&lt;&gt;),
            Length(Trim(&lt;&gt;)) - 2
          ),
          ' at ',
          items.homebranch
        )
      ) AS match_three
    FROM items
    WHERE items.barcode LIKE Concat(
        Left(
          Trim(&lt;&gt;),
          Length(Trim(&lt;&gt;)) - 2
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
            Trim(&lt;&gt;),
            Length(Trim(&lt;&gt;)) - 2
          ),
          ' at ',
          deleteditems.homebranch
        )
      )
    FROM deleteditems
    WHERE deleteditems.barcode LIKE Concat(
        Left(
          Trim(&lt;&gt;),
          Length(Trim(&lt;&gt;)) - 2
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
            Trim(&lt;&gt;),
            Length(Trim(&lt;&gt;)) - 3
          ),
          ' at ',
          items.homebranch
        )
      ) AS match_four
    FROM items
    WHERE items.barcode LIKE Concat(
        Left(
          Trim(&lt;&gt;),
          Length(Trim(&lt;&gt;)) - 3
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
            Trim(&lt;&gt;),
            Length(Trim(&lt;&gt;)) - 3
          ),
          ' at ',
          deleteditems.homebranch
        )
      )
    FROM deleteditems
    WHERE deleteditems.barcode LIKE Concat(
        Left(
          Trim(&lt;&gt;),
          Length(Trim(&lt;&gt;)) - 3
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
            Trim(&lt;&gt;),
            Length(Trim(&lt;&gt;))
          ),
          ' at ',
          items.homebranch, 
          Concat( 
            ' Go to biblio' 
          )
        )
      ) AS match_one
    FROM items
    WHERE items.barcode LIKE Concat(
        Left(
          Trim(&lt;&gt;),
          Length(Trim(&lt;&gt;))
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
            Trim(&lt;&gt;),
            Length(Trim(&lt;&gt;))
          ),
          ' at ',
          deleteditems.homebranch
        )
      )
    FROM deleteditems
    WHERE deleteditems.barcode LIKE Concat(
        Left(
          Trim(&lt;&gt;),
          Length(Trim(&lt;&gt;))
        ),
        '%'
      )
  ) first_level


























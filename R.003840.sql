/*
R.003840

----------

Name: GHW - Barcode matching for "Item not found" barcodes
Created by: George Williams

----------

Group: -
     -

Created on: 2024-06-04 12:37:48
Modified on: 2026-06-15 15:26:36
Date last run: 2026-08-24 20:23:00

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

<style>

  .report_hidden {
    display:  none
  }

  .accordion .accordion-button {
    font-size:  1.1em !important;
    color:  #fff !important;
    font-weight:  900
  }

  .next_report_function .accordion-header * {
    background-color:  #df6320 !important;
    color:  #fff !important
  }

  .next_report_notes .accordion-header * {
    background-color:  #dfc220 !important;
    color:  #000 !important
  }

  .next_report_instructions .accordion-header * {
    background-color:  #3ddf20 !important;
    color:  #000 !important
  }

  .next_report_resources .accordion-header * {
    background-color:  #1f9bde !important;
    color:  #fff !important
  }

  .next_report_training .accordion-header * {
    background-color:  #6320df !important;
    color:  #fff !important
  }

  .accordion-collapse.collapse * {
    background-color:  #e6e6e6;
    color:  #000
  }

  .accordion-body h3 {
    font-size:  1.5em !important
  }

  .report_section {
    border:  2px solid #000;
    border-radius:  8px;
    margin:  10px;
    padding:  15px
  }

  .resources_btn, .training_btn, .direct_download_btn {
    padding:  10px;
    margin:  10px 0 0;
    display:  inline-block;
    font-weight:  650;
    line-height:  1.5;
    text-align:  center;
    vertical-align:  middle;
    white-space:  nowrap;
    color:  #000
  }

  .resources_btn {
    border:  1px solid #555;
    border-radius:  4px;
    background:  #dfc220 !important
  }

  .training_btn {
    border:  1px solid #555;
    border-radius:  4px;
    background:  #3ddf20 !important
  }

  .direct_download_btn {
    color:  #fff;
    border:  1px solid #555;
    border-radius:  4px;
    background:  indigo !important
  }
  .direct_download_btn:hover {
    color: #000000 !important;
    background: #D396FF !important;
  }

</style>

<!-- Overview -->

  <div class="next_report_summary">
    <br>

    <p id="report_id"><strong>Report number:</strong> 3840</p>

    <p id="report_name"><strong>Report name:</strong> Barcode matching for "Item not found" barcodes</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Counts barcode numbers currently in the items and deleteditems tables</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3840-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3840Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3840Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3840Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3840Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3840Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>counts barcode numbers in the items and deleteditems tables</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> currently in the items and deleteditems tables</li>

              <li><strong>AT:</strong> at all libraries</li>

              <li><strong>GROUPED BY:</strong> home library</li>

              <li><strong>SORTED BY:</strong> type of match</li>

              <li><strong>CONTAINS LINKS:</strong> links to barcode numbers that are exact matches</li>
            </ul>


            <span style="display: none;">
            <p> - </p>
            </span>

          </div>

        </div>
      </div>

    </div>

<!-- Notes section -->
    <div id="accordion_3840-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_3840Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3840Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_3840Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_3840Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3840Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>How this report works:</h4>
            <p>If you search for an item barcode number or check in an item barcode number and get zero results, you can use this report to find barcode numbers that have similar starting strings to that barcode number. For example, if you scan barcode number 1234567891234 this report will search for: <br><br># 1234567891234 as an exact match in items and deleteditems<br># 123456789123 as the beginning of any barcode in items and deleteditems<br># 12345678912 as the beginning of any barcode in items and deleteditems<br># 1234567891 as the beginning of any barcode in items and deleteditems<br><br>If you are trying to find the home library for an item, if there is an exact match for that barcode number, this report will show you that item's home library. If there is no exact match, it will show you the home library for item barcodes extremely close in sequence - the more extremely close matches, the more likely it is that the home library of the item you cannot find was owned by that library. If there are no extremely close matches, it will show you the home library for item barcodes close in sequence - the more close matches, the more likely it is that the home library of the item you cannot find was owned by that library. If there are no close matches, it will show you the home library for item barcodes that are good matches - the more good matches, the more likely it is that the home library of the item you cannot find was owned by that library. </p>
          </div>

          <div id="notes_2" class="report_section report_hidden">
            <h4> NOTE_TWO_TITLE </h4>
            <p> NOTE_TWO_CONTENT </p>
          </div>

          <div id="notes_3" class="report_section report_hidden">
            <h4> NOTE_THREE_TITLE </h4>
            <p> NOTE_THREE_CONTENT </p>
          </div>

          <div id="notes_4" class="report_section report_hidden">
            <h4> NOTE_FOUR_TITLE </h4>
            <p> NOTE_FOUR_CONTENT </p>
          </div>

          <div id="notes_5" class="report_section report_hidden">
            <h4> NOTE_FIVE_TITLE </h4>
            <p> NOTE_FIVE_CONTENT </p>
          </div>

        </div>
      </div>

    </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#itemnotfound</p>
    <p>#barcodematch</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
  </div>

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


























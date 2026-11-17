/*
R.004004

----------

Name: GHW - Titles with cover images and links to Amazon and Google
Created by: George Williams

----------

Group: -
     -

Created on: 2026-10-19 16:29:27
Modified on: 2026-11-11 14:21:39
Date last run: 2026-11-16 10:29:53

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

    <p id="report_id"><strong>Report number:</strong> 4004</p>

    <p id="report_name"><strong>Report name:</strong> Get Amazon cover images by ISBN when available</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Grabs cover images from Amazon if available by the Amazon API</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_4004-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_4004Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_4004Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_4004Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_4004Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_4004Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Grabs cover images from Amazon if available by the Amazon API</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> results for titles currently in the collection</li>

              <li><strong>AT:</strong> at the library you specify</li>

              <li><strong>GROUPED BY:</strong> biblionumber</li>

              <li><strong>SORTED BY:</strong> item added date</li>

              <li><strong>CONTAINS LINKS:</strong> Biblio, edit biblio, Amazon search by title and author, Amazon search by ISBN, Google Books search by title and author, Google Books search by ISBN</li>
            </ul>


            <p>Asks for item home library, shelving location, item type, collection code and date of the oldest items to be included</p>

          </div>

        </div>
      </div>

    </div>

<!-- Notes section -->
    <div id="accordion_4004-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_4004Open-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_4004Open-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_4004Open-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_4004Open-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_4004Open-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Amazon API</h4>
            <p>This uses the Amazon cover images API.  Sometimes a title will have a cover image on Amazon, but, for whatever reason, the API won't grab that image.  This is particularly true when the ISBN starts with "979."  There is nothing that NEKLS staff can do to change the Amazon API - this report works as-is with no guarantee that a cover image will be provided by the API or that it will be the correct image.</p>
          </div>

          <div id="notes_2" class="report_section">
            <h4>ISBN</h4>
            <p>The Amazon cover images API only works with ISBNs.  If a record doesn't have an ISBN (DVDs and video games, for example) then no cover image will be returned by Amazon.</p>
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

<!-- Training section -->
    <div id="accordion_4004-5" class="accordion-item next_report_training ">

      <h2 class="accordion-header" id="panelsStay_4004Open-headingFive">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_4004Open-collapseFive" aria-expanded="false"
          aria-controls="panelsStay_4004Open-collapseFive">

          Training available

        </button>

      </h2>

      <div id="panelsStay_4004Open-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_4004Open-headingFive" style="color: white !important;">
        <div class="accordion-body">

          <div class="container text-center">
            <div class="row">


              <div id="training_link" class="col-md-3">
                <p><a href="ASPEN_LINK" target="_blank" class="training_btn">Online training</a></p>
              </div>


              <div id="training_link" class="col-md-3">
                <p><a href="ASPEN_PDF" target="_blank" class="training_btn">Training handout</a></p>
              </div>

              <div id="training_link" class="col-md-3">
                <p><a href="YOUTUBE_LINK" target="_blank" class="training_btn">Video training</a></p>
              </div>

            </div>
          </div>
        </div>
      </div>

    </div>

  </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#cover images</p>
    <p>#</p>
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



SELECT 
  biblio.biblionumber,
  Concat_WS(
    '',
    'Item added: ',
    items.dateaccessioned,
    '<br />',
    'Item ID: ',
    items.itemnumber,
    '<br /><br />',
    'Location: ',
    locs.lib,
    '<br />',
    'Iteem Type: ',
    itemtypes.description,
    '<br />',
    'Collection Code: ',
    ccodes.lib,
    '<br /><br />',
    'Title: ',
    biblio.title,
    '<br />',
    If(
      biblio.author IS NULL,
      '',
      Concat(
        'Author: ',
        biblio.author,
        '<br />'
      )
    ),
    'Call #: ',
    items.itemcallnumber
  ) AS RECORD_INFO,
  COALESCE(
    CONCAT(
      '<img src="https://images-na.ssl-images-amazon.com/images/P/',
      IF (
        LEFT(TRIM(biblioitems.isbn), 3) like '97_',
        CONCAT(
          SUBSTR(TRIM(biblioitems.isbn), 4, 9),
          REPLACE(
            MOD(
              11 - MOD (
                CONVERT(
                  SUBSTR(TRIM(biblioitems.isbn), 4, 1),
                  UNSIGNED INTEGER
                ) * 10 + CONVERT(
                  SUBSTR(TRIM(biblioitems.isbn), 5, 1),
                  UNSIGNED INTEGER
                ) * 9 + CONVERT(
                  SUBSTR(TRIM(biblioitems.isbn), 6, 1),
                  UNSIGNED INTEGER
                ) * 8 + CONVERT(
                  SUBSTR(TRIM(biblioitems.isbn), 7, 1),
                  UNSIGNED INTEGER
                ) * 7 + CONVERT(
                  SUBSTR(TRIM(biblioitems.isbn), 8, 1),
                  UNSIGNED INTEGER
                ) * 6 + CONVERT(
                  SUBSTR(TRIM(biblioitems.isbn), 9, 1),
                  UNSIGNED INTEGER
                ) * 5 + CONVERT(
                  SUBSTR(TRIM(biblioitems.isbn), 10, 1),
                  UNSIGNED INTEGER
                ) * 4 + CONVERT(
                  SUBSTR(TRIM(biblioitems.isbn), 11, 1),
                  UNSIGNED INTEGER
                ) * 3 + CONVERT(
                  SUBSTR(TRIM(biblioitems.isbn), 12, 1),
                  UNSIGNED INTEGER
                ) * 2,
                11
              ),
              11
            ),
            '10',
            'X'
          )
        ),
        LEFT(TRIM(biblioitems.isbn), 10)
      ),
      '.01.MZZZZZZZZZ.jpg">'
    ),
    '<img src="https://nekls.bywatersolutions.com/images/98330eca6ebb4e806376d16ccee5c56b_noimage.png" style="max-width:75px;">'
  ) AS AMAZON_IMAGE_FOR_THIS_ISBN,
  CASE
    WHEN items.homebranch LIKE 'ATCHISON' THEN CONCAT(
      'https://atchison.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'BALDWIN' THEN CONCAT(
      'https://baldwin.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'BASEHOR' THEN CONCAT(
      'https://basehor.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'BERN' THEN CONCAT(
      'https://bern.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'BONNERSPGS' THEN CONCAT(
      'https://bonnersprings.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'BURLINGAME' THEN CONCAT(
      'https://burlingame.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'CARBONDALE' THEN CONCAT(
      'https://carbondale.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'CENTRALIA' THEN CONCAT(
      'https://centralia.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'CORNING' THEN CONCAT(
      'https://corning.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'DONI%' THEN CONCAT(
      'https://doniphan.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'EFFINGHAM' THEN CONCAT(
      'https://effingham.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'EUDORA' THEN CONCAT(
      'https://eudora.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'EVEREST' THEN CONCAT(
      'https://barnesreadingroom.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'HIAWATHA' THEN CONCAT(
      'https://hiawathalibrary.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'HIGH_CC' THEN CONCAT(
      'https://highlandcommunitycollege.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'HOLTON' THEN CONCAT(
      'https://holton.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'HORTON' THEN CONCAT(
      'https://horton.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'LANSING' THEN CONCAT(
      'https://lansing.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'LEAVENWRTH' THEN CONCAT(
      'https://leavenworth.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'LINWOOD' THEN CONCAT(
      'https://linwood.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'LYNDON' THEN CONCAT(
      'https://lyndon.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'MCLOUTH' THEN CONCAT(
      'https://mclouth.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'MERIDEN' THEN CONCAT(
      'https://meridenozawkie.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'NEKLS' THEN CONCAT(
      'https://nekls.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'NORTONVLLE' THEN CONCAT(
      'https://nortonville.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'OSAGECITY' THEN CONCAT(
      'https://osagecity.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'OSAWATOMIE' THEN CONCAT(
      'https://osawatomie.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'OSKALOOSA' THEN CONCAT(
      'https://oskaloosa.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'OTTAWA' THEN CONCAT(
      'https://ottawa.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'OVERBROOK' THEN CONCAT(
      'https://overbrook.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'PAOLA' THEN CONCAT(
      'https://paola.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'PERRY' THEN CONCAT(
      'https://perrylecompton.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'PH' THEN CONCAT(
      'https://prairiehills.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'POMONA' THEN CONCAT(
      'https://pomona.mykansaslibrary.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'RICHMOND' THEN CONCAT(
      'https://richmond.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'ROSSVILLE' THEN CONCAT(
      'https://rossville.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'SABETHA' THEN CONCAT(
      'https://marycottonlibrary.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'SENECA' THEN CONCAT(
      'https://seneca.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'SILVERLAKE' THEN CONCAT(
      'https://silverlake.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'TONGANOXIE' THEN CONCAT(
      'https://tonganoxie.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'VALLEYFALL' THEN CONCAT(
      'https://valleyfalls.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'WELLSVILLE' THEN CONCAT(
      'https://wellsville.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'WETMORE' THEN CONCAT(
      'https://wetmore.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'WILLIAMSBG' THEN CONCAT(
      'https://williamsburg.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'WINCHESTER' THEN CONCAT(
      'https://winchester.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'PHSES' THEN CONCAT(
      'https://sabethaelementary.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'PHSMS' THEN CONCAT(
      'https://sabethamiddle.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'PHSHS' THEN CONCAT(
      'https://sabethahigh.nextkansas.org/Record/',
      biblio.biblionumber
    )
    WHEN items.homebranch LIKE 'PHAXTELL' THEN CONCAT(
      'https://axtellschool.nextkansas.org/Record/',
      biblio.biblionumber
    )
    ELSE 'X'
  END as ASPEN_URL,
  CONCAT_WS(
    '',
    '<a class="btn btn-primary btn-sm" style="margin-top: 1em;" href="',
    'https://www.amazon.com/s?i=stripbooks&rh=p_27%3A',
    REPLACE(
      REGEXP_REPLACE(biblio.author, '[[:punct:]]', ''),
      ' ',
      '%2B'
    ),
    '%2Cp_28%3A',
    REPLACE(
      REGEXP_REPLACE(biblio.title, '[[:punct:]]', ''),
      ' ',
      '%2B'
    ),
    '" target="_blank">Search Amazon by Author/Title</a>',
    '<br /><br />',
    '<a class="btn btn-primary btn-sm" style="margin-top: 1em;" href="',
    Concat(
      'https://www.amazon.com/s?k=',
      REPLACE(
        REGEXP_REPLACE(biblioitems.isbn, '[[:punct:]]', ''),
        ' ',
        '%2B'
      )
    ),
    '" target="_blank">Search this ISBN on Amazon</a>',
    '<br /><br />',
    '<a class="btn btn-primary btn-sm" style="margin-top: 1em;" href="',
    'https://www.google.com/search?udm=36&q=',
    REPLACE(
      REGEXP_REPLACE(biblio.author, '[[:punct:]]', ''),
      ' ',
      '%2B'
    ),
    REPLACE(
      REGEXP_REPLACE(biblio.title, '[[:punct:]]', ''),
      ' ',
      '%2B'
    ),
    '" target="_blank">Search Google Books by Author/Title</a>',
    '<br /><br />',
    '<a class="btn btn-primary btn-sm" style="margin-top: 1em;" href="',
    Concat(
      'https://www.google.com/search?udm=36&q=',
      CASE
    WHEN TRIM(biblioitems.isbn) REGEXP '^979[0-9]+([[:space:]]*\\|[[:space:]]*979[0-9]+)*$'
      THEN SUBSTRING_INDEX(TRIM(biblioitems.isbn), ' | ', 1)
    ELSE SUBSTRING_INDEX(
           REGEXP_REPLACE(
             TRIM(biblioitems.isbn),
             '^(979[0-9]+[[:space:]]*\\|[[:space:]]*)+',
             ''
           ),
           ' | ',
           1
         )
  END
    ),
    '" target="_blank">Search this ISBN on Google Books</a>'
  ) as EXTERNAL_LINKS  
FROM 
  biblio
  JOIN biblioitems ON biblioitems.biblionumber = biblio.biblionumber
  JOIN items ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'LOC'
  ) locs ON locs.authorised_value = items.permanent_location
  LEFT JOIN (
    SELECT authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM authorised_values
    WHERE authorised_values.category = 'CCODE'
  ) ccodes ON ccodes.authorised_value = items.ccode
  LEFT JOIN itemtypes ON itemtypes.itemtype = items.itype
WHERE 
  items.homebranch LIKE <<Choose your library|ZBRAN>>
  AND items.permanent_location IN <<Choose a shelving location|LOC:in>>
  AND items.itype IN <<Choose an item type|itemtypes:in>>
  AND items.ccode IN <<Choose a collection code|CCODE:in>>
  AND items.dateaccessioned > <<Added after|date>>
ORDER BY 
  items.dateaccessioned DESC,
  items.itemnumber DESC


























/*
R.003150

----------

Name: GHW - Hootsuite scheduled post generator - 7 new titles
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2018-12-27 12:02:59
Modified on: 2022-12-02 12:12:43
Date last run: 2022-12-02 12:12:45

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of titles to create scheduled media posts with</p>
<ul><li>Shows the 7 most recent acquisitions in specified areas of the collection</li>
<li>At all Next libraries</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3150&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  adult_book.NEWSTUFF AS TEXT_TO_PASTE_TO_HOOTSUITE
FROM
  (
    SELECT
      Concat(
        "Recently added fiction:<br /><br />",
        Upper(
          Replace(
            Replace(
              Replace(
                Replace(
                  biblio.title, 
                  " /", 
                  ""
                ), 
                " :", 
                ""
              ), 
              " ;", 
              ""
            ), 
            ".", 
            ""
          )
        ),
        "<br /><br />https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=", 
        biblio.biblionumber
      ) AS NEWSTUFF,
      biblio.biblionumber
    FROM
      biblio JOIN
      items ON items.biblionumber = biblio.biblionumber
    WHERE
      items.barcode <> "" AND
      (items.itype = "BOOK" OR
        items.itype = "PBBKNEW") AND
      items.location LIKE '%AD%' AND
      items.ccode = 'FICTION' AND
      (items.notforloan = 0 OR
        items.notforloan IS NULL) AND
      (items.damaged = 0 OR
        items.damaged IS NULL) AND
      (items.itemlost = 0 OR
        items.itemlost IS NULL) AND
      (items.withdrawn = 0 OR
        items.withdrawn IS NULL)
    ORDER BY
      biblio.biblionumber DESC
    LIMIT 1
  ) adult_book
UNION
SELECT
  adult_movie.NEWSTUFF
FROM
  (
    SELECT
      Concat("Recently added DVD:<br /><br />",
        Upper(
          Replace(
            Replace(
              Replace(
                Replace(
                  biblio.title, 
                  " /", 
                  ""
                ), 
                " :", 
                ""
              ), 
              " ;", 
              ""
            ), 
            ".", 
            ""
          )
        ),
        "<br /><br />https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=", 
        biblio.biblionumber
      ) AS NEWSTUFF,
      biblio.biblionumber
    FROM
      biblio JOIN
      items ON items.biblionumber = biblio.biblionumber
    WHERE
      items.barcode <> "" AND
      items.itype LIKE "NVID%" AND
      items.location LIKE '%AD%' AND
      items.ccode = 'VID_D' AND
      (items.notforloan = 0 OR
        items.notforloan IS NULL) AND
      (items.damaged = 0 OR
        items.damaged IS NULL) AND
      (items.itemlost = 0 OR
        items.itemlost IS NULL) AND
      (items.withdrawn = 0 OR
        items.withdrawn IS NULL)
    ORDER BY
      biblio.biblionumber DESC
    LIMIT 1
  ) adult_movie
UNION
SELECT
  child_book.NEWSTUFF
FROM
  (
    SELECT
      Concat(
        "Recently added children's fiction:<br /><br />",
        Upper(
          Replace(
            Replace(
              Replace(
                Replace(
                  biblio.title, 
                  " /", 
                  ""
                ), 
                " :", 
                ""
              ), 
              " ;", 
              ""
            ), 
            ".", 
            ""
          )
        ),
        "<br /><br />https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=", 
        biblio.biblionumber
      ) AS NEWSTUFF,
      biblio.biblionumber
    FROM
      biblio JOIN
      items ON items.biblionumber = biblio.biblionumber
    WHERE
      items.barcode <> "" AND
      (items.itype = "BOOK" OR
        items.itype = "PBBKNEW") AND
      (items.location LIKE '%CH%' OR
        items.location LIKE '%JU%') AND
      items.ccode = 'FICTION' AND
      (items.notforloan = 0 OR
        items.notforloan IS NULL) AND
      (items.damaged = 0 OR
        items.damaged IS NULL) AND
      (items.itemlost = 0 OR
        items.itemlost IS NULL) AND
      (items.withdrawn = 0 OR
        items.withdrawn IS NULL)
    ORDER BY
      biblio.biblionumber DESC
    LIMIT 1
  ) child_book
UNION
SELECT
  child_movie.NEWSTUFF
FROM
  (
    SELECT
      Concat(
        "Recently added children's DVD:<br /><br />",
        Upper(
          Replace(
            Replace(
              Replace(
                Replace(
                  biblio.title, 
                  " /", 
                  ""
                ), 
                " :", 
                ""
              ), 
              " ;", 
              ""
            ), 
            ".", 
            ""
          )
        ),
        "<br /><br />https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=", 
        biblio.biblionumber
      ) AS NEWSTUFF,
      biblio.biblionumber
    FROM
      biblio JOIN
      items ON items.biblionumber = biblio.biblionumber
    WHERE
      items.barcode <> "" AND
      items.itype LIKE "NVID%" AND
      (items.location LIKE '%CH%' OR
        items.location LIKE '%JU%') AND
      items.ccode = 'VID_D' AND
      (items.notforloan = 0 OR
        items.notforloan IS NULL) AND
      (items.damaged = 0 OR
        items.damaged IS NULL) AND
      (items.itemlost = 0 OR
        items.itemlost IS NULL) AND
      (items.withdrawn = 0 OR
        items.withdrawn IS NULL)
    ORDER BY
      biblio.biblionumber DESC
    LIMIT 1
  ) child_movie
UNION
SELECT
  ya_book.NEWSTUFF
FROM
  (
    SELECT
      Concat(
        "Recently added young adult fiction:<br /><br />",
        Upper(
          Replace(
            Replace(
              Replace(
                Replace(
                  biblio.title, 
                  " /", 
                  ""
                ), 
                " :", 
                ""
              ), 
              " ;", 
              ""
            ), 
            ".", 
            ""
          )
        ),
        "<br /><br />https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=", 
        biblio.biblionumber
      ) AS NEWSTUFF,
      biblio.biblionumber
    FROM
      biblio JOIN
      items ON items.biblionumber = biblio.biblionumber
    WHERE
      items.barcode <> "" AND
      (items.itype = "BOOK" OR
        items.itype = 'NEWBOOK') AND
      items.location LIKE '%YA%' AND
      items.ccode = 'FICTION' AND
      (items.notforloan = 0 OR
        items.notforloan IS NULL) AND
      (items.damaged = 0 OR
        items.damaged IS NULL) AND
      (items.itemlost = 0 OR
        items.itemlost IS NULL) AND
      (items.withdrawn = 0 OR
        items.withdrawn IS NULL)
    ORDER BY
      biblio.biblionumber DESC
    LIMIT 1
  ) ya_book
UNION
SELECT
  adult_audio.NEWSTUFF
FROM
  (
    SELECT
      Concat("Recently added audiobook:<br /><br />",
        Upper(
          Replace(
            Replace(
              Replace(
                Replace(
                  biblio.title, 
                  " /", 
                  ""
                ), 
                " :", 
                ""
              ), 
              " ;", 
              ""
            ), 
            ".", 
            ""
          )
        ),
        "<br /><br />https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=", 
        biblio.biblionumber
      ) AS NEWSTUFF,
     biblio.biblionumber
    FROM
      biblio JOIN
      items ON items.biblionumber = biblio.biblionumber
    WHERE
      items.barcode <> "" AND
      items.itype LIKE "N_AB%" AND
      items.location LIKE '%AD%' AND
      items.ccode = 'BOOKONCD' AND
      (items.notforloan = 0 OR
        items.notforloan IS NULL) AND
      (items.damaged = 0 OR
        items.damaged IS NULL) AND
      (items.itemlost = 0 OR
        items.itemlost IS NULL) AND
      (items.withdrawn = 0 OR
        items.withdrawn IS NULL)
    ORDER BY
      biblio.biblionumber DESC
    LIMIT 1) adult_audio
UNION
SELECT
  child_audio.NEWSTUFF
FROM
  (
    SELECT
      Concat(
        "Recently added children's audiobook:<br /><br />",
        Upper(
          Replace(
            Replace(
              Replace(
                Replace(
                  biblio.title, 
                  " /", 
                  ""
                ), 
                " :", 
                ""
              ), 
              " ;", 
              ""
            ), 
            ".", 
            ""
          )
        ),
        "<br /><br />https://nextkansas.org/cgi-bin/koha/opac-detail.pl?biblionumber=", 
        biblio.biblionumber
      ) AS NEWSTUFF,
      biblio.biblionumber
    FROM
      biblio JOIN
      items ON items.biblionumber = biblio.biblionumber
    WHERE
      items.barcode <> "" AND
      items.itype LIKE "N_AB%" AND
      (items.location LIKE '%CH%' OR
        items.location LIKE '%JU%') AND
      items.ccode = 'BOOKONCD' AND
      (items.notforloan = 0 OR
        items.notforloan IS NULL) AND
      (items.damaged = 0 OR
        items.damaged IS NULL) AND
      (items.itemlost = 0 OR
        items.itemlost IS NULL) AND
      (items.withdrawn = 0 OR
        items.withdrawn IS NULL)
    ORDER BY
      biblio.biblionumber DESC
    LIMIT 1) child_audio
LIMIT 7


























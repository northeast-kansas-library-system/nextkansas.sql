/*
R.002865

----------

Name: GHW - Overdue Notice Template
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-12-31 19:25:57
Modified on: 2022-03-22 15:34:49
Date last run: 2022-03-22 15:35:22

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows overdue notice template automatically sent by Koha</p>
<ul><li>shows notices template for the library you specify</li>
<li>allows you to specify which template you want to look at</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report was created to work with the new notices NExpress will start using on January 1, 2016.</p>
<p>You should run the report and then download the results into Excel or another spreadsheet program.  The results will be very hard to read on the screen in Koha.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2865&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  branchess.branchname,
  Coalesce(codes_branches.message_transport_type,
  codes_blanks.message_transport_type) AS TYPE,
  Coalesce(codes_branches.code, codes_blanks.code) AS LETTER_CODE,
  Coalesce(codes_branches.name, codes_blanks.name) AS LETTER_NAME,
  Coalesce(codes_branches.title, codes_blanks.title) AS LETTER_TITLE,
  Coalesce(codes_branches.content, codes_blanks.content) AS LETTER_CONTENT
FROM
  (SELECT
      branches.branchname,
      branches.branchcode,
      letter.code,
      letter.message_transport_type
    FROM
      branches,
      letter
    WHERE
      letter.code LIKE "OD%"
    GROUP BY
      branches.branchname,
      branches.branchcode,
      letter.code,
      letter.message_transport_type) branchess LEFT JOIN
  (SELECT
      letter.branchcode,
      letter.message_transport_type,
      letter.code,
      letter.name,
      letter.title,
      letter.content
    FROM
      letter
    WHERE
      letter.code LIKE "OD%" AND
      letter.branchcode NOT LIKE ""
    GROUP BY
      letter.branchcode,
      letter.message_transport_type,
      letter.code
    ORDER BY
      letter.branchcode,
      letter.message_transport_type,
      letter.code) codes_branches ON codes_branches.branchcode =
      branchess.branchcode AND
      codes_branches.code = branchess.code AND
      codes_branches.message_transport_type = branchess.message_transport_type
  LEFT JOIN
  (SELECT
      letter.branchcode,
      letter.message_transport_type,
      letter.code,
      letter.name,
      letter.title,
      letter.content
    FROM
      letter
    WHERE
      letter.code LIKE "OD%" AND
      letter.branchcode LIKE ""
    GROUP BY
      letter.branchcode,
      letter.message_transport_type,
      letter.code
    ORDER BY
      letter.branchcode,
      letter.message_transport_type,
      letter.code) codes_blanks ON codes_blanks.code = branchess.code AND
      codes_blanks.message_transport_type = branchess.message_transport_type
WHERE
  branchess.branchcode LIKE <<Choose a branch|ZBRAN>> AND
  branchess.code LIKE <<Choose an overdue notice|ZODUE>>
GROUP BY
  branchess.branchname,
  Coalesce(codes_branches.message_transport_type,
  codes_blanks.message_transport_type),
  Coalesce(codes_branches.code, codes_blanks.code),
  Coalesce(codes_branches.name, codes_blanks.name),
  Coalesce(codes_branches.title, codes_blanks.title),
  Coalesce(codes_branches.content, codes_blanks.content)


























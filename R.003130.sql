/*
R.003130

----------

Name: GHW - Lynda count - built for RHASTINGS
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-10-17 13:35:05
Modified on: 2019-06-04 12:02:17
Date last run: 2023-02-02 16:33:55

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a count of Lynda.com users at each library</p>
<ul><li>Shows count of users based on the most recent report from Lynda.com</li>
<li>Shows users at all member libraries</li>
<li>grouped by and sorted by library name</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<ol>
  <li>Open Google spreadsheet titled "<a href="https://docs.google.com/spreadsheets/d/1z2Gc4Dc4_cr0NarxBPT92O3CDpAumiqLj4HoYRWlLqU/edit?usp=sharing" target="_blank">Lynda.com report helper</a>"</li>
  <li>Copy all of the barcode numbers from the Lynda.com report into column A of the Google sheet</li>
  <li>Copy all of the cells from column B of the Google sheet that contain barcode numbers</li>
  <li>Edit this report</li> 
  <li>Paste the copied cells from the Google sheet between the comment lines of this report</li>
  <li>Click the "Update SQL" button</li>
  <li>Once updated, click the "Run report" button</li>
</ol>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3130&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3130">Click here to download as a csv file</a></p>
</div>

----------
*/



SELECT
  branches.branchname,
  Coalesce(lyndaborrowers.Count_borrowernumber, "-") AS LYNDA_USERS_COUNT
FROM
  branches
  LEFT JOIN (SELECT
        borrowers.branchcode,
        Count(borrowers.borrowernumber) AS Count_borrowernumber
      FROM
        borrowers
      WHERE

/* Remove old data between commented blocks, then paste new data from the Google sheet below this line */
(borrowers.cardnumber = 'PLEA0001190498') OR
(borrowers.cardnumber = 'PLEA0001330000') OR
(borrowers.cardnumber = 'PLEA0000657529') OR
(borrowers.cardnumber = 'plea000121798c') OR
(borrowers.cardnumber = 'plea0001263839') OR
(borrowers.cardnumber = '1003030012080') OR
(borrowers.cardnumber = '1003009019508') OR
(borrowers.cardnumber = '1003030010079') OR
(borrowers.cardnumber = '2CZ9000006359') OR
(borrowers.cardnumber = 'PLEA0001234914') OR
(borrowers.cardnumber = '1003008009000') OR
(borrowers.cardnumber = '1003008043569') OR
(borrowers.cardnumber = 'PLEA0000609032') OR
(borrowers.cardnumber = '1003009023781') OR
(borrowers.cardnumber = '1003009001443') OR
(borrowers.cardnumber = 'PLEA000120300X') OR
(borrowers.cardnumber = '1003008052988') OR
(borrowers.cardnumber = 'RFEUERBACHER') OR
(borrowers.cardnumber = '1003008032059') OR
(borrowers.cardnumber = '1003008025927') OR
(borrowers.cardnumber = 'PLEA0001322221') OR
(borrowers.cardnumber = 'FROSTX020') OR
(borrowers.cardnumber = '1003030009175') OR
(borrowers.cardnumber = '1003006010235') OR
(borrowers.cardnumber = 'PLEA0001180846') OR
(borrowers.cardnumber = '1003008043731') OR
(borrowers.cardnumber = '1003008006760') OR
(borrowers.cardnumber = '1003025013818') OR
(borrowers.cardnumber = '1003008042948') OR
(borrowers.cardnumber = '1003011003420') OR
(borrowers.cardnumber = 'PLEA0001319300') OR
(borrowers.cardnumber = 'PLEA0001328020') OR
(borrowers.cardnumber = 'PLEA0001299502') OR
(borrowers.cardnumber = '26605300175201') OR
(borrowers.cardnumber = 'PLEA0001329523') OR
(borrowers.cardnumber = 'PLEA0001288844') OR
(borrowers.cardnumber = 'PLEA0001332873') OR
(borrowers.cardnumber = '1003008027715') OR
(borrowers.cardnumber = 'PLEA0001175020') OR
(borrowers.cardnumber = '1003030008377') OR
(borrowers.cardnumber = '1003008057672') OR
(borrowers.cardnumber = 'PLEA0001300631') OR
(borrowers.cardnumber = '1003011002747') OR
(borrowers.cardnumber = '2CZ9100017476+') OR
(borrowers.cardnumber = '1003009022569') OR
(borrowers.cardnumber = '1003009016591') OR
(borrowers.cardnumber = '1003008009633') OR
(borrowers.cardnumber = '1003008052468') OR
(borrowers.cardnumber = '2CZ9100017449+') OR
(borrowers.cardnumber = 'PLEA0001318476') OR
(borrowers.cardnumber = '1003008038452') OR
(borrowers.cardnumber = '1003011000002') OR
(borrowers.cardnumber = 'PLEA000118297C') OR
(borrowers.cardnumber = '1003030000108') OR
(borrowers.cardnumber = 'PLEA0001316884') OR
(borrowers.cardnumber = 'PLEA0001185122') OR
(borrowers.cardnumber = '1003030000003') OR
(borrowers.cardnumber = '1003008048388') OR
(borrowers.cardnumber = '1003008021710') OR
(borrowers.cardnumber = 'PLEA0001230976') OR
(borrowers.cardnumber = '1003012004502') OR
(borrowers.cardnumber = '1003008056060') OR
(borrowers.cardnumber = '1003008042784') OR
(borrowers.cardnumber = '1003019004367') OR
(borrowers.cardnumber = '1003008030353') OR
/* Remove old data between commented blocks, then paste new data from the Google sheet above this line */

        (borrowers.cardnumber = 'placeholder data')

      GROUP BY
        borrowers.branchcode) lyndaborrowers ON branches.branchcode = lyndaborrowers.branchcode
GROUP BY
  branches.branchname
ORDER BY
  branches.branchname
LIMIT
  100



























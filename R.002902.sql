/*
R.002902

----------

Name: GHW - Materials added count by item type and permanent location - previous calendar month
Created by: George H Williams

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2017-02-07 15:12:53
Modified on: 2021-05-02 20:47:18
Date last run: 2021-06-18 07:36:45

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Count of items added by shelving location and item type</p>
<ul><li>counts items added in the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped and sorted by home branch, location, and item type</li>
<li>includes total for the month at the bottom of the results</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2902&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  branch_itype.branchname,
  branch_itype.description,
  Coalesce(itemsall.Count_itemnumber, 0) AS ALL_ADDED_LM,
  Coalesce(itemsadult.Count_itemnumber, 0) AS ADULT_ADDED_LM,
  Coalesce(itemsya.Count_itemnumber, 0) AS YA_ADDED_LM,
  Coalesce(itemchild.Count_itemnumber, 0) AS CHILD_ADDED_LM,
  Coalesce(itemsother.Count_itemnumber, 0) AS OTHER_ADDED_LM
FROM
  (SELECT
     branches.branchname,
     itemtypes.description,
     branches.branchcode,
     itemtypes.itemtype
   FROM
     branches,
     itemtypes
   WHERE
     branches.branchcode LIKE <<Choose item home library|LBRANCH>>) branch_itype LEFT JOIN
  (SELECT
     Count(items.itemnumber) AS Count_itemnumber,
     items.itype,
     items.homebranch
   FROM
     items
   WHERE
     Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     items.itype,
     items.homebranch) itemsall ON itemsall.itype = branch_itype.itemtype AND
      itemsall.homebranch = branch_itype.branchcode LEFT JOIN
  (SELECT
     Count(items.itemnumber) AS Count_itemnumber,
     items.itype,
     items.homebranch
   FROM
     items
   WHERE
     Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
     (Coalesce(items.permanent_location, "CART") = 'ADULT' OR
         Coalesce(items.permanent_location, "CART") = 'BALDADULT' OR
         Coalesce(items.permanent_location, "CART") = 'LVPLADULT' OR
         Coalesce(items.permanent_location, "CART") = 'PAOLAADULT')
   GROUP BY
     items.itype,
     items.homebranch) itemsadult ON itemsadult.itype = branch_itype.itemtype
      AND
      itemsadult.homebranch = branch_itype.branchcode LEFT JOIN
  (SELECT
     Count(items.itemnumber) AS Count_itemnumber,
     items.itype,
     items.homebranch
   FROM
     items
   WHERE
     Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
     (Coalesce(items.permanent_location, "CART") = 'YOUNGADULT' OR
         Coalesce(items.permanent_location, "CART") LIKE '%YA%')
   GROUP BY
     items.itype,
     items.homebranch) itemsya ON itemsya.itype = branch_itype.itemtype AND
      itemsya.homebranch = branch_itype.branchcode LEFT JOIN
  (SELECT
     Count(items.itemnumber) AS Count_itemnumber,
     items.itype,
     items.homebranch
   FROM
     items
   WHERE
     Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
     Coalesce(items.permanent_location, "CART") LIKE '%CHILD%'
   GROUP BY
     items.itype,
     items.homebranch) itemchild ON itemchild.itype = branch_itype.itemtype AND
      itemchild.homebranch = branch_itype.branchcode LEFT JOIN
  (SELECT
     Count(items.itemnumber) AS Count_itemnumber,
     items.itype,
     items.homebranch
   FROM
     items
   WHERE
     Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND
     Coalesce(items.permanent_location, "CART") NOT LIKE '%ADULT%' AND
     Coalesce(items.permanent_location, "CART") NOT LIKE '%CHILD%' AND
     Coalesce(items.permanent_location, "CART") NOT LIKE '%YA%'
   GROUP BY
     items.itype,
     items.homebranch) itemsother ON itemsother.itype = branch_itype.itemtype
      AND
      itemsother.homebranch = branch_itype.branchcode
GROUP BY
  branch_itype.branchname,
  branch_itype.description
ORDER BY
  branch_itype.branchname,
  branch_itype.description




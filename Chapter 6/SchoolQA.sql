/* Database: School */
USE school;

/* 1. Find all students who scored better in course '01'
      than in course '02'. */
SELECT sid AS student_id
FROM  scores a
WHERE cid = '01'
AND score > (SELECT score
             FROM scores
             WHERE sid = a.sid
             AND cid = '02');

/* 2. Find all students whose average score is 60 or above. */
SELECT sid AS student_id, AVG(score) AS mean_score
FROM scores
GROUP BY sid
HAVING AVG(score) >= 60;

/* 3. Find all students whose average score is below 60.
Include students who haven't had any score yet. */
SELECT sid AS student_id, AVG(score) AS mean_score
FROM scores
GROUP BY sid
HAVING AVG(score) <= 60
UNION
SELECT sid AS student_id, NULL AS mean_score
FROM students
WHERE sid NOT IN (SELECT sid FROM scores);

/* 4. Show every student's name, total number of courses taken, 
and average score. */
SELECT a.sid, sname, COUNT(cid) AS courses, AVG(score) AS mean_score
FROM students a
LEFT JOIN scores b
ON a.sid = b.sid
GROUP BY a.sid;

/* 5. How many teachers are with last name 'White'? */
SELECT COUNT(tid)
FROM teachers
WHERE tname LIKE '%White';

/* 6. Find the student id and name of all students who 
      took Ms. White's courses. */
SELECT DISTINCT(a.sid) AS student_id, sname AS student_name
FROM scores a
JOIN students b
ON a.sid = b.sid
WHERE cid IN (SELECT cid
              FROM courses c 
              JOIN teachers d
              ON c.tid = d.tid
              WHERE tname = 'Ms. White');

/* 7. Find the student id and name of all students who 
      haven't taken Ms. White's courses. */
SELECT sid AS student_id, sname AS student_name
FROM students
WHERE sid NOT IN (SELECT sid
                  FROM scores a
                  JOIN courses b
                  ON a.cid = b.cid
                  JOIN teachers c 
                  ON b.tid = c.tid
                  WHERE tname = 'Ms. White');

/* 8. Find all students who took both course '01' 
      and course '02'. */
SELECT sid AS student_id
FROM scores
WHERE cid = '01'
AND sid IN (SELECT sid
            FROM scores
            WHERE cid = '02');

/* 9. Find all students who took course '01',  
       but not course '02'. */
SELECT sid AS student_id
FROM scores
WHERE cid = '01'
AND sid NOT IN (SELECT sid
            FROM scores
            WHERE cid = '02');

/* 10. Find all student who haven't taken all listed courses. */
SELECT sid AS student_id, COUNT(cid) AS courses
FROM scores
GROUP BY sid
HAVING COUNT(cid) < (SELECT COUNT(cid)
                     FROM courses)
UNION
SELECT sid AS student_id, 0 AS courses
FROM students
WHERE sid NOT in (SELECT sid 
                  FROM scores);

/* 11. Find all students who took at least an identical course 
       as the student with student id '01'. */
SELECT DISTINCT(sid) AS student_id
FROM scores 
WHERE cid IN (SELECT cid
              FROM scores
              WHERE sid = '01')
      AND sid <> '01';

/* 12. Find all students who took exactly the same courses 
       as the student with student id '01'. */
SELECT a.sid AS student_id
FROM scores a
JOIN scores b
ON a.cid = b.cid
WHERE b.sid = '01'
AND a.sid <> '01'
GROUP BY a.sid
HAVING COUNT(a.cid) = (SELECT COUNT(cid)
                        FROM scores
                        WHERE sid = '01');

/* 13. Find all students who scored below 60 in two 
       or more courses. */
SELECT sid AS student_id, COUNT(cid) AS failed_courses
FROM scores
WHERE score < 60
GROUP BY sid
HAVING COUNT(cid) >= 2;

/* 14. Sort all students who scored below 60 in course 
       '01' in descending order of their scores. */
SELECT sid AS student_id, score AS Course01
FROM scores
WHERE score < 60
AND cid = '01'
ORDER BY score DESC;

/* 15. Show all students' course scores and 
       the average scores. Rotate rows to columns 
       and sort rows in descending order of the 
       average scores. */
SELECT sid AS student_id, 
MAX(CASE cid WHEN '01' THEN score ELSE 0 END) AS C01, 
MAX(CASE cid WHEN '02' THEN score ELSE 0 END) AS C02, 
MAX(CASE cid WHEN '03' THEN score ELSE 0 END) AS C03,
AVG(score) AS mean_score 
FROM scores
GROUP BY sid
ORDER BY mean_score DESC;

/* 16. Find the highest score, lowest score, average score, 
       percentages of A's, B's, C's, 'D's and 'F's of each 
       course with 90 or above rated 'A', 80 to 89 rated 'B', 
       70 to 79 rated 'C', 60 to 69 rated 'D', and below 60
       rated 'F'. */
SELECT cid AS course, MAX(score) AS highest, MIN(score) AS lowest, 
       AVG(score) As mean, 
       AVG(FLOOR(score / 90)) AS A, 
       AVG(FLOOR(score / 80)) - AVG(FLOOR(score / 90)) AS B,
       AVG(FLOOR(score / 70)) - AVG(FLOOR(score / 80)) AS C, 
       AVG(FLOOR(score / 60)) - AVG(FLOOR(score / 70)) AS D, 
       AVG(CASE WHEN score < 60 THEN 1 ELSE 0 END) AS F
FROM scores
GROUP BY cid;

/* 17. Rank the scores in each course.  */
SELECT sid AS student, cid AS course, score, RANK() OVER( 
   	   PARTITION BY cid ORDER BY score DESC) AS ranking
FROM scores;

/* 18. Rank the total score of each student, */
SELECT student, total, RANK() OVER(ORDER BY total DESC)
       As ranking
FROM (SELECT sid AS student, SUM(score) AS total
      FROM scores
      GROUP BY sid) t; 

/* 19. Sort the average score in each teacher's courses in 
       descending order. */
SELECT tid, AVG(score) AS mean_score
FROM courses a
JOIN scores b
ON a.cid = b.cid
GROUP BY tid
ORDER BY 2 DESC;

/* 20. Find the second and third highest scorers in each course. */
WITH t As (SELECT cid, sid,
	    RANK() OVER(PARTITION BY cid ORDER BY score DESC) AS ranking
	    FROM scores)
SELECT cid, sid, ranking
FROM t
WHERE ranking IN (2, 3)
ORDER BY cid, ranking; 

/* 21. Derive the scores' frequency and relative frequency 
       distributions in the following ranges for each course. 
       [0,60), [60, 69), [70, 79), [80, 89), [90, 100]. */
SELECT cid, 
       SUM(CASE WHEN score >= 90 THEN 1 ELSE 0 END) AS A, 
       SUM(CASE WHEN score BETWEEN 80 AND 89 THEN 1 ELSE 0 END) AS B, 
       SUM(CASE WHEN score BETWEEN 70 AND 79 THEN 1 ELSE 0 END) AS C, 
       SUM(CASE WHEN score BETWEEN 60 AND 69 THEN 1 ELSE 0 END) AS D, 
       SUM(CASE WHEN score <60 THEN 1 ELSE 0 END) AS F, 
       AVG(CASE WHEN score >= 90 THEN 1 ELSE 0 END) AS AP, 
       AVG(CASE WHEN score BETWEEN 80 AND 89 THEN 1 ELSE 0 END) AS BP, 
       AVG(CASE WHEN score BETWEEN 70 AND 79 THEN 1 ELSE 0 END) AS CP, 
       AVG(CASE WHEN score BETWEEN 60 AND 69 THEN 1 ELSE 0 END) AS DP, 
       AVG(CASE WHEN score <60 THEN 1 ELSE 0 END) AS FP
FROM scores
GROUP BY cid;    

/* 22. Rank the students' average scores. */
SELECT student, mean_score, RANK() OVER(ORDER BY mean_score DESC)
       As ranking
FROM (SELECT sid AS student, AVG(score) AS mean_score
      FROM scores
      GROUP BY sid) t; 

/* 23. Find the top three scorers in each course. */
WITH t As (SELECT sid, cid, score, 
	       RANK() OVER(PARTITION BY cid ORDER BY score DESC) 
	       AS ranking
	       FROM scores) 
SELECT cid AS course, sid AS student, score, 
       ranking
FROM t 
WHERE ranking <= 3;

/* 24. Find the number of students that took each course. */
SELECT cid AS course, count(sid) AS enrollment
FROM scores
GROUP BY cid;

/* 25. Find the students who took only two courses. */
SELECT sid As student
FROM scores
GROUP BY sid
HAVING COUNT(cid) = 2;

/* 26. Find the number of male and female students, 
       respectively. */
SELECT sgender, COUNT(sid)
FROM students 
GROUP BY sgender;

/* 27. Find any student with 'is' in name. */
SELECT sid, sname
FROM students
WHERE sname LIKE '%is%';

/* 28. Find the students with the same first name. */
SELECT a.sname AS student1, b.sname AS student2
FROM students a
JOIN students b
WHERE LEFT(a.sname, INSTR(a.sname, ' ')) 
  = LEFT(b.sname, INSTR(b.sname, ' '))
AND a.sid < b.sid;
 
/* 29. Find all students born in 1998. */
SELECT sid, sname, sdob
FROM students
WHERE YEAR(sdob) = 1998;

/* 30. Sort courses in descending order of average 
       score and asending order of course id. */
SELECT a.cid AS course_id, a.cname AS course_name,
       AVG(score) as mean
FROM courses a 
JOIN scores b
ON a.cid = b.cid
GROUP BY b.cid 
ORDER BY mean DESC, course_id ASC;

/* 31. Find all students with an average score higher than 85.*/
SELECT a.sid AS student_id, a.sname AS student_name, 
       AVG(score) AS mean_score
FROM students a
JOIN scores b
ON a.sid = b.sid
GROUP BY b.sid
HAVING mean_score > 85;

/* 32. Find all students with a grade below 60 in Algebra. */
SELECT a.sid AS student_id, a.sname AS student_name, 
       b.score AS grade
FROM students a
JOIN scores b
ON a.sid = b.sid
JOIN courses c
ON b.cid = c.cid
WHERE cname = 'Algebra'
AND score < 60;

/* 33. Rotate rows of the Scores table to columns. */
SELECT sid, 
       MAX(CASE cid WHEN '01' THEN score ELSE 0 END)
       AS Course01,
       MAX(CASE cid WHEN '02' THEN score ELSE 0 END)
       AS Course02,
       MAX(CASE cid WHEN '03' THEN score ELSE 0 END)
       AS Course03
FROM scores
GROUP BY sid;

/* 34. Show the student id and scores of all students
       who scored at least 70 in one of the 
       courses. */ 
 SELECT sid, 
       MAX(CASE cid WHEN '01' THEN score ELSE 0 END)
       AS Course01,
       MAX(CASE cid WHEN '02' THEN score ELSE 0 END)
       AS Course02,
       MAX(CASE cid WHEN '03' THEN score ELSE 0 END)
       AS Course03
FROM scores
GROUP BY sid
HAVING MAX(score) >= 70;

/* 35. Find all courses where at least one student scored 
       below 60. */
SELECT cid AS course
FROM scores
GROUP BY cid
HAVING MIN(score) < 60;

/* 36. Find all students who scored 80 or above in 
       course '01'. */
SELECT sid AS student, score
FROM scores
WHERE cid = '01' 
AND score >= 80;

/* 37. Find the student who got the highest score in 
       Ms. Thompson's courses. If there are ties, then 
       output all highest scorers. */
WITH t AS (SELECT cid, sid, 
	              RANK() OVER(PARTITION BY cid
	              ORDER BY score DESC) AS ranking, 
	              score
	       FROM scores
	       WHERE cid = (SELECT cid 
	       	            FROM courses a
	       	            JOIN teachers b
	       	            ON a.tid = b.tid
	       	            WHERE tname = 'Ms. Thompson'))
SELECT cid AS course_id,
       sid AS student_id,
       score
FROM t
WHERE ranking = 1;

/* 38. Find pair of students who scored the same in 
       different courses. */
SELECT a.sid AS student1, a.cid AS course1, 
       b.sid AS student2, b.cid AS course2, a.score AS score
FROM scores a 
JOIN scores b
WHERE a.cid < b.cid 
AND a.sid < b.sid
AND a.score = b.score; 

/* 39. Find the top two scorers in each course. */
WITH t AS (SELECT cid, sid, score, 
	       ROW_NUMBER() OVER(PARTITION BY cid 
           ORDER BY score DESC) AS ranking
           FROM scores)
SELECT cid, 
       MAX(case ranking WHEN 1 THEN sid END) as student1,
       MAX(case ranking WHEN 1 THEN score END) as score1,
       MAX(case ranking WHEN 2 THEN sid END) as student2,
       MAX(case ranking WHEN 2 THEN score END) as score2
FROM t
GROUP BY cid;

/* 40. Find the courses that were taken by five or more students */
SELECT cid AS course, COUNT(sid) AS enrollment
FROM scores
GROUP BY cid
HAVING enrollment >= 5;

/* 41. Find all students who have taken at least two courses. */
SELECT sid AS student, COUNT(cid) AS courses
FROM scores 
GROUP BY sid
HAVING courses >= 2;

/* 42. Find every student's age. */
SELECT sname AS student, 
YEAR(CURDATE()) - YEAR(sdob) - (date_format(CURDATE(), '%m%d')
< date_format(sdob, '%m%d')) AS age
FROM students;

/* 43. Find all students whose birthday is in this week.*/
SELECT sname AS student, sdob AS dob
FROM students
WHERE YEARWEEK(str_to_date(CONCAT(YEAR(CURDATE()), 
	',', MONTH(sdob), ',', DAY(sdob)), '%Y, %m, %d'))
      = YEARWEEK(CURDATE());

/* 44. Find all students whose birthdays are within the next 3 weeks. */
SELECT sname AS student, sdob AS dob
FROM students
WHERE str_to_date(CONCAT(YEAR(CURDATE()), 
	',', MONTH(sdob), ',', DAY(sdob)), '%Y, %m, %d')
BETWEEN CURDATE()
AND DATE_ADD(CURDATE(), INTERVAL 3 week);

/* 45. Find all students whose birthdays are in 
       December. */
SELECT sname AS student, sdob AS dob
FROM students
WHERE MONTH(sdob) = 12;

/* 46. Find all students whose birthdays are in the next month.*/
SELECT sname AS student, sdob AS dob
FROM students
WHERE MONTH(sdob) = MONTH(DATE_ADD(CURDATE(), INTERVAL 1 month));

/* 47. Find all students who scored below 60 in every course. */
SELECT a.sid AS id, sname AS name, COUNT(cid) AS numcourses
FROM students a
JOIN scores b
ON a.sid = b.sid
GROUP BY a.sid
HAVING MAX(score) < 60;

/* 48. Find the name of every student who scored the higest in 
       each course. If there are ties, then output all highest 
       scorers. */
SELECT cid AS course, sname AS student, score
FROM scores a
JOIN students b
ON a.sid = b.sid
WHERE score >= (SELECT MAX(score)
                FROM scores
                WHERE a.cid = cid
                GROUP BY cid);

/* 49. Find the names of all top three scorers in each course. 
       Consider ties. */
SELECT cid AS course, sname AS student, score
FROM scores a
JOIN students b
ON a.sid = b.sid
WHERE score IN (SELECT score FROM (SELECT score
                FROM scores
                WHERE a.cid = cid
                ORDER BY score DESC
                LIMIT 3) s);     

/* 50. Find the names of all students who got the 
       third highest score in each course. */
SELECT cid AS course, sname AS student, score
FROM scores a
JOIN students b
ON a.sid = b.sid
WHERE score = (SELECT score 
               FROM scores
               WHERE cid = a.cid
               ORDER BY score DESC
               LIMIT 2, 1);
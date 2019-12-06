### Assignment 13 (due December 14)
1. Read the [W3C SQL Tutorial](https://www.w3schools.com/sql/default.asp).
2. Download and review the [sample query commands](https://github.com/postmda/MDA610/tree/master/Chapter%206/world_db_revised.sql) developed in class.
3. Read a tutorial on [SQL joins](http://www.sql-join.com/). 
4. Read the following articles on SQL Subquery:
   - [Introduction](https://www.essentialsql.com/introduction-to-subqueries/)
   - [Using Subqueries in the Select Statement](https://www.essentialsql.com/get-ready-to-learn-sql-server-20-using-subqueries-in-the-select-statement/)
   - [Subqueries versus joins](https://www.essentialsql.com/what-is-the-difference-between-a-join-and-subquery/#:~:targetText=Joins%20and%20subqueries%20are%20both%20used%20to%20combine%20data%20from,are%20used%20to%20return%20rows.)
5. Take Post-class Quiz 10 on Blackboard. Refer to the [schema of the `Employees` database](https://dev.mysql.com/doc/employee/en/sakila-structure.html).
6. Retrieve data from the MySQL sample database `sakila` to answer the questions below. For each question, store the SQL query command you used and the output in a text file (that can be edited in Sublime Text 3). Refer to the [table structure](https://dev.mysql.com/doc/sakila/en/sakila-structure-tables.html) when you answer the questions. 
   1. What are the names of all the languages in the database? Sort the languages alphabetically. 
   2. Return the full names (first and last) of all actors with "BER" in their last name. Sort the returned names by their first name. (Hint: use the CONCAT() function to add two or more strings together.)
   3. How many last names are not repeated in the actor table?
   4. How many films involve a "Crocodile" and a "Shark"?
   5. Return the full names of the actors who played in a film involving a "Crocodile" and a "Shark", along with the release year of the movie, sorted by the actors' last names.
   6. Find all the film categories in which there are between 40 and 60 films. Return the names of these categories and the number of films in each category, sorted in descending order of the number of films. 
   7. Return the full names of all the actors whose first name is the same as the first name of the actor with ID 24. 
   8. Return the full name of the actor who has appeared in the most films. 
   9. Return the film categories with an average movie length longer than the average length of all movies in the sakila database. 
   10. Return the total sales of each store. 
7. Upload the text file you created above to your GitHub repository. Email the instructor the link to the repository and the filename. 
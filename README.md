This is a Laravel API "To Do List" application that uses "Sanctuary" for authentication and Policies for user authorization.

First of all, let me apologize for the "dirty code", it's my first experience with Laravel API.

Documentation for the application can be found in the "1-documentation" directory:
	dumpDB - MySQL dump database with test data;
	developmentLog.txt - description of creating an application step by step;
	Тестове завдання.pdf - original test task;
	Тестове завдання.txt - test task with marks for each item: + completed, - failed,
	examplesRequests.txt - examples of the API requests and response.

How to use this application:
To work with API requests, I used the Postman program, so further examples will be described using this program. The examples will also use a test database.

The application can be divided into two parts: Users and Tasks.
The request and response examples were too large, so I put them in a separate file examplesRequests.txt, there is an example for each functionality.

--Users:

-Show user data;
-Create new user;
-Create a new user token (if you forgot the old one);

--Tasks:

-Get all user tasks;
-Get user task with all subtasks (you can get subtask that way too);
-Get all user tasks with a sort (to sort, you need to pass the “field name” by which we will sort and the “sort type”);
-Store new user task with subtasks;
-Update user task with subtasks;
-Change task status (cannot be completed if the subtask is not completed);
-Delete a task (all subtasks will be deleted too).
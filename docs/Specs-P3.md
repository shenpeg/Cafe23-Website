Specifications for Phase 3 Models
===

As part of phase 3, you will have to create models for the remaining entities and write unit tests for these models.  To make sure you are able to build these models and tests, below are some specs for each of these models.

**Please read this file online at GitHub or using a Markdown preview browser** (built into VS Code or stand-alone app like [MacDown](https://macdown.uranusjr.com/)) so there are no mistakes with escape characters (i.e., backslashes)

---
_Shifts must:_

1.	have all proper relationships specified
2. have all foreign key fields present
3. have a legitimate start time and an end time that follows the start time
2.	have a status limited to one of the following options: { pending: 1, started: 2, finished: 3 }
3. be added to only current assignments, not past assignments, with a shift date on or after the start date of the current assignment
3. _new_ shifts should have a callback with automatically sets the end time to three hours after the start time
3. can only be deleted if the shift is pending; otherwise an error is thrown (assign to `:base`)
4.	have the following scopes:
	- 'pending' -- returns shifts that are pending
	- 'started' -- returns shifts that are started
	- 'finished' -- returns all shifts that are finished
	- 'chronological' -- orders results by date and then start time
	- 'by\_store' -- orders results alphabetically by store name
	- 'by\_employee' -- orders results alphabetically by employee last, first names
	- 'past' -- returns shifts in the past (before today's date)
	- 'upcoming' -- returns shifts on today's date or in the future
	- 'for\_next\_days' -- which returns all the upcoming shifts in the next 'x' days (parameter: x)
	- 'for\_past\_days' -- which returns all the past shifts in the previous 'x' days (parameter: x)
	- 'for\_employee' -- which returns all shifts that are associated with a given employee (parameter: employee object)
	- 'for\_store' -- which returns all shifts that are associated with a given store (parameter: store object)
	- 'completed' -- which returns all shifts in the system that have at least one job associated with them
	- 'incomplete' -- which returns all shifts in the system that have do not have at least one job associated with them
5.	have the following methods:
	-	'duration' -- which uses teh date\_time\_helpers gem to calculate the duration of a shift, following the rules laid out in the Cafe23 case narrative.
	-	'report\_complete?' -- which simply confirms that at least one job has been recorded for the given shift (i.e., there's a record that the employee did something during this time) 


---
_Jobs must:_

1.	have all proper relationships specified
2.	have a name
3. can only be destroyed if they have never been worked by an employee on a prior shift. (That is, if no one has actually done the job yet, it can be destroyed, otherwise not.)
4.	have the following scopes:
	- 'active' -- returns only active jobs
	- 'inactive' -- returns all inactive jobs
	- 'alphabetical' -- orders results alphabetically by name
5.	have the following methods:
	- 'make\_active' -- which flips an active boolean from inactive to active and updates the record in the database
	- 'make\_inactive' -- which flips an active boolean from active to inactive and updates the record in the database


---
_ShiftJobs must:_

1. have all proper relationships specified
2. have all foreign key fields present
3. have a job\_id and it must be restricted to jobs that exist and are active in the system
4. have a shift\_id and it must be restricted to shifts that exist in the system
5. be only for shifts that are finished (jobs worked during a shift are recorded _after_ the shift is over)
6.	have the following scopes:
	- 'alphabetical' -- orders results alphabetically by job name



---
_PayGrades must:_

1.	have all proper relationships specified
2.	have a level and that level must be unique in the system (case insensitive)
3. cannot be destroyed for any reason
4.	have the following scopes:
	- 'active' -- returns only active pay grades
	- 'inactive' -- returns all inactive pay grades
	- 'alphabetical' -- orders results alphabetically by level
5.	have the following methods:
	- 'make\_active' -- which flips an active boolean from inactive to active and updates the record in the database
	- 'make\_inactive' -- which flips an active boolean from active to inactive and updates the record in the database
	- 'current_rate' -- which returns the pay grade rate object currently associated with the pay grade, and nil if there is no such connection pay grade rate

---
_PayGradeRates must:_

1.	have all proper relationships specified
2.	have values which are the proper data type and within proper ranges. Remembering the 2nd Rule of Software Development, that means:
	- a numeric value for rate that is greater than zero
	- restrict pay\_grade\_ids to items which exist and are active in the system
3. have the following scopes:
	- 'current' -- which returns all the pay grade rates that are considered current
	- 'chronological' -- orders results chronologically by start date
	- 'for\_pay\_grade' -- which returns all pay grade rates that are associated with a given pay grade (parameter: pay grade object)
	- 'for\_date' -- which returns all pay grade rates that are associated with a given date (parameter: date)


---
_Employees, in addition to previous requirements, must:_

1.	make all appropriate updates to match the resived data model
2. have new connections to shifts, pay grades, and pay grade rates
3. have the following for password management:
	- virtual attributes for `password` and `password_confirmation`
	- on creation, those two fields are mandatory (i.e., required)
	- those fields must match each other when a new employee is being created 
	- a password must have a minimum length of four characters
4. have usernames that are required and must be unique (case-insensitive) in the system
5. have an instance method called `authenticate` which will compare the password provided with the `password_digest` stored in the database and return an employee object if they match, or `false` if they do not
6. have a class method called `authenticate` which takes both a `username` and `password` parameter and compare the password provided with the `password_digest` stored in the database and return an employee object if they match, or `false` if they do not
7.	allow employees to be deleted if they have never worked a shift. If they can be deleted, then the system should also remove any pending shifts and terminate the current assignment
8.	have the following methods related to payments:
	- 'current\_pay\_grade' -- return string representing the level of the employee's current pay grade
	- 'current\_pay\_rate' -- returns the numerical rate value of the employee's current pay grade rate, or nil if the employee does not yet have a current assignment
	- 'pay\_grade\_on' -- return string representing the level of the employee's pay grade on a given date (parameter: date)
	- 'pay\_rate\_on' -- returns the numerical rate value of the employee's pay grade rate on a given date, or nil if the employee does not have an assignment for that date (parameter: date)


---
_Assignments, in addition to previous requirements, must:_

1. make all appropriate updates to match the resived data model
2. have new connections to shifts, pay grades
3. require all foreign keys
4. have a scope called `for_pay_grade` which all the assignments for a given pay grade (paramter: pay grade object)
5. have a pay\_grade\_id and it must be restricted to pay grades which exist and are active in the system
6. have a `terminate` method which sets the end date of the current assignment to `Date.current` and remove any pending shifts associated with the assignment


---
_Stores, in addition to previous requirements, must:_

1. make all appropriate updates to match the resived data model
2. have new connections to shifts
3. not be associated with Monty Python in any way
4. cannot be destroyed for any reason
5. if for any reason stores are associated with Monty Python, you can [expect the unexpected](https://www.youtube.com/watch?v=Cj8n4MfhjUc). 




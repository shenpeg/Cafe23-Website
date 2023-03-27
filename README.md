67-272: Cafe23 Project - Phase 4
===
We will continue our project to develop a foundation for the Cafe23 management system in this phase. We will focus our efforts on building out the controllers and views to make for an effective front end for our e-commerce platform. This is largely a test-driven phase -- we give you all the controller tests and some view tests and your job is to pass these tests.  In this process, you will see how our testing suite can serve as documentation and help us define system requirements.

**Grading**

This phase will constitute 15 percent of your final course grade and is broken down into the following three components:


1. **Creation of Controllers**: We have given you all the controller tests that your controllers must pass. Of course, these controllers must also be able to generate the code needed to pass the Cucumber tests, so reading the two sets of tests together is advisable. All tests must pass and the coverage is to be at 100 percent; if you add additional methods that we do not test, expect a substantial penalty.  The project must be **using Rails 7.0.4 and Ruby 3.1.2 and the gems specified in the Gemfile.**. In total, the creation of controllers and passing those tests compromise 45 points.

2. **Creation of Views**: We are going to have you complete key elements of the system front end by building views for employees, managers, and administrators.  We have given you a series of Cucumber tests that test the full stack (model-view-controller) that mostly apply to authentication and basic read views; these will help you learn a bit about this form of testing and help you build out some simple read-only views. In total, passing the Cucumber tests counts for 10 points of the phase grade.

    Note that in the interest of time, we are not requiring views for every single model and controller.  Instead, we have crafted a set of key scenarios that hit at the core of the system and are focusing on that. For example, a key feature of the system would be the ability of managers to create shifts for employees at their store.  Another key feature would be for employees to log into the system and be able to start/stop recording their shift using an online time clock.  The full list of these scenarios appears in the `docs/` directory.  While these scenarios are not equally weighted, passing all scenarios while adhering to design principles will compromise 40 points on this phase.

3. **Visual Design**: To prevent attempts to hack the test suites, we will be manually checking each application to make sure that the key elements are not hard-coded into the response.  While doing that, we will also assess the quality of your visual design on a 5-point scale.  While we use [MaterializeCSS](https://materializecss.com/) in class and in PATS, you do have the freedom to choose other CSS frameworks if you prefer. (That said, we are providing no support in OH or Piazza for other frameworks we may be unfamiliar with.) 


**Checkpoints**

There are two checkpoints for this phase.

1. On **April 2rd**, the controllers for `employees`, `stores`, `assignments`, and `sessions`, must be complete and passing all tests at 100 percent coverage.  In addition, the controller tests for handling 404 errors must also pass.  

2. On **April 10th**, in addition to the previous checkpoint working, all remaining controllers must be complete and passing at 100 percent coverage. Additionally, the Cucumber tests (features 0-4) must pass.


All checkpoints are due in your GitHub repository before 11:59pm EST on the date specified.  We are not explicitly checking for test coverage on checkpoints, only that the specified tests exist and they pass.  Checkpoints will be submitted via GitHub and Gradescope (additional instructions to follow).

**Other Notes**

1. There are no spec files given with regards to controller code this phase -- part of the purpose of this phase is to get you familiar with testing as a form of documentation.  **Because of this, if you ask a general question about requirements on Piazza or in office hours, our first response will be to ask you what the tests tell you.**  If you have specific questions about the tests and how they work, we are happy to answer those, _but we will not interpret the tests for you -- it's your job to turn those tests into requirements._

1. We have given you a reasonable testing context that can be easily set up with the command: `rails db:contexts`. Note that the autograder will have a tweaked version of the context with slightly different names, prices, and the like, to try to discourage students from hard-coding the responses.

1. Note that the models we've given you are feature complete and no additional methods are needed to complete this phase. That said, we have also given you a few extra methods that were not part of the previous, so reviewing the models would be helpful.  If you do feel compelled to add new methods to your models, you are responsible for writing tests for those methods so the coverage remains at 100 percent.

1. As you know from the previous phase, we use a series of helpers that allow us to not have to copy-paste certain methods and keep our code cleaner.  To reduce issues of object management, we have moved key functionality for payroll calculation and time clock operations into service objects found in `apps/services`.  In particular, the `TimeClock` service you have been given is a bit more full-featured than the one required in phase 3; definitely worth reviewing it before using it.

1. We strongly advise you _NOT_ to use `rails generate scaffold ...` but rather `rails generate controller ...` in creating your controller for this phase. (Or even better, just use `touch <filename>` on the command line to generate blank files to work with.) Also, be sure not to overwrite the controller tests if you do use the generators.  Be forewarned: scaffolding will generate lots of extra code that may inadvertently impact your test coverage and cause you to lose points. We will have no sympathy if you ignore this warning and lose points.

1. Because `PayrollsController` is not directly associated with a particular model, the `authorize resource` command will not work and each of the actions will have to be authorized separately (e.g., `authorize! :employee_form, :payrolls_controller`). The proper abilities are in the `Ability` model already for you.  In addition, you will not be able to use simple_form's `simple_form_for(object)` command in creating forms; the payroll controller handles read operations, so like our search forms, our approach will require `form_with url:` and using `GET` as our HTTP verb.  Finally, the parameters (both keys _and_ values) from this type of form come in as strings rather than symbols and in the case of date values, will need to be converted from strings to dates.

1. We do expect authorization to be put in place at both the controller and view levels, as appropriate.  There will be penalties if authorization is not handled properly at the controller or view levels.

1. Doing the checkpoints will keep you from getting too far behind, **but _only_ doing the minimum each week will pretty much ensure a miserable final week.** Our advice, as it has been throughout the semester, is to follow the path but work ahead of the minimum requirements.

**Turning in Phase 4**

Your project should be turned in via your private repository on GitHub **before 11:59 pm (EST) on Sunday, April 16th, 2023**. Once it's in your repo, you will then submit it from there to Gradescope. More instructions on submitting to the autograder will be posted separately. The solution for this phase (i.e., starter code for the next phase) will be released soon after; no late assignments will be accepted after solutions are released.

Again, if you have questions regarding the turn-in of this project or problems downloading any of the materials below, please post them on Piazza or ask someone well in advance of the turn-in date. Waiting until the day before it is due to get help is unwise -- you risk not getting a timely response that close to the deadline and will not be given an extension because of such an error.
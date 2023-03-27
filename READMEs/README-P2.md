67-272: Cafe23 Project - Phase 2
===
We will continue our project to develop a foundation for the Cafe23 management system in this phase. We will focus our efforts on building out the models for the three entities given to you in the this phase's ERD (docs\cafe23_erd_p2.pdf) and adding all necessary business logic. In addition, you will have to write unit tests for all models and ensure that test coverage is complete. 

**Grading**

This phase will constitute 7 percent of your final course grade and is broken down into the following three components:


1. **Creation of Models**: Models for the entities listed in the ERD found in this project's `docs` directory need to be created. Also, in the `docs` directory, you are given a spec sheet on essential methods each model must have; those methods must be fully implemented. The project must be **using Rails 7.0.4 and Ruby 3.1.2**

2. **Unit Testing**: Unit tests for all methods in all models must be written and fully passing. We will check to ensure there is 100 percent code coverage for unit tests using the `simplecov` gem used in class and lab. Because `simplecov` suffers from some false positives (as mentioned in class), we may spot-check tests to ensure specific tests were included. Only the models in this phase need complete coverage. There are steep penalties for less than 100 percent coverage and no credit at all for less than 90 percent coverage. 

3. **Coding Style**: All code must be appropriately organized. What that means at this stage is the following: 
  - Related or similar functionality is grouped or clustered together.
  - Indentation should be used consistently to make code readable.
  - Comments showing organization should be present and explaining difficult code should be used when/if necessary.

**Checkpoints**

1. On **February 5th**, the three models must be generated using the Rails generators, the initial database created, and all the relationships between the three models must be set up and tested.

2. On **February 12th**, in addition to the previous checkpoint working, the scopes for the `Employee` and `Store` models must be completed and tested.

3. On **February 19th**, in addition to the prior checkpoints working, the scopes for `Assignment` model must be complete and tested. All methods for the `Store` model must be completed and tested.

All checkpoints are due in your GitHub repository before 11:59pm EST on the date specified.  We are not explicitly checking for test coverage on checkpoints, only that the specified tests exist and they pass.  Checkpoints will be submitted via GitHub and Gradescope (additional instructions to follow).

**Other Notes**

1. We strongly advise you _NOT_ to use `rails generate scaffold ...` but rather `rails generate model ...` in creating your models for this phase. Scaffolding will generate lots of extra code that may inadvertently impact your test coverage and cause you to lose points. We will have no sympathy if you ignore this warning and lose points.

2. If we have installed a gem in the `Gemfile`, then use the version we've specified. However, be aware that there are gems that we've demo'ed in class that you will have to install yourself for this phase.

3. Doing the checkpoints will keep you from getting too far behind, but _only_ doing the minimum each week will pretty much ensure a miserable final week. The path of coding and testing relationships first, then scopes, then other methods is highly recommended, and the checkpoints lead you in that path. But the other methods become tricky, and waiting until the last week to do them all can lead to lots of stress in that last week. Our advice is to follow the path but work ahead of the minimum requirements.

**Turning in Phase 2**

Your project should be turned in via your private repository on GitHub **before 11:59 pm (EST) on Sunday, February 26th, 2023**. Once it's in your repo, you will then submit it from there to Gradescope. More instructions on submitting to the autograder will be posted separately. The solution for this phase (i.e., starter code for the next phase) will be released soon after; no late assignments will be accepted after solutions are released.

Again, if you have questions regarding the turn-in of this project or problems downloading any of the materials below, please post them on Piazza or ask someone well in advance of the turn-in date. Waiting until the day before it is due to get help is unwise -- you risk not getting a timely response that close to the deadline and will not be given an extension because of such an error.
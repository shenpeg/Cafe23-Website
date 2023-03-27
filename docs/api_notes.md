Cafe23 API Notes
---
In the `docs/api_json_samples` directory, you will find sample JSON generated for the API endpoints for your application.  The only endpoints we are requiring for this phase are:

- http://localhost:3000/v1/employees
- http://localhost:3000/v1/shifts/1.json
- http://localhost:3000/v1/stores/{id}/upcoming

All are read-only routes passed as a GET request.

General notes in building this API:
---

1. We have already given you the appropriate `ApiController` needed to build your controllers for these endpoints.  In addition, we've given you a separate folder to store these api controllers in (`app/controllers/api/v1`)
2. We have already installed the `fast_jsonapi` gem in your `Gemfile` -- you simply need to run `bundle install` to get it.
3. We want you to build each route manually as demo'd in class.  Do NOT use the `resources` method to build other CRUD routes that you have no intention of implementing at this time.
4. We are NOT requiring authorization on these endpoints; do not add it in anyways as it will negatively impact the autograder, and consequently, your grade.
5. In this phase we are not requiring any testing of the controllers as we haven't covered controller testing yet.
6. Documentation for the API is optional and will not be tested or graded.
7. In the final test of the endpoints, we will modify the test data slightly to detect anyone who is hard-coding any parts of the endpoint responses. We will also fix dates (rather than use relative dates in the context) to ensure the final json dates match up.
8. We've set up a place in `config/routes.rb` to put your custom routes and a folder inside `app/controllers` for your controller files to go.  

Notes on samples
---
Samples from each of these endpoints is provided to you in the `samples` directory.  These outputs were generated with the context data running the script referenced above.  At the top of each sample is the cURL command used to generate the json output (with a pretty print command).  You can get these same results if you put the URL into a browser with the JSON Formatter extension for Chrome/Brave.  There may be other samples that we were considering; feel free to ignore them for now.

Note that our testing data will differ slightly from the data you populated the database with in the `db:contexts` script and we may use different ID numbers in the endpoint call.  This will ensure that you don't simply return the sample text in the method, but that you actually generated it properly using serializers and controllers.

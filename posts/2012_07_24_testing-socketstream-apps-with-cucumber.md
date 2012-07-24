*24th July, 2012*
Testing SocketStream apps with Cucumber
===

I have a terrible confession to make. [Dashku](https://dashku.com) has no tests whatsoever!

If you're prototyping something, you regard tests as an overkill... but if your prototype gets legs, then that's a different story. For that reason, I've been looking into the question of how one goes about testing a single-page Node.js application powered by [SocketStream](http://socketstream.com).

Cucumber
---

When it comes to testing an application, [Cucumber](http://cukes.info/) is one of the best tools I have ever used. Used right, Cucumber will:

- Turn the description of how someone wants to use the application into testing instructions
- Use those instructions with software to automate the testing of the application
- Provide the developer with a path to making the feature work ([outside-in BDD](http://www.sarahmei.com/blog/2010/05/29/outside-in-bdd/))
- Give new developers/stakeholders a kind of documentation on what the application does
- Give developers material that they can use to create the 'demo script' for the demo to clients

and importantly...

- Provide a safety net for capturing regression errors, refactoring the code, or changing the architecture of your application.

This is very important for startups who will have to change their architecture as their site grows. Anyway, let me show you how I'm using Cucumber to test a SocketStream app.

Testing your app - where to begin?
---

The first step is to install some npm packages:

- cucumber
- soda
- selenium-launcher

Add these to your application's package.json file, and run the following command:

    npm install

You'll now want to create some directories

    mkdir features
    mkdir features/step_definitions
    mkdir features/support

For those not familiar with the directories, a quick description below:

- the features folder contains all of your feature files (the testing instructions)
- the step definitions folder contains all the step definition files (code that is executed when a matching instruction is called)
- the support folder contains files for making cucumber work with the application it is testing

Feature files
---

A feature file is a set of instructions describing how a feature works. It is human-readable, and ought to be written by the stakeholder, in their non-technical, business-specific language. It begins with a few lines defining what the feature does, what's it's goal is, and who the stakeholder (i.e. the user) is.

Let's create a feature file. A common feature of most web applications is being able to sign up, so for this example, I'm going to be using one that exists on another SocketStream application (named Shogun).

    touch features/signup.feature

Here is what the signup.feature file looks like for Shogun:

    Feature: Signup
      In order to use Shogun
      As a User
      I want to sign up

      Scenario: Sign up
        Given I am on the homepage
        And I should see the home page
        When I fill in "username" with "paulbjensen"
        And I fill in "email" with "paulbjensen@gmail.com"
        And I fill in "password" with "123456"
        And I press "Signup"
        And I should see the projects page
        Then I should see "paulbjensen"
        And I should see "Your project"

You can read that file and get a clear idea about what is going on. If we now run cucumber:

    cucumber.js

we'll see this:

    UUUUUUUUU

    1 scenario (1 undefined)
    9 steps (9 undefined)

    You can implement step definitions for undefined steps with these snippets:

    this.Given(/^I am on the homepage$/, function(callback) {
      // express the regexp above with the code you wish you had
      callback.pending();
    });

    this.Given(/^I should see the home page$/, function(callback) {
      // express the regexp above with the code you wish you had
      callback.pending();
    });

    this.When(/^I fill in "([^"]*)" with "([^"]*)"$/, function(arg1, arg2, callback) {
      // express the regexp above with the code you wish you had
      callback.pending();
    });

    this.When(/^I press "([^"]*)"$/, function(arg1, callback) {
      // express the regexp above with the code you wish you had
      callback.pending();
    });

    this.When(/^I should see the projects page$/, function(callback) {
      // express the regexp above with the code you wish you had
      callback.pending();
    });

    this.Then(/^I should see "([^"]*)"$/, function(arg1, callback) {
      // express the regexp above with the code you wish you had
      callback.pending();
    });

Step Definitions
---


Cucumber recognises that we haven't got any step definition code for the steps in the feature file, and kindly provides us with code that we can put into a step definition file, so let's do that:

    touch features/step_definitions/signup_steps.coffee

I've taken the JavaScript example, and converted it to CoffeeScript (sorry Matthew). Here is what it looks like:

    module.exports = ->

      @Given /^I am on the homepage$/, (callback) ->
        callback.pending()

      @Given /^I follow "([^"]*)"$/, (link, callback) ->
        callback.pending()

      @When /^I fill in "([^"]*)" with "([^"]*)"$/, (field, value, callback) ->
        callback.pending()

      @When /^I press "([^"]*)"$/, (name, callback) ->
        callback.pending()

      @Then /^I should see "([^"]*)"$/, (content, callback) ->
        callback.pending()

      @Then /^I should see the projects page$/, (callback) ->
        callback.pending()

      @Then /^I should see the home page$/, (callback) ->
        callback.pending()

These steps are used to capture any line that matches the regex, and execute some code, so to illustrate the first line:

    Given I am on the homepage

matches to:

    @Given /^I am on the homepage$/, (callback) ->

You'll notice that some of the regexes are a little more sophisticated than the example above. They allow for a step to have arbitrary input, so a step definition can match multiple steps throughout the feature files.

If we run the 'cucumber.js' command again, we'll see this:

    P--------

    1 scenario (1 pending)
    9 steps (1 pending, 8 skipped)  

The next thing to do is to make the step definitions run against our SocketStream application. 

World.coffee
---

This is where we create a support file called 'world.coffee':

    touch features/support/world.coffee

You can think of the world.coffee file as the piping between cucumber and the application it is testing. When testing a SocketStream application, you need the world.coffee file to do the following:

- Boot the SocketStream application
- Boot a Selenium server
- Launch a Selenium client for the step definitions to use

At the start, your world.coffee file should look something like this:

    World = (callback) ->
      callback()

    exports.World = World

Loading the SocketStream app externally
---

We now want to load our SocketStream application when running our cucumber tests. At this point, you'll want to think about running the SocketStream in an environment other than the default 'dev' environment, so that you can run the application on a separate port, as well as avoid overwriting any development databases.

The way I've approached this is to have a separate SocketStream environment, called 'cucumber'. I've also taken the step of having my configuration options kept in a file separate to SocketStream's app.js file (or app.coffee in my case), in a file at server/config.coffee. The config file for Shogun looks like this:

    module.exports =
      
      development:
        port: 3000
        db: 'localhost/shogun_development'

      test:
        port: 3001
        db: 'localhost/shogun_test'

      cucumber:
        port: 3002
        db: 'localhost/shogun_cucumber'

My SocketStream app's app.coffee file looks like this:

    http            = require 'http'
    global.ss       = require 'socketstream'
    global.config   = require './server/config.coffee'
    db              = require './server/db.coffee'

    # Controllers, a way of sharing common logic between RPC and REST APIs
    global.userController     = require "#{__dirname}/server/controllers/user.coffee"
    global.projectController  = require "#{__dirname}/server/controllers/project.coffee"

    # Define a single-page client
    ss.client.define 'main',
      view: 'app.jade'
      css:  ['libs', 'app.styl']
      code: ['libs', 'app']
      tmpl: '*'

    # Serve this client on the root URL
    ss.http.route '/', (req, res) ->
      res.serveClient 'main'

    # Code Formatters
    ss.client.formatters.add require library for library in ['ss-coffee', 'ss-jade', 'ss-stylus']

    # Use server-side compiled Hogan (Mustache) templates. Others engines available
    ss.client.templateEngine.use require 'ss-hogan'

    # Minimize and pack assets if you type: SS_ENV=production node app.js
    ss.client.packAssets() if ss.env is 'production'

    # Start web server
    server = http.Server ss.http.middleware
    server.listen config[ss.env].port

    # Start SocketStream
    ss.start server

The points of interest to note are the use of config as a global variable, and the way that the server.listen function is passed a port number based on calling the config's 'dev', 'test', or 'cucmber' value, depending on what the value of ss.env is.

If we require 'app.coffee' in another file, then the SocketStream application will load. However, we also want it to load with ss.env set to 'cucumber'. We can do that in the world.coffee like this:

    World = (callback) ->
      process.env["SS_ENV"] = "cucumber"
      app                   = require '../../app.coffee'
      callback()

    exports.World = World

Loading the Selenium Launcher and Client
---

Next, we want to use Selenium to power a web browser, and have a client connect to it, so that we can use that client with our step definitions, and make those steps do things in the browser.

Learnboost have made a really nice Selenium client called [Soda](https://github.com/LearnBoost/soda), and I use along with [Selenium-launcher](https://github.com/nshah/nodejs-selenium-launcher) in the world.coffee file, like this:

    World = (callback) ->
      process.env["SS_ENV"] = "cucumber"

      config                = require '../../server/config.coffee'

      selenium              = require 'selenium-launcher'
      soda                  = require 'soda'
      app                   = require '../../app.coffee'

      selenium (err, selenium) =>

        @browser = soda.createClient
          host:     selenium.host
          port:     selenium.port
          url:      "http://localhost:#{config[process.env['SS_ENV']].port}"
          browser:  "firefox"

        callback {@browser}
        process.on 'exit', -> selenium.kill()

    exports.World = World

Points of interest are that the config is used to pass the application's url to the selenium client, so that it can load the application in the browser. Secondly, the selenium client is returned in the callback, which allows us to use that client in the step_definitions file to make the steps do things in the browser.

Making the browser do things
---

We now return to our signup_steps.coffee file, and hook up the world.coffee file to it:

    module.exports = ->

      @World = require("../support/world.coffee").World

We now want to make the first step in the signup.feature file pass. For that, we need to make the browser load the SocketStream application's url:

    @browser.chain.session().open('/').end (err) ->
      if err?
        cb.fail(throw(err))
      else
        cb()

The 'chain' function called is key. It allows you to collect a group of Selenium commands, and then execute them one after the other. With this, we allow the steps to call selenium commands via the selenium client, and execute those selenium commands in one group. This way, the cucumber feature can interact with a web browser to test that the application does what we expect.

The elbow work is in writing the appropriate selenium commands for each step definition. Here is how the signup_steps.coffee file as I have it setup:

    wrap = (funk, cb) ->
      funk.end (err) ->
        if err?
          cb.fail(throw(err))
        else
          cb()

    module.exports = ->

      @World = require("../support/world.coffee").World

      @Given /^I am on the homepage$/, (callback) ->
       wrap @browser.chain.session().open('/'), callback

      @Given /^I follow "([^"]*)"$/, (link, callback) ->
        wrap @browser.chain.click("link=#{link}"), callback

      @When /^I fill in "([^"]*)" with "([^"]*)"$/, (field, value, callback) ->
        wrap @browser.chain
        .fireEvent("//input[@name=\"#{field}\"]",'focus')
        .type("//input[@name=\"#{field}\"]", value)
        .fireEvent("//input[@name=\"#{field}\"]",'keyup')
        .fireEvent("//input[@name=\"#{field}\"]",'blur')
        , callback

      @When /^I press "([^"]*)"$/, (name, callback) ->
        wrap @browser.chain
        .fireEvent("//button[text()=\"#{name}\"]",'focus')
        .click("//button[text()=\"#{name}\"]")
        , callback

      @Then /^I should see "([^"]*)"$/, (content, callback) ->
        wrap @browser.chain.assertTextPresent(content), callback 

      @Then /^I should see the projects page$/, (callback) ->
        wrap @browser.chain.waitForElementPresent("css=.project"), callback

      @Then /^I should see the home page$/, (callback) ->
        wrap @browser.chain.waitForElementPresent("css=.homepage"), callback

There is a 'wrap' helper function, which DRYs up some of the common code across the steps.

__Big point!__ Something worth noting is that if you are performing an action in the browser which is meant to trigger a Javascript event, then you will need to call the 'fireEvent' selenium command on that element with the event name.

Once you write the code that passes the cucumber steps, you can begin to develop your SocketStream application in the same BDD fashion as Rails provides.

Where next?
---

What I've managed to do so far with Cucumber and SocketStream (via Shogun and Dashku) is promising, but there is more that can be achieved, and I want to make doing BDD with SocketStream as smooth as it is with Ruby on Rails. I will balance this alongside commitments to Dashku, as well as finding work.
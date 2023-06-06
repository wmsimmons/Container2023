## The Repository
This repository is a single-page website to demonstrate resume data, a simple API, a small suite
of tests for it, hosted on a Python 3.9 Flask development web server in a Docker container and a small, customized Cypress test suite. The source code is available to anyone under the standard MIT license.

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
* [Features](#features)
* [Tests](#tests)
* Test Coverage [last page below]

Cancel changes
## Installation

*Note: Important to always check the directory before executing any command, if at any point something does not work, throws an error or isn't there when you think it should be, then check the directory before next run, or re-run your command (if you're sure it's safe to rerun) in the desired/correct directory. 

To get the solution up and running, it is assumed as a prerequiste after cloning (i.e. "git clone <..d@git-clone-link.git")
```mds
# something like ..
git clone <https:/..@git-clone-link.git>
```

that the Windows machine is of one of the latest versions with wsl, or the Linux-like shell. If "docker --version" does not output a version number, then wsl may not be on your machine. Try
```md
# type into a Windows cmd terminal
"wsl --install"
```
and then trying to use
```md
"docker image build -t <desired_name_for_container> ."
```
in the directory of the cloned repository, be sure to change directory (cd) into /src/, as that is where the Dockerfile and website application code live. It cannot compile without that Dockerfile. The docker job will likely take around a minute or two to finish, as there are many node_modules for Cypress, @cypress/code-coverage and other components.


Upon cloning the repo, it is now time to build the Flask container so the website can run, this process will compile the files into a sort of headless background operating system running our application. The Docker build command will set up the website (UI-based), and API in the container, and allow for the website (server?) to be served via a docker run. Performing a docker run after build completion will create access to the application through "localhost:5000" and "localhost:5000/resume" for the UI and API, respectively. To confirm that the container built properly and that the website renders okay without template errors, run a
```md
"docker run -p 5000:5000 -d <container_name>"
```
(where <container_name> is the same as <desired_name_for_container>) to start it on port (-p) 5000, and the container (i.e. flask_docker) will run as a detached process within the container (functionality of -d). IF you get the following error, unbind the port, or stop whichever container is occupying that port. 

```md
PS C:\Users\who\Container2023> docker run -p 5000:5000 -d ultimate_test
4ebc537e9dd47fd749683aa4403995a91a88832d67441e3601de11b3b3540444
docker: Error response from daemon: driver failed programming external connectivity on endpoint elated_ramanujan (4fa99ae0382bbf406458c28e60fc5533d0d9d76491badb8a4cdf6a3d29e2a447): Bind for 0.0.0.0:5000 failed: port is already allocated.
```

You can now open up any browser and visit "localhost:5000" to see the website or "localhost:5000/resume" for the API.

# Setting up Cypress tests
If Cypress is not set on your machine, then the NPM .msi file can be downloaded from Cypress' CDN > click the node-v[num]-x64, and that will kick off the install, it will take around 10-20 minutes to complete. After NPM/Node finishes, run
```md
"npm --version" and "npx --version"
```
to verify that Node.JS was installed properly. 

To install Cypress from Node, insert the following
```md
"npm install cypress --save dev"
```

Output should be similar to:
```md
added 173 packages in 1m

36 packages are looking for funding
  run `npm fund` for details
npm notice
npm notice New minor version of npm available! 9.5.1 -> 9.6.7
npm notice Changelog: https://github.com/npm/cli/releases/tag/v9.6.7
npm notice Run npm install -g npm@9.6.7 to update!
npm notice"
```

Cypress should be setup on your machine at this point.

Testing instructions can be found in the Testing section.


## Usage 

Once everything is set up through docker for the web application, issue the following:
```md
"run a docker run -p 5000:5000 -d <container_name>" 
```
command in the repository of the cloned solution, a long alphanumeric string will generate as the output. If Docker Desktop is installed on your machine, open that and click Containers > Status (it should say Running) to confirm that the container is on. At this point, it should be possible to open any browser and visit "localhost:5000" to visit the UI, or "localhost:5000/resume" to see the API.


## Features

- Cypress Test suite with ability to generate coverage report 
- Flask application in a docker container [on native Flask development web server]
- API within flask
- Apache2 web server integration was attempted with Flask but due to various errors and configuration issues on Ubuntu with the wsgi and app configuration variables and limitations of Alpine Linux combined with scarce documentation of Alpine Linux error handling, this portion will be released at a later time. However, a WSGI server configuration, app configuration file (+ a python VM) docker-compose.yml (file containing connection strings for servers that Docker reads), and a couple more binding actions are required to integrate a Flask app together with Apache2 and Docker. Those changes can be found in the /apache2_stuff


## Tests

The tests are Cypress-based, and can be run by using the command below for opening Cypress. Results can be displayed using the UI of Cypress after a test run concludes. If Cypress is not set on your machine, then instructions can be found in the Setting up Cypress tests section. To open Cypress for the first time, navigate to the /tests directory [cd /tests] and use the command:

```md
# opens Cypress UI
npx cypress open
```

.., as the
```md
"./node_modules/.bin/cypress open"
```
command recommended by Cypress documentation can result in a "..\cypress.ps1 is not digitally signed. You cannot run this script on the current system" error when run on Windows.

When the window opens it will be a UI with a text "Welcome to Cypress" > E2E Testing > Firefox (v108) > Start E2E Testing in Firefox > and at this point there should be two spec files, click on either to run the test.



## Test Coverage

Test coverage can easily be generated using a native Cypress utility called @cypress/code-coverage also be viewed using the "npx nyc report --reporter=text-summary" command, which will show columns for file names, statement percentage, branch, functionality, and line percentages, the coverage percentage is displayed under the columns of the output. It also has a column for uncovered functionality. Here are some commands that can be used to view the test coverage from different aspects. The follow prerequisites must be met before this utility will function properly:

•	npm package installs (-D option for nyc, ansi-regex)
•	A process called “instrumenting the code” takes place by use of a npm package called “nyc”, which analyzes the code, this utility takes some time and should run without error, or else Cypress will throw a message in the UI under After All and Before All (in the test panel window) asking if the instrumentation was ever performed, in this case, just go back to the directory of the /src/ folder (outside of it, not in the folder) and run “npm install nyc” again, as the first install can result in errors that keep it from continuing.
•	There must be a folder entitled /src on the main level of the application for the instrumentor to work. For simplicity, this solution was restructured to fit the requirements of nyc. The website/container functionality for the was placed (at the time of this writing) into a /src folder with /node_modules [as npm looks for this module to install it] on the outside and the tests and solution documentation on the same level as /src.
•	The cypress/support/e2e.js (an auto-generated file when a Cypress solution is created) must have the following placed into it:
```md
npm install -D @cypress/code-coverage
```
•	The cypress.config.js or cypress.config.ts also uses the following require statement to add the code-coverage package to Cypress
```md
const { defineConfig } = require('cypress')

module.exports = defineConfig({
  // setupNodeEvents can be defined in either
  // the e2e or component configuration
  e2e: {
    setupNodeEvents(on, config) {
      require('@cypress/code-coverage/task')(on, config)
      // include any other plugin code...

      // It's IMPORTANT to return the config object
      // with any changed environment variables
      return config
    },
  },
})
```
To view a pretty, human-consumible report, open up /tests/coverage/lcov-report/index.html (generated after a Cypress test run) in any browser and view the report for more details and even a chart to display the test coverage rate alongside the coverage percentage.


```md
$ npm install @cypress/code-coverage

# expected output

added 319 packages, removed 266 packages, and audited 579 packages in 16s

76 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```

```md
# just displays the coverage summary
$ npx nyc report --reporter=text-summary
```

```md
# displays the coverage file by file
$ npx nyc report --reporter=text
```
```md
# shows coverage up to line specified after the params for --lines
npx nyc report --check-coverage --lines 80
```

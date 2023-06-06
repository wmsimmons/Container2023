## The Repository
This repository is a single-page website to demonstrate resume data, a simple API, a small suite
of tests for it, hosted on a Flask development web server in a container. The source code is available to anyone under the standard MIT license.

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
* [Features](#features)
* [Tests](#tests)
* [Test Coverage](#test coverage)


## Installation

To get the solution up and running, it is assumed as a prerequiste that the Windows machine is of one of the latest versions with wsl, or the Linux-like shell. If "docker --version" does not output a version number, then wsl may not be on your machine. Try
```md
# type into a Windows cmd terminal
"wsl --install"
```
and then trying to use
```md
"docker image build -t <desired_name_for_container> ."
```
in the directory of the cloned repository.


Upon cloning, it is now time to build the container, this process will compile the files into a sort of invisible background operating system running our application. The Docker build command will set up the website (UI-based), and API in the container, and allow for the website (server?) to be started via a docker run. Performing a docker run after build completion will create access to the application through "localhost:5000" and "localhost:5000/resume" for the UI and API, respectively. To confirm that the container built properly and that the website renders okay without template errors, run a
```md
"docker run -p 5000:5000 -d <container_name>"
```
(where <container_name> is the same as <desired_name_for_container>) to start it on port (-p) 5000, and the container (i.e. flask_docker) will run as a detached process within the container (functionality of -d).

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

Once everything is set up through docker,
```md
"run a docker run -p 5000:5000 -d <container_name>" 
```
command in the repository of the cloned solution, a long alphanumeric string will generate as the output. If Docker Desktop is installed on your machine, open that and click Containers > Status (it should say Running) to confirm that the container is on. At this point, it should be possible to open any browser and visit "localhost:5000" to visit the UI, or "localhost:5000/resume" to see the API.

```md
!
```

## Features

- Cypress Test suite
- Flask application in a docker container [on native Flask development web server]
- Apache2 web server integration was attempted with Flask but due to various errors and configuration issues on Ubuntu with the wsgi and app configuration variables and limitations of Alpine Linux combined with scarce documentation of Alpine Linux error handling, this portion will be released at a later time. However, a WSGI server configuration, app configuration file (+ a python VM) docker-compose.yml (file containing connection strings for servers that Docker reads), and a couple more binding actions are required to integrate a Flask app together with Apache2 and Docker. Those changes can be found in the /apache2_stuff


## Tests

Go the extra mile and write tests for your application. Then provide examples on how to run them.
The tests are Cypress-based, and can be run by using the command below for opening Cypress. Results can be displayed using the "" command. If Cypress is not set on your machine, then instructions can be found in the Setting up Cypress tests section. To open Cypress for the first time, navigate to the /tests directory [cd /tests] and use the command:

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

Test coverage can easily be generated using a native Cypress utility called @cypress/code-coverage also be viewed using the "npx nyc report --reporter=text-summary" command, which will show columns for file names, statement percentage, branch, functionality, and line percentages, the coverage percentage is displayed under the columns of the output. It also has a column for uncovered functionality. Here are some commands that can be used to view the test coverage from different aspects.

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

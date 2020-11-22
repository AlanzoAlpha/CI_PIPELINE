# CI Pipeline Project

Below is an overview of my project which entails a flaskapp with a get method in a CI pipeline. This document is to aid with the understanding of this project.

## Table of Content
* [Objective](#Objective)
   * [Requirements](#Requirements)
   * [Application and Approach ](#Application and Approach)
   * [Tools Used ](#Tools Used)
* [Framework](#Framework)
   * [Font-End Application](#Font-End Application)
   * [Databases](#Databases)
   * [Postman](#Postman)
   * [Project Management](#Project Management)
   * [Testing](#Testing)
   * [Risk Assessment](#Risk Assessment)
* [Known Issues](#Known-issues)
* [Future Improvements](#Future-improvements)
* [Authors](#Authors)


## Objective
The objective of this project is as outlined below:

To set up a CI-pipeline that deploys a simple flask-app. The app should make use of terraform to build two data bases, one vm and one kubernete cluster. Folowing on ansible will install all the neccessary softwares onto the vm. Then jenkins will then deploy the app from github with webhook associated for updates. Using jenking the app is then pushed up to docker hub so that it can be deployed anywhere. I will then use kubernetes to deploy the app. 

The app is deploy with a deploy shell which automates the terafform infrastructure, and install software in the vms. 

The application works by:
1. The frontend service making a GET request to the backend service. 
2. The backend service using a database connection to query the database and return a result.
3. The frontend service serving up a simple HTML (`index.html`) to display the result.

### Database Connection

The database connection is handled in the `./backend/application/__init__.py` file.

A typical Database URI follows the form:

```
mysql+pymysql://[db-user]:[db-password]@[db-host]/[db-name]
```

An example of this would be:

```
mysql+pymysql://root:password@mysql:3306/orders
```
### Tools Used
* Scripting Languages: 
   * *Python*
   * *Bash/Shell*
   * *Yaml*
   * *Hashicorp Configuration Language*
   * *SQL*
   * **
   
* Applications:
   * *Jira Board*
   * *GitHub*
   * *AWS*
   * *GCP*
   * *Visual Studios Code*
   * *Excel*
   * *PyCharm*

### Risk Assessment
* A risk assessment was perform to analyse and mitigate all potential risk. A table is presented below outlining these risks. 
 * *Risk Assessment*
 <img src="Images/unittesting.png" width="800" height = "400">
 
## Framework
### Flask-app Process
The images below shows the connections.
![app-diagram](https://i.imgur.com/wnbDazy.png)

### CI Pipeline
The following image shows CRUD operation on GCP MySQL database:
* *CRUD*
### Testing
The tests are are done for  both the frontend and backend services.

To test the backend service, you will need two things:

1. A database called `testdb`
2. A `TEST_DATABASE_URI` environment variable, which contains the database connection for the `testdb` database.

You can run the tests using the command:

```
pytest
```

To generate a coverage report, you will need to run:

```
pytest --cov application
```
<img src="Images/unittesting.png" width="800" height = "400">
## Infrastructure

The **Minimum Viable Product** for this project should at least demonstrate the following infrastructure diagram:

![mvp-diagram](https://i.imgur.com/i5qfOas.png)

**Stretch goals** for this project include:

- Using **Terraform to configure the Kubernetes Cluster** for production 
- Using **Terraform and Ansible to configure the Test VM**

Completing the stretch goals should yield an infrastructure diagram similar to the following:

![stretch-digram](https://i.imgur.com/Q5zljVl.png)

## Known Issues
When running a jenkins file which has variables exported. You will need to mitigate special charaters please see GitHub.  


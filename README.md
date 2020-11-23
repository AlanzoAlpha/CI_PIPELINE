# CI Pipeline Project

Below is an overview of my project which entails a flaskapp with a get method in a CI pipeline. This document is to aid with the understanding of this project.

## Table of Content
* [Objective]  
   * [Requirements]
   * [Application Approach ]
   * [Tools Used ]
* [Framework]
   * [Flask-app Process One, Terraform]
   * [Flask-app Process Two, Ansible]
   * [Flask-app Process Three, Docker Build on Jenkines Pipeline]
   * [Flask-app Process Four, Testing on Jenkines Pipeline]
   * [Project Management]
   * [Risk Assessment]
* [Known Issues]
* [Future Improvements]
* [Authors]


## Objective
The objectives of this project are as outlined below:

To set up a CI-pipeline that deploys a simple flask-app. I will make use of terraform to build two data bases, one vm and one kubernete cluster. Folowing on, I will use ansible install all the neccessary software onto the vm. Then jenkins will then deploy the app from GitHub and use webhook associated for updates. Using jenking the app is then pushed up to docker hub so that it can be deployed anywhere with kubernetes. I will then use kubernetes to deploy the app. 

- The process is deployed with a deploy shell script which automates the terafform infrastructure, and install software in the vms. 
- Only one vm was used to make the automation process easier to automate. 

The application works by:
1. The frontend service making a GET request to the backend service. 
2. The backend service using a database connection to query the database and return a result.
3. The frontend service serving up a simple HTML (`index.html`) to display the result.

### Requirements

The database connection is handled in the `./backend/application/__init__.py` file.

A typical Database URI follows the form:

```
mysql+pymysql://[db-user]:[db-password]@[db-host]/[db-name]
```

An example of this would be:

```
mysql+pymysql://root:password@mysql:3306/orders
```
The images below shows the connections.

![app-diagram](https://i.imgur.com/wnbDazy.png)

### Application Approach
The requirements are as desplayed below. 
The **Minimum Viable Product** for this project should at least demonstrate the following infrastructure diagram:

![mvp-diagram](https://i.imgur.com/i5qfOas.png)

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


 
## Framework
### Flask-app Process One, Terraform
Terraform is use to launch one vm, two databases, and one ekc.

<img src="images/terraform.png" width="800" height = "400">

### Flask-app Process Two, Ansible
Ansible is used to install all the neccessary software on the vm including jenkins.

<img src="images/ansible1.png" width="800" height = "400">
<img src="images/ansible2.png" width="800" height = "400">

### Flask-app Process Three, Docker Build on Jenkines Pipeline
Result

<img src="images/result1.png" width="800" height = "400">

Doker Push

<img src="images/dockers.png" width="800" height = "400">

### Flask-app Process Four, Testing on Jenkines Pipeline
The tests are are done for  both the frontend and backend services.

Frontend 

<img src="images/frontend_test.png" width="800" height = "400">

Backend

<img src="images/backend _test.png" width="800" height = "400">

### Flask-app Process Five, Run Kubernete Pods

###Project Management
A Jira Board was used to tract this project. It has the capability for monitoring, project collaboration and, project planning and management. The image below shows all my panning and processes.
Jira Board

<img src="images/jira.png" width="600" height = "300">

### Risk Assessment
A risk assessment was perform to analyse and mitigate all potential risk. A table is presented below outlining these risks. 
Risk Assessment

<img src="images/risk.png" width="800" height = "400">

## Known Issues
When running a jenkins file that has variables exported. You will need to beaware of methods to mitigate special charaters.  

##Future Improvements
- The code can be improve later on to be more concise.
- The app can be improve to incoperate a update, post and create method.
- More securitry measures can be added.

##Written By
Alanzo

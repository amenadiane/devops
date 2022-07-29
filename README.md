# FEATHER-REACT-APP

Feather react app

# OVERVIEW

This repository contains the necessary configuration for deploying a CI/CD pipeline in AWS for deploying a React frontend app, and an Express backend that the frontend connects to.

# ARCHITECTURE
![codechallenge draw drawio](https://user-images.githubusercontent.com/97837753/181680660-a486ced7-8f41-478e-b28f-506d0b79f5bc.png)

# SOLUTION

**1. Setup CLOUDFORMATION template for preparing an Amazon Linux 2 EC2 instance on which we will install CodeDeploy agent. We will use Cloudformation to deploy the EC2 instance with the user-data script below:**

          yum update -y
          yum install ruby -y
          yum install wget -y
          cd /home/ec2-user
          wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
          chmod +x ./install
          ./install auto
        
 Create Cloudformation stack using AWS CLI
 
 aws cloudformation create-stack --stack-name Cloudformation-code-challenge --template-body file://application-team-instance.yml
 
 Once the server is up - check the status of the codeDeploy agent
 
 sudo service codedeploy-agent status
 
 **2. Setup CODEDEPLOY for deploying our project onto our EC2 instance**
 
 Write an appspec.yml with all the instruction for deploying our code. We used three scripts to achieve our goal:
 
* install.sh -> this script will install globally node and all the utilities needed

  #add nodejs to yum
#curl -sL https://rpm.nodesource.com/setup_lts.x | bash -
#yum install nodejs -y #default-jre ImageMagick

#Install NVM package manager for manager separate versions of nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh

#Install node 14
nvm install 14

#install pm2 module globaly
npm install -g pm2
pm2 update

#install nc utility
yum install nc -y

#delete existing bundle
cd /home/ec2-user
rm -rf backend
rm -rf fontend

* run.sh -> this script will start the backend and frontend in the given order as the frontend depends on the backend

#!/usr/bin/env bash

cd /home/ec2-user/backend
npm ci
pm2 start index.js

cd /home/ec2-user/frontend
npm ci
pm2 start "npm start"

* validate.sh -> this script will validate whether the app is up on port 8080

#!/usr/bin/env bash
sleep 10
# validating that the host is up on 8080
nc -zv 127.0.0.1 8080

**3.  Finally setup the CODEDEPLOY to deploy onto our EC2.**

#**VALIDATION**

URL

<img width="590" alt="image" src="https://user-images.githubusercontent.com/97837753/181688359-1528bbf7-43b1-4720-a388-6f1816139b47.png">

<img width="644" alt="image" src="https://user-images.githubusercontent.com/97837753/181690969-d714ba7e-1921-4639-982d-e920acb5ae8c.png">


<img width="538" alt="image" src="https://user-images.githubusercontent.com/97837753/181688672-ebb4470b-2541-4683-aa5f-d60c6004dccc.png">


# **FUTURE ENHANCEMENT**

- As future improvement, we can hug everything in a pipeline.
- Move to a serverless architecture
- Add IP address to a Route 53 domain.

# PhotoSite Application Running on AWS in Docker

- [Team Members](https://github.com/WebSystemProject/R_AWS/wiki#Team-Members)
- [Introduction & Purpose](https://github.com/WebSystemProject/R_AWS/wiki#section-1-introduction--purpose)
- [Amazon Web Services S3 Bucket](https://github.com/WebSystemProject/R_AWS/wiki#Amazon-Web-Services-S3-Bucket)
- [Initializing the Ruby on Rails (RoR) Application](https://github.com/WebSystemProject/R_AWS/wiki#Follow-these-steps-to-Create-RoR-Application)
- [Running on Local Machine (RubyMine IDE)](https://github.com/WebSystemProject/R_AWS/wiki#Follow-these-steps-to-Create-RoR-Application)
- [Containerizing the Ruby on Rails Application](https://github.com/WebSystemProject/R_AWS/wiki#Containerizing-the-Ruby-on-Rails-Application)
- [Building Docker Image and Running on Local Machine](https://github.com/WebSystemProject/R_AWS/wiki#section-2-building-the-docker-image-and-hosting-this-image-on-docker-hub-then-running-this-application-through-docker)
- [Elastic Cloud 2 Instance Creation](https://github.com/WebSystemProject/R_AWS/wiki#Elastic-Cloud-2-Instance-Creation)
- [Deploying the Docker on Newly Created Instance](https://github.com/WebSystemProject/R_AWS/wiki#Deploying-the-Docker-on-Newly-Created-Instance)
- [Running the Docker Image on AWS EC2](https://github.com/WebSystemProject/R_AWS/wiki#running-application-on-ec2)
- [Final Application](https://github.com/WebSystemProject/R_AWS/wiki#running-application-on-ec2)
- [Project YouTube URL](https://github.com/WebSystemProject/R_AWS/wiki#section-4--youtube-url)
- [Issue 1 Solution - Allocation of Static IP](https://github.com/WebSystemProject/R_AWS/wiki#section-5-special-issue-1)
- [Issue 2 Solution - Allocation of Static IP](https://github.com/WebSystemProject/R_AWS/wiki#section-6-special-issue-2)
- [Image Reference](https://github.com/WebSystemProject/R_AWS/wiki#Application-Images-Reference)

## Team Members

### Abhay Tyagi
### Vijayalaxmi Patil 
### Manohar Singh Rajawat

## Section 1) Introduction & Purpose

### Introduction

* This Application is build on Rails Framework of Ruby Programming language. We've used the docker container to host this application on AWS EC2 (Amazon Web Services Elastic Cloud) Instance. All the images used in this project are hosted on the AWS S3 Bucket with public access. This application mainly contains two web pages (Views in Rails) which are given below :- 
1. User List
* This shows the list of users registered on the application. Their names will be href links. By clicking the link users can see the photos uploaded by specific user.
2. User Photo List
* This shows the list of photos uploaded by the user. This will have a comment section also under the images uploaded by user. In comment section there are three Values
1. User Comment 
2. User Picture
3. Comment Date

* By clicking the username (who created the comment), The photo list page will be opened for that user.

YouTube URL Link - https://www.youtube.com


GitHub Code Link - https://github.com/WebSystemProject/R_AWS


GitHub Wiki Link - https://github.com/WebSystemProject/R_AWS/wiki


### Purpose

* By following this documentation you'll learn following concepts:- 

1. Ruby on Rails Framework
2. Database Model in Rails
3. Docker Containers 
4. Hosting Docker on EC2
5. AWS S3 Bucket Configuration as well as Uploading Content
6. DockerHub Repository Commands

## Amazon Web Services S3 Bucket

### Creating and Uploading Images in AWS S3 Bucket

1. Go to AWS Console and Select S3 Bucket.
2. Now Click on Create bucket.

![Create Bucket](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(35).png)

3. Click Upload Button and Upload all the files.

![Upload Image In Bucket](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(36).png)

4. To give public access to content select image and click make public.

![Make Image Public](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(47).png)

5. Now We'll generate Bucket Policy. Select Bucket -> Permissions -> Bucket Policy -> Policy Generator

6. But before generation policy We need IAM Role created for our EC2 instance.

* Go to services -> IAM -> Roles -> Create Role

![Create New Role](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(48).png)

* Select EC2 Services.

![Create New Role](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(49).png)

* Then Select AmazonS3ReadOnlyAccess / AmazonS3FullAccess

![Create New Role](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(50).png)

* Now Fill Role Name and Click Create Role

![Create New Role](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(51).png)

* Now Go to S3 Instance and attach this IAM role to that instance. Instance -> Actions -> Security -> Modify IAM Roles

![Create New Role](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(52).png)

* Now Click Save

![Create New Role](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(53).png)

7. Now fill the details in following fields 

	 * Select Policy type: S3 bucket Policy.
	 * Effect: Allow
	 * Actions: GetObject
	 * Paste bucket ARN and add /* after this so the access is applied to all photos .
	 * Click Add Statement.

![Create New Role](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(58).png)

* Click Generate Policy 

![Create New Role](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(55).png)

* Copy this JSON To Policy and Click Save.

### Follow these steps to Create RoR Application.
 *  Create a new RoR Project.
 
        New Project -> Rails -> application -> Select Rails Version. For database select postgres. Click Create.

 * Now We'll create the Controller and Views for Application
1. Photo
2. Comment
3. ListUser
 
 		Select Tools -> Run Rails Generator -> Type Controller followed by Model Names.

It will generate the model as well as the views for the application

![Create Controller](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(38).png)

![Create Controller](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(39).png)

![Create Controller](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(40).png)
 	
 * Now We'll create the Model in Database for Application

                Select Tools -> Run Rails Generator -> Type Model Names followed by Model Names.

![Create Model](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(59).png)

1. Usercomment
2. Userphoto
3. Userlist

Now It will generate Model Files which will be used to fetch the data from database and then render the views to the user.

Now in the models we'll define the relation between models.

1. Comments belongs to Photo as well as User

![Relation Model](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(60).png)

2. User is parent to Comment

![Relation Model](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(61).png)

3. Photo is parent to Comment

![Relation Model](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(62).png)

 
* Now We'll create some migration files for our database relations.
 
 		Tools-> Run Rails Generator -> Migration File name followed by Migration. 

1. Adding Foreign Key to User Comment
2. Adding Photo to Comment
3. Adding User to Comment

This will create following migrations. 

![Relation Model](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(63).png)

 * Now Run the migration. Run the following command: 

 		rails db:migrate

* The model and controller are generated Now We'll write Code in Views. Views are the HTML+CSS+JS which will be rendered to user in frontend.

* User List View

![Relation Model](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(64).png)

* Photo View

![Relation Model](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(65).png)

### Now We'll run this project on local machine.

1. Click Shift+F10 Or Run Button

![Relation Model](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(67).png)

2. It will Start a Rails web server in the application and will be listening the incoming connection on port 3000.

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(68).png)
![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(69).png)
![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(70).png)

#### Containerizing the Ruby on Rails Application

**What is Docker**

When we run the application local machine, we install dependencies related to application to make it running on local machine. but when we deploy this application on cloud we need to again install the dependencies there. To Solve this issue we create a image file on local machine which is having all the dependencies installed. Then we deploy this image to Cloud. Now we don't need to install anything on the cloud. We just have to run this image. This image is called docker image.

We'll create this image and will upload this image on docker hub (Which is the official repository hub of docker images). Then We'll pull this image on our EC2 instance and run it over there.

## Section 2) Building the docker image and hosting this image on docker hub. Then running this application through docker.

#### Create a repository to host docker image in docker hub

1. Select Create Repository and fill the details like repository name and description. Select the repository visibility to public.

![Docker Hub](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(71).png)

2. Repository Description Like Pull commands.

![Docker Hub](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(72).png)

#### Building Docker Image and Running it.

To Build the docker image we need two files.

1. Dockerfile (Main File)
Create the Dockerfile and fill the details according to project requirement. This file is mainly responsible for all the dependencies as well image building.

![Docker Hub](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(79).png)

2. docker-compose.yml (Services File)
This file is responsible for services running on application like database and server

![Docker Hub](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(74).png)

3. Now Go to terminal and run the following command

		docker build -t project:docker .

![Docker Hub](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(75).png)

3. It will build a docker images which we'll check with following command

               docker images

![Docker Hub](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(76).png)
 

4. Now We'll run this image on local system 

		docker run -p 3000:3000 -it project:docker 

![Docker Hub](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(77).png)

Server Starts in listening mode on port 3000 through docker container. Wow We've come so far ! 		

6. To View to home page visit http://localhost:3000/users/index. This will show the list of users and then we can click on the user name to see all the photos uploaded by them.

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(68).png)
![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(69).png)
![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(70).png)

7. Now we'll tag this image to docker hub and then will push this image to dockerhub. 

		docker tag project:docker manoharsingh1025/raws

8. Now hit the push command to host this image on dockerhub

		docker push manoharsingh1025/raws

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(78).png)

### Amazon Web Services Elastic cloud 2 

#### Elastic Cloud 2 Instance Creation
1. Login to Amazon Web Services and Search for EC2

2. Now Select Launch Instance

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(10).png)

3. It will ask you to select Image Select Ubuntu Server (20.04)

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(12).png)

4. Now Select the instance tier t2 -> t2.micro (Free Tier Available) and Click **Review and Launch** It will have all the setting by default like security group and storage etc.

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(13).png)

9. Now Create a Key-Pair to access your instance through ssh (SSH -i Keypair.pem Instanceurl)

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(15).png)

10. Now Click **Launch Instance**

11. It will take around 2 to 5 minutes to initializing an instance for you.

12. After the instance is created. Click on the connect box and click SSH Client And copy the string and paste it in your machine's command line

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(80).png)
![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(81).png)

13. Paste the string in cmd (Windows). Press yes for first time and congratulations you're successfully logged in to your instance.

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(82).png)

#### Deploying the Docker on Newly Created Instance

1. After you're logged in to your instance. Run the following command in the terminal to update the advance packet manager repositories.

		sudo apt-get update

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(19).png)

4. Then We'll run the following command to install the required packages on EC2 instance.

		sudo apt-get install     apt-transport-https     ca-certificates     curl     gnupg-agent     software-properties-common

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(20).png)

5. Then Run the curl command to get the PGP public key and add this key to your EC2 Instance. This PGP(GPG) key is used to validate the images on the repository.

		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

6. Now We'll add the fingerprint by running the following command

		sudo apt-key fingerprint 0EBFCD88

7. To add the repository we'll run following command

		sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" 
   
8. Finally run this command to update the repository

		sudo apt-get update

9. Now the repositories are updated, we can install the docker.

		sudo apt-get install docker-ce docker-ce-cli containerd.io

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(21).png)

10. This command will give you options to select which docker version you want to install on the instance.

		apt-cache madison docker-ce

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(83).png)

11. Now Select the Version and add this to following command to install that version.

		sudo apt-get install docker-ce=5:20.10.4~3-0~ubuntu-focal docker-ce-cli=5:20.10.4~3-0~ubuntu-focal containerd.io

##### Deploying Docker to AWS EC2

1. To start docker service on EC2 instance 

		sudo service docker start

2. Pull the docker image on EC2 instance 

		sudo docker pull manoharsingh1025/raws

3. To install and run docker image of Application

		sudo docker run -p 3000:3000 -it manoharsingh1025/raws 

This will start the server in listening mode on port 3000. But Still the web page is not accessible because we haven't setup the EC2 instance to accept request on port 3000

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(84).png)

To accept connection on port 3000. We'll add new rule to accept connection on port 3000.

                Instance -> Security -> Security Groups -> Inbound Rule

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(34).png)

##### Running Application on EC2

Now From the terminal run the following command

                sudo docker run -p 3000:3000 -it manoharsingh1025/raws

Now Visit the PUBLICIP:3000/users/index to visit the home page of application. Wow ! The application is running smoothly and successfully on newly created EC2 instance. Now anyone can see our application.

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(30).png)
![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(31).png)
![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(32).png)
![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(33).png)

## SECTION 4)  YouTube URL
https://www.youtube.com

## SECTION 5) Special Issue 1

#### what happens when an instance stops running?


#### What we can do to overcome this issue:



## SECTION 6) Special Issue 2

#### what happens when you reboot an instance and what can you do?

The IP Address AWS assigns to the instance was selected from dynamic pool. So it changes automatically once the server restarts.

#### What we can do to overcome this issue:

#### Elastic IP on EC2 Instance

AWS managers their pool of Elastic IP addresses. Which can be assigned to Instances and other running services on AWS Cloud. I sometimes prefer calling Elastic IP as Static IP because it is not changing without admin changes.

1. To Allocate new elastic Ip Address to our instance Go to Services -> Elastic IP -> and Click Allocate Elastic IP Address

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(23).png)

2. Leave the settings as default (Auto Pool of Amazon) and Click Allocate.

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(24).png)

4. Now Select Allocate Elastic IP address

![Application](https://github.com/WebSystemProject/R_AWS/blob/main/ImageShot/Screenshot%20(25).png)

5. Select the reallocation check box for future instance allocation and Click Associate. Congratulations Our instance is running on Static/Elastic IP Address Now.


###### Application Images reference

http://unsample.net/

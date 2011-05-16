Welcome to  Jenkins4Rails
=========================

This is a guide on how to setup your jenkins CI server to build and test rails 3 applications

Objectives
----------

The main goal is to explain how to use jenkins to test rails 3 apps. 

The environment will make use of RVM, rspec and capybara for acceptance tests.

Requirements
------------

* Linux (debian based is preferred)

Getting Started
---------------

* Install Jenkins:

	* Add the jenkins key to apt  
		`$ wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -`

	* Add jenkins apt repo to your /etc/apt/sources.list  
		`$ deb http://pkg.jenkins-ci.org/debian binary/`

	* Update your local package index and install jenkins:  
		`$ sudo apt-get update`  
		`$ sudo apt-get install jenkins`

* Configure jenkins environment:  

	* Change to jenkins user  
		`$ sudo -Hiu jenkins`  
		and go to jenkins home  
		`$ cd`

	* Install RVM:  
		`$ bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)`  
		`$ type -t rvm # should return "function"`  
		`$ rvm install ree # 1.9.2, head or whatever`  
		`$ rvm use --default ree@global`  
		`$ gem install bundler`  
		`$ rvm gemset create name-of-your-project-gemset`  

	* Create the jenkins keys to access github  
		`$ ssh-keygen -t dsa -C "Jenkins key"`  
		`$ git config --global user.email "jenkins@your-domain.com"`  
		`$ git config --global user.name "jenkins"`  

	* Go to github and add the new key to your github project
	
	* Copy .bashrc file to jenkins home:  
		`$ mkdir tmp && cd tmp`  
		`$ git clone git://github.com/gmonfort/jenkins4rails.git`  
		`$ cp jenkins4rails/.bashrc .`  

* Configure jenkins

	* go to [http://localhost:8080][localhost]  
		* go to Manage Jenkins -> Manage Plugins -> Available ([http://localhost:8080/pluginManager/available](http://localhost:8080/pluginManager/available "Available Plugins"))
		* Install [Jenkins GIT Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin)
		* Create a new jenkins job:  
			* In the jenkins home click on "New Job"
			* Give it a name and choose "Build a free-style software project"
			* In the next page under "Source Code Management" choose GIT
			* Enter the URL of your github project (i.e. git://github.com/gmonfort/jenkins4rails.git)
			* Choose a trigger under "Build Triggers" (i.e. periodically, * 1 * * * stands for daily)
			* Under "Build" select "Execute Shell" and put the following:  
				<pre>
				#!/bin/bash -x  
				source ~/.bashrc  
				rvm use 1.9.2@name-of-your-project-gemset  
				bundle install  
				rake db:migrate  
				rake db:test:load  
				rake spec
				</pre>

			* Save your job and schedule a new build (click on "Build now")
			* Under "Build History" you'll see your new build running or scheduled to run, click on it,  
			  then click on "Console Output" to see the log


[localhost]: http://localhost:8080 "localhost port 8080"
<!-- vim: set ai ts=4 sts=4: -->

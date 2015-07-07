RECALLSFEED
===========

[URL to Prototype](http://ec2-52-27-128-182.us-west-2.compute.amazonaws.com/agile-bpa)

RRecallsFeed is a prototype developed using openFDA APIs, it uses the food recall datasets to show how agile iterative development can affectively work for digital solutions. Using this RecallsFeed prototype you can search by any combination of Food Name, Date Range and Seriousness or check the recent food recalls listing

Powered by Bootstrap, jQuery, JSP and J2EE tecnologies, this 2 page web application utilizes the OpenFDA dataset as its model, and is designed as a tool to help consumers check for recalls food product.

*Please note that openFDA is a beta research project and not for clinical use. While the FDA makes every effort to ensure that data and logic are accurate, you should assume all results are unvalidated.*

# Contents
This repository contains code for prototype web application  which connects to the `https://api.fda.gov/food/enforcement.json` end point.  

It includes:

* java and jsp files.

* javascript files

* Stylesheets and fonts

# Prerequisites

This web application requires no backend server support, but does require an open internet connection and a modern browser, such as 
   * Internet Explorer 11.0 or later
   * Firefox 38.0 or later 
or 
   * Chrome 43.0 or later

#Instructions to install and run on another machine 

Docker Image
 * Pre-requiste: Docker is installed and running
 * Pull  Docker repository  using `docker pull ppandyaiiinfo/agile-bpa`
 * Run Docker using `docker run -it -d -p 80:8080 ppandyaiiinfo/agile-bpa:latest`
 * Open any browser and go to URL: `http://machine-name/agile-bpa`  to run prototype

WAR file
 * Download the latest release from `https://github.com/IIInfo/Agile-BPA/releases/download/v2.0.0/agile-bpa-2.0.0-dist.zip`
 * Unzip `agile-BPA-v2.0.0-dis.zip`
 * Install the `agile-BPA.war` into your J2EE Container on your machine (server)
 * Open any browser and go to URL: `http://machine-name/agile-BPA` to run the prototype.

## License

None

## Copyright

Copyright <Triple-i> 2015 


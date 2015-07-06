
[![Build Status](https://travis-ci.org/FDA/openfda.svg?branch=master)](https://github.com/dougboude/tripleifdachallenge)

[[RECALLSFEED Prototype URL]]:(http://www.google.com)
#Agile Project Management
Our approach for creating the prototype began by identifying and designating a product manager who would be accountable for the vision, development, and product quality, while meeting the BPA’s acceptance criteria. This person has a product management background with the technical experience to assess alternatives and tradeoffs. He also had the sole authority to assign tasks and make decisions about features and technical implementation. [[EVIDENCE]] (https://github.com/IIInfo/Agile-BPA/blob/master/Docs/Program%20Management/Evidence_Product_Owner_with_Product_and_Team_Responsiblity.PNG)

The next step was to assemble a collaborative and multi-disciplinary team consisting of a Technical Architect, Backend Developer, Frontend Developer, Interactive Designer/Usability Tester, Visual Designer, and DevOps Engineer. These members have experience building high-traffic web and mobile applications using automated testing frameworks and modern DevOps techniques. [[EVIDENCE]](https://github.com/IIInfo/Agile-BPA/blob/master/Docs/Program%20Management/Evidence_Product_Owner_with_Product_and_Team_Responsiblity.PNG)

We used an Agile Scrum methodology for iteratively creating the prototype. Our goal was to release the minimum viable product as soon as possible and follow this with frequent delivery of additional features. Our typical sprints are 3-4 weeks long. Sprint 0 is used for laying the ground work, followed by multiple sprints designed to deliver iterative improvements to the working code, supported by a disciplined feedback and testing process. Each sprint includes sprint planning and daily scrum meetings and concludes with sprint review and retrospective meetings.

For the prototype we had a short Sprint 0. The product manager created the roadmap, or high-level view of the requirements and timeframe for prototype development. This included identifying and prioritizing all requirements (Product Backlog). A spreadsheet was used as a project management tool, maintaining initial high-level requirements from the roadmap. Detailed user stories were added iteratively as we interacted with users. A detailed task checklist ensured all work items were recorded and prioritized by the product manager. Feedback from users was integrated as additional tasks in the product backlog, which were then evaluated and approved by the product manager.

Sprint 1 started with a short sprint planning meeting prior to implementing sprint backlog items. We used daily morning scrum meetings to check on progress, resolve impediments, and discuss next steps.  Demo’s and feedback sessions with users occurred daily. The product manager worked with the team to quickly prioritize and approve changes. Users were encouraged to review iterative builds being deployed, and to send feedback to the product manager. [[EVIDENCE]] (https://github.com/IIInfo/Agile-BPA/blob/master/Docs/Program%20Management/Agile%20Scrum%20Project%20Management.pdf)

#Design Approach
To implement the prototype, we identified three users to play the role of typical users throughout the prototype’s life-cycle. We used an iterative human-centered design process that included: participatory design, a focus group, personas, scenarios, use cases, and usability testing. The prototype design evolved as we gained feedback from usability tests.

`Personas` -
We developed three personas to represent potential users of our product. [[More details]] (https://github.com/IIInfo/Agile-BPA/tree/master/design/usability/personas)

`Scenarios` -
We crafted scenarios that our personas are likely to encounter. We presented these scenarios to a focus group to generate ideas for the prototype. We also presented these scenarios to our usability testers during usability testing and we incorporated the scenarios into our use cases. [[More details]] (https://github.com/IIInfo/Agile-BPA/tree/master/design/usability/focus%20group)

`Use Cases` -
We created use cases for each scenario to identify user behavior in the application flow and to see if impediments will prevent the user from obtaining desired results. [[More details]] (https://github.com/IIInfo/Agile-BPA/tree/master/design/usability/use%20cases)

Usability Testing

The prototype design began with a wireframe which was collaboratively designed using the Balsamiq online wireframing tool. We turned this wireframe into a paper prototype by printing and cutting out design elements and adding Post-it® notes for users to enter data. The initial round of usability testing on this paper prototype, performed on two testers, revealed that the design lacked icons for users to click to get more details on search result listings. We added clickable labeled icons to the next iteration of the design.

We performed usability testing on the HTML prototype with three testers. One tester tried to obtain details about a recall by clicking on an image in the slideshow at the top of the page. The slides did not have hyperlinks and the tester was surprised when nothing happened. We added links to the slides in the carousel after viewing this test. Another tester did not use the search filters when asked to find only foods recalled for undeclared peanuts, nor did she use the filters when asked to find foods that had only been recalled in the past week. The design team added more contrast to the search filter row to the next iteration. 

[[Evidence For Wireframes]]  (https://github.com/IIInfo/Agile-BPA/tree/master/design/wireframes)
  [[Evidence For Usability Test]] (https://github.com/IIInfo/Agile-BPA/tree/master/Docs/Usability/Usability%20tests/test1-paper%20prototype%20testing)
  [[Evidence For Usability_Test2]] (https://github.com/IIInfo/Agile-BPA/tree/master/Docs/Usability/Usability%20tests/test2-web%20prototype%20testing)
  [[Evidence Videos From Usability Tests]] (https://github.com/IIInfo/Agile-BPA/tree/master/Docs/Usability/Usability%20tests)

#Development Approach
Our technology decisions were based on using software frameworks that are commonly used for creating similar services and that can be deployed on a wide variety of commodity hardware. We used test driven development (TDD), creating unit and integration tests to verify modules and components. Normally we use Apache Selenium to create automate tests for all user-facing functionality, but we performed manual testing for the prototype

We created the prototype using industry common technologies and frameworks for front-end and back-end development. Our front-end developer created the template for the prototype from the wireframes provided by the design team. The Bootstrap framework, style guide, and pattern library were used to create a responsive design. Once the template was available, back-end engineers started creating the prototype application using TDD and using peer review of code as needed. We focused on quality by enforcing best practices and finding issues as early as possible. Development of the prototype went through several iterations as we continuously implemented and released features (user stories) and collected feedback from users and testers. The iterative development, review, and test process continued for rest of the sprint. Functional and non-functional testing was conducted by the product manager, and all defects identified were resolved by the development team.

The following technologies were used in the development of the prototype (HTML/CSS/LESS, JQUERY, JSON and JavaScript, JSP, eclipse, JUNIT, Bootstrap, openFDA API’s).

[[Evidence Style Guide]] (http://getbootstrap.com/css/)
[[Evidence Pattern Library]] (http://getbootstrap.com/components/)
[[Evidence Template]] (https://github.com/IIInfo/Agile-BPA/tree/master/Docs/HTML%20Prototype)
[[Evidence JUNIT]]  (https://github.com/IIInfo/Agile-BPA/blob/master/Code/src/com/iiinfo/servlet/TestFoodEnforcement.java)

#Configuration Management & Continuous Integration 
Our approach to configuration management for revision control and establishing baselines is to use GitHub as the SCM tool to handle automation and facilitate SCM best practices. Our goal is to allow as much change as possible while still maintaining control of the software. New baselines for prototype were creating before each nightly build. This allowed us the ability to reproduce any prior build as needed. Jenkins was used to automate the build process, which enabled us to integrate early and often. The build process is kicked in automatically when a change is detected on the GitHub repository.

[[Evidence GitHUB Releases]]  (https://github.com/IIInfo/Agile-BPA/releases)
[[Evidence GitHUB Tags]] (https://github.com/IIInfo/Agile-BPA/tags)
[[Evidence Jenkins]]  (http://ec2-52-27-21-134.us-west-2.compute.amazonaws.com/jenkins/job/Agile-BPA/)

#Hosting Platform & Virtual Container
Our Services are deployed on a flexible open source pay as you go commodity hardware hosting platform (Amazon EC2), which can be easily scaled to meet spikes in traffic and user demand. Further operating-system level virtualization is achieved by using Docker HUB to create Docker image for deploying software in a container.

Amazon EC2: Instance 1: (Runs prototype from Docker Image)
* OS Name: Ubuntu Server 14.04
* Virtual Container: Docker
* Prototype: (http://ec2-52-27-128-182.us-west-2.compute.amazonaws.com/agile-bpa)
* Docke_Hub: (https://registry.hub.docker.com/u/ppandyaiiinfo/agile-bpa)

Amazon EC2 Instance 2: (Runs Jenkin CI build and  deploy)
* J2EE Container (web Server): Apache Tomcat 6.0.44        
* JVM: Oracle/Sun Microsystems Inc. 1.6.0_45-b06                             
* Build Scripting: apache-ant-1.9.5
* URL: (http://ec2-52-27-21-134.us-west-2.compute.amazonaws.com/jenkins/)
* URL: (http://ec2-52-27-21-134.us-west-2.compute.amazonaws.com/agile-bpa/)


#Instructions to install and run on another machine 

Docker Image
 * Pre-requiste: Docker is installed and running
 * Pull  Docker repository  using `docker pull ppandyaiiinfo/agile-bpa`
 * Run Docker using `docker run -it -d -p 80:8080 ppandyaiiinfo/agile-bpa:latest`
 * Open any browser and go to URL: `http://machine-name/agile-bpa`  to run prototype

WAR file
 * Download the latest release from `https://github.com/IIInfo/Agile-BPA/releases/download/v1.0.0/agile-bpa-1.0.0-dist.zip`
 * Unzip `agile-BPA-v1.0-dis.zip`
 * Install the `agile-BPA.war` into your J2EE Container on your machine (server)
 * Open any browser and go to URL: `http://machine-name/agile-BPA` to run the prototype.


#Continuous Monitoring
Our approach to continuous monitoring is to provide actionable information for situational awareness over the entire operational stack of the environment. This encompasses infrastructure monitoring, application monitoring and security monitoring.

Infrastructure monitoring focuses on the platform infrastructure that supports application operations. The supporting AWS EC2, and VPC, infrastructure is monitored via AWS CloudWatch, AWS CloudTrail, AWS Config, and AWS VPC Flow Log. These elements are aggregated into an S3 bucket that allow for long-term storage and log review. These AWS features enable us to view usage across AWS APIs, CPU & disk usage, network plus the configuration state of the implemented AWS services.
At the application layer we turned to a robust application performance monitoring (APM) toolset provided by AppDynamics. These tools provide the full spectrum of APM from application health to transaction tracing.

For security monitoring we made use of the previously mentioned services plus AWS Security Groups (firewall) and OSSEC.  The Security Groups are configured to limit traffic and protocol traversal into and within our VPC infrastructure. OSSEC is an open source host-based intrusion detection system which we deployed within the VPC and installed OSSEC agents onto the relevant AWS instances. OSSEC is configured for active responses to identified threats, which includes automated IP blocking at the host.        
[[EVIDENCE]]
(https://github.com/IIInfo/Agile-BPA/tree/master/Docs/DevOps/continuous_monitoring/)


tripleiFDAchallenge is a proof-of-concept project to answer the OpenFDA Developer Challenge to use the FDA's publicly available data on drug adverse events, medical device adverse events, and medication error reports.  

Powered by jQuery, jQueryUI, charts.js, and Bootstrap 3, this single page HTML5 web application utilizes the OpenFDA dataset as its model, and is designed as a tool to assist researchers in identifying anomalies (*spikes*) in aggregated datasets meeting the researchers' specified criteria.  Furthermore, this tool enables researchers to delve into the details that comprise the identified anomalies.

*Please note that openFDA is a beta research project and not for clinical use. While the FDA makes every effort to ensure that data and logic are accurate, you should assume all results are unvalidated.*

# Contents

This repository contains code for a single page web application written in HTML5 which connects to the `api.fda.gov/drug/event.json` end point.  

It includes:

* A primary web application page written in HTML5.

* javascript files

* Stylesheets and fonts

# Prerequisites

This web application requires no backend server support, but does require an open internet connection and a modern browser, such as 
   * Internet Explorer 11.0 or later
   * Firefox 38.0 or later 
or 
   * Chrome 43.0 or later

# Packaging

A functional prototype of this web app, named Triple-i Researcher, is posted at http://iiiresearch.net/.

This web app may also be distributed via a simple zip file, to be installed and run locally.
To install, unzip the file on your local PC, then open index.html with a modern browser.

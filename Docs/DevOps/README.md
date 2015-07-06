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

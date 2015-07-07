#Continuous Monitoring
Our approach to continuous monitoring is to provide actionable information for situational awareness over the entire operational stack of the environment. This encompasses infrastructure monitoring, application monitoring and security monitoring.

Infrastructure monitoring focuses on the platform infrastructure that supports application operations. The supporting AWS EC2, and VPC, infrastructure is monitored via AWS CloudWatch, AWS CloudTrail, AWS Config, and AWS VPC Flow Log. These elements are aggregated into an S3 bucket that allow for long-term storage and log review. These AWS features enable us to view usage across AWS APIs, CPU & disk usage, network plus the configuration state of the implemented AWS services.
At the application layer we turned to a robust application performance monitoring (APM) toolset provided by AppDynamics. These tools provide the full spectrum of APM from application health to transaction tracing.

For security monitoring we made use of the previously mentioned services plus AWS Security Groups (firewall) and OSSEC.  The Security Groups are configured to limit traffic and protocol traversal into and within our VPC infrastructure. OSSEC is an open source host-based intrusion detection system which we deployed within the VPC and installed OSSEC agents onto the relevant AWS instances. OSSEC is configured for active responses to identified threats, which includes automated IP blocking at the host.        
[[EVIDENCE]]
(https://github.com/IIInfo/Agile-BPA/tree/master/Docs/DevOps/continuous_monitoring/)

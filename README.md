For Production environment.

Configuration:

1. Amazon route53 for DNS and traffic routing. 
2. Application Load balancer to distribute the traffic to mulitple EC2 instances
3. Use Auto scaling group of EC2 instances to scale up and down based on load. Deploy Apache and Wordpress binaries, Also configure the wordpress as required.
4. Use Amazon RDS for Database and enable the multi AZ for High availbility
5. Use EFS for shared storage between the EC2 instances.
6. Create a VPC with both public and private subnets
7. Deploy ALB in public subnet
8. Deploy ASG and RDS in private subnet
9. Allow only ALB traffic to EC2 instances, similarly only Allow EC2 instances traffic to DB. Security group configuration.
10. Create NAT gateway for EC2 instances to access the internet for updates or internal repos for  updates.
11. Create Routing tables accordingly.
=====================================================================================
Alerting:

Use Event bridge and SNS to create alerts when ever the Instances and RDS are down or overloaded.

======================================================================================
Monitoring and logging:

1. Install the cloud agent or any approriate logging mechanism and redirect the necessary logs to cloud watch or other tools like splunk.
2. Use AWS Cloudwatch metrics or other tools like grafana with prometheus to monitor health and performance of application

===========================================================================================
Security:

1. Use ACM or other certificate management tools to create the certificate and use at the ALB end.
2. Use WAF layer to prevent common webattacks
3. Configure Security groups to only allow traffic as required.
4. Use IAM roles for EC2 instances to access other AWS services.

============================================================================================
Backups:

1. Use AWS backup services to regular backup the EFS and RDS 

==========================================================================================
Others:

If we are using the wordpress website globally at mutiple regions, use the Cloud Front for static caching
Also we can DB performance by using Amazon elastic cache

Apart from using ASG with EC2 instances, we can use ECS or EKS services to run the wordpress websites along with RDS and EFS.
EKS setup can be little complex, Also we need to pay for EKS cluster too apart from worker nodes.
Can use ECS with EC2 or ECS with Fargate too.

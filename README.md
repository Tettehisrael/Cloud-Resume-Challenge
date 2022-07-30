# Cloud-Resume-Challenge

This project is my online resume, a static web page, serving simple html & css I wrote from scratch to keep it clean.

Using "aws-vault", which helps me manage AWS profiles and store credentials securely, and GitHub actions is using secrets for this during CI/CD.

You can visit [my domain here](http://www.tettehisrael.com.s3-website-eu-west-1.amazonaws.com/) which is the result of this project.

## How this project works:

Any push to the Master branch will trigger the Github actions i created which will:

  - Terraform init
  - Terraform apply (auto approve)
  
  
 ## High level description of functionality
 
   - S3 bucket hosts the website
   - certificates and permissions configured in AWS Route53, ACM, Policies
   - Cloudfront used to meet https requirement and cache control
   - DynamoDB and Lambda function used to implement visitor counter.
   - JS used to retreive counter value from API and display on site
   - APIGateway used to implement API endpoint
   
   # Application Architecture
   
   ![this is an image](https://user-images.githubusercontent.com/98762800/156835852-d4388868-afae-4ee7-91a6-139b3372e9c5.png)
   

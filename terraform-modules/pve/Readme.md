**Step 1**

 - Create user called ```terraform@pam```
 - Create token belongs to ```terraform@pam```
 - Create a Linux server template based on Debian
 
**Step 2**
 - Install terraform onto PVE server<br>
 ```apt update && apt install terraform```
 
**Step 3**<br>
 
 run terraform provisioning scripts
 - ```terraform init```
 - ```terraform plan```
 - ```terraform apply```

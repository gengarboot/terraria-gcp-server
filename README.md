# How this project was created
- Create GCP project
- Create a billing account 
- Link project to the billing account
- Enable following GCP api
    - Compute Engine API
    - Identity and Access Management (IAM) API
- Create a service account 
    - Create service key (json) and download and put in root of terraform project locally
- Add key to .gitignore
- Create terraform.tfvars and fill in the following for your project in gcp
    - gcp_svc_key = "" # Location of the service key on disk relative to the root of this project 
    - gcp_project = "" # the gcp project name
    - gcp_region = "" # the gcp project region you selected 
- Run terraform init in ./infra directory
- Run terraform apply in ./infra directory
- Check the output in the terminal for information on what the instances external-ip is


# Goals
- Have a compute instance running terraria
- Have a Cloud bucket that have the terraria world saved between sessions
- Automatically load in last world on start-up
- Automatically save to bucket on shut-down
- Have firewall rules only allowing in specific IP ranges

## Stretch goals
- Easy way to start and stop server

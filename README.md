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
- Run terraform init in ./infra directory
- Run terraform apply in ./infra directory


# Goals
- Have a compute instance running terraria
- Have a Cloud bucket that have the terraria world saved between sessions
- Automatically load in last world on start-up
- Automatically save to bucket on shut-down
- Have firewall rules only allowing in specific IP ranges

## Stretch goals
- Easy way to start and stop server

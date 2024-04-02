# Project Capital Bikeshare

## Overview
This project extracts, moves and analyzes DC's [Capital Bikeshare](https://ride.capitalbikeshare.com) data.

Where do Capital Bikeshare riders go? When do they ride? How far do they go? Which stations are most popular? What days of the week are most rides taken on? 
This project successfully attempts to extract the data, move, store and analyze the insights to answer some key questions about Washighton DC's Capital BikeShare.

This project was created as part of the requirement needed for [DataTalksClub](https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main) certification.

## Project Objective
Succesfully move data from Source, transform and Visualize in a dashboard.
Key Deliverables:
- Create end to end pipeline to move data by batching to analytical warehouse
- Build analytical dashboard to showcase insights

## Navigation / Quick Access
Quickly move to section you are interested in:
- [Project Architecture](https://github.com/EdidiongEsu/capital_bikeshare/tree/main#project-architecture)
- [Dataset](https://github.com/EdidiongEsu/capital_bikeshare/tree/main#dataset)
- [Technologies](https://github.com/EdidiongEsu/capital_bikeshare/tree/main#technologies)
- [Reproducing Project](https://github.com/EdidiongEsu/capital_bikeshare/tree/main#reproducing-project)
- [Dashboard](https://github.com/EdidiongEsu/capital_bikeshare/tree/main#dashboard)


## Project Architecture
![Alt text](https://github.com/EdidiongEsu/capital_bikeshare/blob/main/img/Bike%20architecture.gif)

The data architecture is an overview of the end-to-end pipeline which include:
- Ingesting of source dataset to google cloud storage
- Moving data and staging in a dataware house which is big query
- transforming the data using dbt via dbt cloud
- Creation of dashboard with Looker studio

## Dataset
The project's data source can be accessed [here](https://ride.capitalbikeshare.com/system-data)

Dataset columns from source:
- ride_id - Unique key for each ride
- rideable_type - Bike type used
- started_at – Includes start date and time
- ended_at – Includes end date and time
- start_station_name – Includes starting station name
- start_station_id - Unique id of start station
- end_station_name – Includes ending station name
- end_station_id - Unique id of ending station
- start_lat - Start Latitude of bike trip
- start_lng - Start Longitude of bike trip
- end_lat - Latitude the bike trips end
- end_lng - Longitude the bike trips end
- member_casual- Indicates whether user was a "registered" member (Annual Member, 30-Day Member or Day Key Member) or a "casual" rider (Single Trip, 24-Hour Pass, 3-Day Pass or 5-Day Pass)

## Technologies
- [Docker](https://www.docker.com/):- Containerization of applications -- build, share, run, and verify applications anywhere — without tedious environment configuration or management.
- [Google Cloud Storage](https://cloud.google.com/storage) GCS - Data Lake for storage
- [Google Cloud BigQuery](https://cloud.google.com/bigquery) - Data warehouse for analytical purposes
- [Terraform](https://www.terraform.io/) - Infrastructure as code (Infrastructure automation to provision and manage resources in any cloud or data center.)
- [Mage](https://docs.mage.ai/introduction/overview) -  Data and workflow orchestration 
- [Dbt](https://www.getdbt.com/)- For analytics engineering via data transformation
- [Looker studio](https://lookerstudio.google.com/) - Data Visualization

## Reproducing project
This section will give a thorough breakdown of how to reproduce project

### 1) Pre-requisites
1) Set up GCP account
2) Install terraform on machine via this [link](https://developer.hashicorp.com/terraform/install) and watch this [tutorial](https://www.youtube.com/watch?v=Y2ux7gq3Z0o&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=12&pp=iAQB) on terraform basics
3) Install Docker via this [link](https://docs.docker.com/engine/install/)

### 2) Google Cloud Platform (GCP)
- Setup up GCP free account if you don't have an account
- Create a new project and take note of the ID
- Set up service account

## Dashboard
The live dashboard can be viewed [here](https://lookerstudio.google.com/reporting/51073509-b2e1-4909-a20f-60d02f303c1d)

Two dashboard pages were created as summarized below:

![image](https://github.com/EdidiongEsu/capital_bikeshare/blob/main/img/Dash1.jpg)
![image](https://github.com/EdidiongEsu/capital_bikeshare/blob/main/img/Dash2.jpg)







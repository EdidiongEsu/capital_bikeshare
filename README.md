# Project Capital Bikeshare

## Overview
This project extracts, moves and analyzes DC's [Capital Bikeshare](https://ride.capitalbikeshare.com) data.

Where do Capital Bikeshare riders go? When do they ride? How far do they go? Which stations are most popular? What days of the week are most rides taken on? This project attempts to extract the data, move, store and analyze the insights to answer key questions about Washighton DC's Capital BikeShare.

## Project Objective
Succesfully move data from Source, transform and Visualize in a dashboard.
Key Deliverables:
- Create end to end pipeline to move data by batching to analytical warehouse
- Build analytical dashboard to showcase insights

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

## Project Architecture
![Alt text](https://github.com/EdidiongEsu/capital_bikeshare/blob/main/img/Bike%20architecture.gif)
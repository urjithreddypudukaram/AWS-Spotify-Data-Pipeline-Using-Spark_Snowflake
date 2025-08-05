# AWS-Spotify-Data-Pipeline-Using-Spark_Snowflake
This project demonstrates a fully automated ETL (Extract, Transform, Load) pipeline that extracts data from the Spotify API, processes it using AWS services, and loads it into Snowflake for further analytics and visualization.

## About DataSet/API
The API Contains information about music artist, album,and songs - [Spotify API](https://developer.spotify.com/documentation/web-api)

## Architecture Overview
![](https://github.com/urjithreddypudukaram/AWS-Spotify-Data-Pipeline-Using-Spark_Snowflake/blob/main/Architecture.png)

## ETL Workflow Breakdown:
1. Extract
Spotify API provides real-time data on tracks, artists, playlists, etc.
AWS CloudWatch triggers the pipeline daily via a scheduled event.
AWS Lambda fetches data from the Spotify API and stores the raw JSON into Amazon S3 (raw bucket).

3. Transform
When new data is added to the raw S3 bucket, it triggers a job.
AWS Glue, backed by Apache Spark, reads raw data and performs cleaning, structuring, and schema alignment.
The transformed data is written to a separate Amazon S3 (transformed bucket).

4. Load
Snowpipe automatically loads transformed data from S3 into Snowflake, using event-based triggers.
Snowflake serves as the data warehouse for storage and querying.
Power BI connects to Snowflake for building dashboards and visualizations.

## Tech Stack
1) Spotify API – Data source for music metadata.
2) AWS Lambda – Python-based serverless function for API data extraction.
3) Amazon S3 – Storage for both raw and transformed data.
4) AWS CloudWatch – Schedules daily pipeline execution.
5) AWS Glue + Apache Spark – Transforms raw JSON data into a structured format.
6) Snowpipe – Automates data loading into Snowflake from S3.
7) Snowflake – Cloud data warehouse for scalable storage and querying.



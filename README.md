# AWS-Spotify-Data-Pipeline-Using-Spark_Snowflake
This project demonstrates a fully automated ETL (Extract, Transform, Load) pipeline that extracts data from the Spotify API, processes it using AWS services, and loads it into Snowflake for further analytics and visualization.

# Tech Stack
1) Spotify API – Data source for music metadata.
2) AWS Lambda – Python-based serverless function for API data extraction.
3) Amazon S3 – Storage for both raw and transformed data.
4) AWS CloudWatch – Schedules daily pipeline execution.
5) AWS Glue + Apache Spark – Transforms raw JSON data into a structured format.
6) Snowpipe – Automates data loading into Snowflake from S3.
7) Snowflake – Cloud data warehouse for scalable storage and querying.

CREATE OR REPLACE DATABASE Spotify_db;

CREATE OR REPLACE STORAGE INTEGRATION s3_init
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = S3
    ENABLED = TRUE 
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::##########:role/snowflake_s3_connection'
    STORAGE_ALLOWED_LOCATIONS = ('s3://aws-spotify-etl-pipeline')
    COMMENT = 'Creating connection to s3'

DESC INTEGRATION s3_init;

CREATE OR REPLACE FILE FORMAT csv_fileformat
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
null_if = ('NULL','null')
empty_field_as_null = TRUE;

CREATE OR REPLACE STAGE spotify_stage
  URL='s3://aws-spotify-etl-pipeline/transformed_data/'
  STORAGE_INTEGRATION = s3_init
  FILE_FORMAT = csv_fileformat

LIST @spotify_stage;

CREATE OR REPLACE TABLE tbl_album (
    album_id STRING,
    name STRING,
    release_date DATE,
    total_tracks INT,
    url STRING 
);

CREATE OR REPLACE TABLE tbl_artists (
    artists_id STRING,
    name STRING,
    url STRING    
);


CREATE OR REPLACE TABLE tbl_songs (
    song_id STRING,
    song_name STRING,
    duration_ms INT,
    url STRING,
    popularity INT,
    song_added DATE,
    album_id STRING,
    artist_id STRING
);


COPY INTO tbl_album
FROM @spotify_stage/album_data/album_transformed_2025-08-04/run-1754321162750-part-r-00000;

COPY INTO tbl_songs
FROM @spotify_stage/songs_data/songs_transformed_2025-07-31/run-1753994342920-part-r-00000;

COPY INTO tbl_artists
FROM @spotify_stage/artist_data/artist_transformed_2025-08-04/run-1754321265341-part-r-00002;

CREATE OR REPLACE SCHEMA pipe;


CREATE OR REPLACE pipe spotify_db.pipe.tbl_songs_pipe
auto_ingest = TRUE
AS
COPY INTO spotify_db.public.tbl_songs
FROM @spotify_db.public.spotify_stage/songs_data;

CREATE OR REPLACE pipe spotify_db.pipe.tbl_artist_pipe
auto_ingest = TRUE
AS
COPY INTO spotify_db.public.tbl_artists
FROM @spotify_db.public.spotify_stage/artist_data;

CREATE OR REPLACE pipe spotify_db.pipe.tbl_album_pipe
auto_ingest = TRUE
AS
COPY INTO spotify_db.public.tbl_album
FROM @spotify_db.public.spotify_stage/album_data;

DESC pipe pipe.tbl_album_pipe

SELECT COUNT(*) FROM TBL_ALBUM;

SELECT COUNT(*) FROM TBL_ARTISTS;

SELECT COUNT(*) FROM TBL_SONGS;

SELECT SYSTEM$PIPE_STATUS('pipe.tbl_album_pipe')
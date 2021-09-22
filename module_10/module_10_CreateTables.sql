%hive
DROP TABLE IF EXISTS smakarov_staging.nobel_laureates;
CREATE EXTERNAL TABLE IF NOT EXISTS smakarov_staging.nobel_laureates(
      year                  INT
    , category              VARCHAR(255)
    , prize                 VARCHAR(255)
    , motivation            VARCHAR(255)
    , prize_share           VARCHAR(255)
    , laureate_id           INT
    , laureate_type         INT
    , full_name             VARCHAR(255)
    , bith_date             DATE
    , birth_city            VARCHAR(255)
    , birth_country         VARCHAR(255)
    , sex                   VARCHAR(255)
    , organization_name     VARCHAR(255)
    , organization_city     VARCHAR(255)
    , organization_country  VARCHAR(255)
    , death_date            DATE
    , death_city            VARCHAR(255)
    , death_country         VARCHAR(255)
)
COMMENT 'nobel-laureates.csv'
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE;


DROP TABLE IF EXISTS  smakarov_staging.countries;
CREATE EXTERNAL TABLE IF NOT EXISTS smakarov_staging.countries(
      country_name      VARCHAR(255)
    , region_name       VARCHAR(255)
    , population        INT
    , area              INT
    , pop_density       FLOAT
    , coast_line        FLOAT
    , net_migration     FLOAT
    , infant_mortality  FLOAT
    , gdp               INT
    , literacy          FLOAT
    , phones_per_1000   FLOAT
    , arable            FLOAT
    , crops             FLOAT
    , other             FLOAT
    , climate           INT
    , nirthrate         FLOAT
    , deathrate         FLOAT
    , agriculture       FLOAT
    , industry          FLOAT
    , service           FLOAT
)
COMMENT 'countries_of_the_world.csv'
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE;


DROP TABLE IF EXISTS smakarov_staging.cities;
CREATE EXTERNAL TABLE IF NOT EXISTS smakarov_staging.cities(
      country_code      VARCHAR(255)
    , city_name         VARCHAR(255)
    , accentcity_name   VARCHAR(255)
    , region_code       VARCHAR(255)
    , population        FLOAT
    , latitude          FLOAT
    , longitude         FLOAT
)
COMMENT 'worldcitiespop.csv'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

DROP TABLE IF EXISTS smakarov_staging.capital;
CREATE EXTERNAL TABLE IF NOT EXISTS  smakarov_staging.capital(
      country_ID        VARCHAR(255)
    , capital         VARCHAR(255)
)
COMMENT 'capital.json'
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;


DROP TABLE IF EXISTS smakarov_staging.continent;
CREATE EXTERNAL TABLE IF NOT EXISTS  smakarov_staging.continent(
      country_ID        VARCHAR(255)
    , continent         VARCHAR(255)
)
COMMENT 'continent.json'
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;


DROP TABLE IF EXISTS smakarov_staging.currency;
CREATE EXTERNAL TABLE IF NOT EXISTS smakarov_staging.currency(
      country_ID        VARCHAR(255)
    , currency          VARCHAR(255)
)
COMMENT 'currency.json'
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;


DROP TABLE IF EXISTS smakarov_staging.iso3;
CREATE EXTERNAL TABLE IF NOT EXISTS smakarov_staging.iso3(
      country_ID        VARCHAR(255)
    , iso3_code         VARCHAR(255)
)
COMMENT 'iso3.json'
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;


DROP TABLE IF EXISTS smakarov_staging.country;
CREATE EXTERNAL TABLE IF NOT EXISTS smakarov_staging.country(
      country_ID       VARCHAR(255)
    , country_name     VARCHAR(255)
)
COMMENT 'names.json'
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;


DROP TABLE IF EXISTS smakarov_staging.phone;
CREATE EXTERNAL TABLE IF NOT EXISTS smakarov_staging.phone(
      country_ID       VARCHAR(255)
    , phone            VARCHAR(255)
)
COMMENT 'phone.json'
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;
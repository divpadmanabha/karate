# karate
# A Sample Karate Project


This project is created as a sample to try out Karate Framework on a sample API service https://openweathermap.org/stations

Note: You need to register with the website to use their API

The following scenarios have been automated to demonstrate the use of Karate

# Scenario 1: 

Attempts registering a weather station without an API Key which would throw a HTTP.401

# Scenario 2: 

Attempts to register two stations with the following details to get HTTP.201

            "external_id": "DEMO_TEST001",
            "name": "Team Demo Test Station 001",
            "latitude": 33.33,
            "longitude": -122.43,
            "altitude": 222

            "external_id": "DEMO_TEST002",
            "name": "Team Demo Test Station 002",
            "latitude": 44.44,
            "longitude": -122.44,
            "altitude": 111

# Scenario 3: 

Use a HTTP GET verb to verify that the stations are persisted in the DB and the values are as per what was sent to create these resources in Scenario 2

# Scenario 4: 

Trigger a HTTP DELETE call on the stations registered and assert for HTTP.204

# Scenario 5: 

Repeat the HTTP DELETE call and assert for HTTP.404 to ensure there is a hard delete when the HTTP DELETE is called


# Instructions to run the project:

This is a maven project that uses minimal third party depenedencies. Once the project has been cloned the following maven goals can be run to test the project:

                mvn clean compile
                mvn test

# The test results:

The test results are generated in the form of a html report at  <project_directory>/target/surefire-reports/features.products.OpenWeatherTest.html



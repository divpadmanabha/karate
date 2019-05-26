Feature: Validating Weather Station Functionality  
  Background:
    * url 'http://api.openweathermap.org'

    
  	Scenario: Creating a new station with invalid APPID
    Given path '/data/3.0/stations'
    And param APPID = '45c55e92eb3a6c3525b72575'
    And request { "external_id": "SF_TEST1000","name": "Random-Test","latitude": 37.76,"longitude": -122.43,"altitude": 150}
    When method post
    Then status 401
    And match $ contains {"cod":401, "message": "Invalid API key. Please see http://openweathermap.org/faq#error401 for more info."}
    
    Scenario Outline: Creating a new station: <name>
    Given path '/data/3.0/stations'
    And param APPID = '2902e28057c55e92eb3a6c3525b72575'
    And header Content-Type = 'application/json'
    And request { "external_id": <external_id>,"name": <name>,"latitude": <latitude>,"longitude": <longitude>,"altitude": <altitude>}
    When method post
    Then status 201
    # response should NOT contain a key expected to be missing

    Examples:
        | external_id   | name   | latitude | longitude | altitude                                                      |
        | "RandomTestStation_89765"  | "Random-Test"      | 37.76   |     -122.43 |150|
        | "SFOTestStation_89765"  | "SFO-Test"      | 44.44   |     -122.44 |111|

    
  	Scenario Outline: Get All Stations and Validate the Station <external_id>
    Given path '/data/3.0/stations'
    Given param APPID = '2902e28057c55e92eb3a6c3525b72575'
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And match $..external_id contains [<external_id>]
    And match $..name contains [<name>] 

    Examples:
        | external_id   | name   |
        | "RandomTestStation_89765"  | "Random-Test"      |
        | "SFOTestStation_89765"  | "SFO-Test"      |
        
  
   Scenario Outline: Delete and Validate Station Ids <external_id>
    Given   path '/data/3.0/stations'
    Given param APPID = '2902e28057c55e92eb3a6c3525b72575'
    And header Content-Type = 'application/json'
    When method get
    * def externalid = <external_id>
    * def temp =  karate.jsonPath(response, "$[?(@.external_id=='"+ externalid +"')].id")
    * print temp
    Given path '/data/3.0/stations/'+temp[0]
    Given param APPID = '2902e28057c55e92eb3a6c3525b72575'
    When method delete
    Then status 204
    Given path '/data/3.0/stations/'+temp[0]
    Given param APPID = '2902e28057c55e92eb3a6c3525b72575'
    When method get
    Then status 404
    And match $ contains {"code":404001,"message":"Station not found"}
    Examples:
        | external_id   |
        | "RandomTestStation_89765"  |
        | "SFOTestStation_89765"  |
        
    
        
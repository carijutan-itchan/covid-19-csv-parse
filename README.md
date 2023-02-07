# Covid 19 Parse to Model

## Project Setup

### Git Repo Cloning and Setup

1. Fork this repo
2. Clone forked repo in your machine

   ```bash
   git@github.com:carijutan-itchan/covid-19-csv-parse.git
   ```
3. Go to the project root and bundle install for install gems

   ```bash
   bundle install
   ```
4. Create database and run migration

   ```bash
   bin/rails db:create db:migrate
   ```
5.  Go to root directory run the tasks that will parse the CSV to Model

  ```bash
   rake execute_parsing:csv_to_model
   ```

 6. Test if the app server will boot w/ no issues.

   ```bash
   bin/rails s -p 3016
   ```
 7. You can test this by using this API (GET METHOD)
   ```bash
   localhost:3016/top/confirmed
   ```
   
 ## For testing
 1. Also I used rspec for TDD/BDD
 2. Postman to test the API
 
    params: 
      - observation_date(yyyy-dd-mm)
      - max_results(number)
      
 3. This are the sample payload for testing
 
   ```bash
    {
        "observation_date": "2020-04-01T00:00:00.000Z",
        "countries": {
            "country": "Afghanistan",
            "confirmed": 237,
            "deaths": 4,
            "recovered": 5
        }
    }
   ```


## The goal of this project is to parse the CSV and save it to model

WHAT I DID:

  1. I used rake tasks to parse the CSV to model, I decided to implement it on tasks it seems not far from data migration.
  2. Creating a Service, Serializer, and Controller.
        - To align the design with the SOLID principle (Single Responsibility Protocol) I used a service that will implement the logic of the controller it is responsible for generating the record based on the parameters of the request. Serializer, this is for managing the JSON response to arrange the object response going to the user. Also Controller for me the responsibility of the controller is to receive the request and send the response to the user.
 

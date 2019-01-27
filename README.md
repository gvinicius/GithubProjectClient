# GitHubProjectClient

This is a simple Ruby app to fetch github projects by language and store it. Link: [GitHubProjectClient](https://githubprojectclient.herokuapp.com/)

* Ruby 2.3.1
* Rails 4.2.10
* MySQL 5.7.23
* Minitest
* Recommend using docker containers for MySQL in development
* See `config/database.yml` to setup the database environment variables to development and test

## Running tests Locally
```
rake db:create db:migrate RAILS_ENV=test
```
```
rake test
```


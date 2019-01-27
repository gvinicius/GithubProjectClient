# GitHubProjectClient

This is a simple Ruby app to fetch github projects by language and store it. Link: [GitHubProjectClient](https://githubprojectclient.herokuapp.com/)

* Ruby 2.3.1
* Rails 4.2.1
* MySQL 5.8.1
* Minitest
* Recommend using docker for MySQL in development

## Running tests Locally
```
rake db:create db:migrate RAILS_ENV=test
```
```
rake test
```


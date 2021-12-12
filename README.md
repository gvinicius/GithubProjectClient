# GitHubProjectClient

This is a simple Ruby app to fetch github projects by language and store it.

* Ruby 3.1.0
* Rails 6.1.4
* MySQL
* Minitest

## Running tests Locally
```
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=1234 -d mysql
docker start mysql

bundle exec rails db:create db:migrate RAILS_ENV=test
bundle exec rails test
```


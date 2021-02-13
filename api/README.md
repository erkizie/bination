# Bination:Api README

Setup api service:

* `docker-compose run --rm api gem install bundler`

* `docker-compose run --rm api bundle -j4`

* `docker-compose run --rm api bundle exec rails db:create`

* `docker-compose run --rm api bundle exec rails db:migrate`

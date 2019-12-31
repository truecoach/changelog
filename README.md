# Changelog

In progress / experimental.

An app to create a changelog from issue tracker story transitions.

## Dependencies

- Ruby (see Gemfile for required version)
- [Direnv](https://direnv.net/docs/installation.html)
- Postgres

## Local setup

```bash
$ cd path/to/this/app
$ cp .env.example .env
# STOP: Edit your .env to your specific ENV values. Instructions per key are inlined in the doc
$ cp .rspec.example .rspec
$ direnv allow
$ createuser postgres -s
$ createdb localhost
$ gem install bundler -v 1.17.3
$ bundle install
$ npm i yarn
$ yarn install
$ pg_ctl start # or start your postgres db another way
$ bundle exec rake db:setup
$ bundle exec rails s
```

## Local Development

### Tests

```bash
bundle exec rspec spec
```

### Receiving webhooks locally

```bash
cp .ngrok.example.yml .ngrok.yml
# STOP: Edit your .ngrok.yml file with your ngrok details
ngrok start -config=.ngrok.yml <<my-ngrok.yml-tunnel-name>>
```

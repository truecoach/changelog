# Changelog

An app to create a changelog from issue tracker story transitions. Currently only supports PivotalTracker transitions, and only reports to Slack.

## Dependencies

- Ruby (see Gemfile for required version)
- [Direnv](https://direnv.net/docs/installation.html)
- Postgres

## Adding a new Pivotal Tracker project

Once you've got this app running on a public server, simply add a new [activity webhook](https://www.pivotaltracker.com/help/articles/activity_webhook/) in
your PT project, e.g. `https://myapp.herokuapp.com/pivotal_tracker`.

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
$ bundle exec rake db:schema:load db:migrate
$ bundle exec rails s
```

## Local Development

### Tests

```bash
bundle exec rspec spec
```

### Receiving webhooks locally

1. Route external requests to your localhost via an ngrok tunnel.

```bash
cp .ngrok.example.yml .ngrok.yml
# STOP: Edit your .ngrok.yml file with your ngrok details
ngrok start -config=.ngrok.yml <<my-ngrok.yml-tunnel-name>>
```

2. [Create a webhook](https://www.pivotaltracker.com/help/articles/activity_webhook/) in PivotalTracker that points to your new ngrok domain.

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

require 'factory_bot'

require 'webmock/rspec'
require 'vcr'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include PivotalTrackerHttpMocks, :pt
  config.include SlackHttpMocks, :slack
  config.filter_rails_from_backtrace!
end

VCR.configure do |config|
  config.cassette_library_dir = "support/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

FB = FactoryBot

# rollback any changes to the ENV object after the scenario
def let_env
  before do
    @_old_env = ENV.each_with_object(Hash.new) { |(k, v), acc| acc[k] = v }

    yield
  end

  after do
    keys_to_delete = ENV.select { |k, v| !@_old_env.keys.include?(k) }.keys
    keys_to_delete.each { |key| ENV.delete(key) }
    ENV.each { |k, v| ENV[k] = @_old_env[k] }
  end
end

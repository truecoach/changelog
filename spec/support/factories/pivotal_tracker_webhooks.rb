FactoryBot.define do
  factory :pivotal_tracker_webhook, class: Hash do
    trait :accepted do
      fixture { 'accepted.json' }
    end

    trait :restarted do
      fixture { 'restarted.json' }
    end

    trait :chore do
      after(:build) do |hash|
        hash['primary_resources'].map { |pr| pr['story_type'] = 'chore' }
      end
    end

    skip_create

    initialize_with do
      filepath = "spec/support/fixtures/pivotal_tracker_webhooks/#{fixture}"

      JSON.parse(File.read(filepath), object_class: Hash)
    end
  end
end

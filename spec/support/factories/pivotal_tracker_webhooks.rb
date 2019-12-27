FactoryBot.define do
  factory :pivotal_tracker_webhook, class: Hash do
    trait :accepted do
      fixture { 'accepted.json' }
    end

    skip_create

    initialize_with do
      filepath = "spec/support/fixtures/pivotal_tracker_webhooks/#{fixture}"

      JSON.parse(File.read(filepath), object_class: Hash)
    end
  end
end

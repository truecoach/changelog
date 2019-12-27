FactoryBot.define do
  factory :pivotal_tracker_http_response, class: String do
    trait :story do
      fixture { 'story.json' }
    end

    skip_create

    initialize_with do
      filepath = "spec/support/fixtures/pivotal_tracker_http_responses/#{fixture}"

      File.read(filepath)
    end
  end
end

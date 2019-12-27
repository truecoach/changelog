module PivotalTrackerHttpMocks
  extend RSpec::SharedContext

  let(:pivotal_tracker_story_response) { FB.build(:pivotal_tracker_http_response, :story) }

  before(:each) do
    stub_request(:get, /pivotaltracker(.*)stories/).to_return(
      body: pivotal_tracker_story_response,
      headers: {
        'Content-Type' => 'application/json; charset=utf-8'
      }
    )
  end
end

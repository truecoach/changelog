module SlackHttpMocks
  extend RSpec::SharedContext

  let(:fired_slack_hooks) { [] }

  before(:each) do
    stub_request(:post, /hooks\.slack\.com/).to_return do |request|
      fired_slack_hooks << request.body

      { body: request.body }
    end
  end
end

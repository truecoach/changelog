require 'rails_helper'

RSpec.describe 'POST /pivotal_tracker', :pt, :slack do
  let(:params) { FB.build(:pivotal_tracker_webhook, :accepted) }

  let_env do
    ENV['PT_BASIC_NAME'] = 'test'
    ENV['PT_BASIC_PSW'] = 'test'
  end

  def ping
    authorization = ActionController::HttpAuthentication::Basic.encode_credentials(ENV['PT_BASIC_NAME'], ENV['PT_BASIC_PSW'])

    post pivotal_tracker_path, params: params, headers: { 'HTTP_AUTHORIZATION' => authorization }
  end

  it 'is successful' do
    ping

    expect(response.status).to eq(201)
  end

  it 'sends a slack message' do
    expect { ping }.to change { fired_slack_hooks.size }.by(1)
  end
end

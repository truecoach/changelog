require 'rails_helper'

RSpec.describe 'POST /pivotal_tracker', :pt, :slack do
  def ping
    post pivotal_tracker_path, params: params
  end

  context 'given a Pivotal Tracker story has been accepted' do
    let(:params) { FB.build(:pivotal_tracker_webhook, :accepted) }

    it 'is successful' do
      ping

      expect(response.status).to eq(201)
    end

    it 'sends a slack message that the story has deployed' do
      expect { ping }.to change { fired_slack_hooks.size }.by(1)

      msg = fired_slack_hooks.last

      expect(msg).to match(/deployed/)
    end
  end

  context 'given a Pivotal Tracker story has been accepted, then restarted' do
    let(:params) { FB.build(:pivotal_tracker_webhook, :restarted) }

    it 'is successful' do
      ping

      expect(response.status).to eq(201)
    end

    it 'sends a slack message that the story should not be considered deployed' do
      expect { ping }.to change { fired_slack_hooks.size }.by(1)

      msg = fired_slack_hooks.last

      expect(msg).to match(/rolled(.*)back/i)
    end
  end
end

require 'rails_helper'

RSpec.describe PivotalTrackerEvent do
  let(:event) { described_class.new(params) }

  describe '#report?' do
    context 'given an accepted story' do
      let(:params) { FB.build(:pivotal_tracker_webhook, :accepted) }

      it 'returns true' do
        expect(event.report?).to eq(true)
      end
    end

    context 'given a restarted story' do
      let(:params) { FB.build(:pivotal_tracker_webhook, :restarted) }

      it 'returns true' do
        expect(event.report?).to eq(true)
      end
    end
  end
end

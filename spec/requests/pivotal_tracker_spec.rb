require 'rails_helper'

RSpec.describe 'POST /pivotal_tracker' do
  def ping
    post pivotal_tracker_path
  end

  it 'is successful' do
    ping

    expect(response.status).to eq(200)
  end
end

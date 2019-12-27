class PivotalTrackerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    render json: {}, status: 200
  end
end

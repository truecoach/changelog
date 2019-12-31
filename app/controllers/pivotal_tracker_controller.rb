class PivotalTrackerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    return unless handle?

    action = PivotalTrackerWebhookHandler.new(permitted_params)

    if action.save
      render json: { body: 'Success' }, status: 201
    else
      render json: { error: 'Failed to handle webhook', status: 420 }
    end
  end

  private

  def permitted_params
    params.permit!.to_h
  end

  def handle?
    !Rails.env.production? || ENV['ENABLE_PIVOTAL_TRACKER'] == 'true'
  end
end
